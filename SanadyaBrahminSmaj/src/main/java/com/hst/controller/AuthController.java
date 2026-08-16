package com.hst.controller;

import com.hst.dto.LoginRequest;
import com.hst.dto.RegistrationRequest;
import com.hst.entity.PasswordResetRequest;
import com.hst.entity.User;
import com.hst.repository.UserRepository;
import com.hst.response.ApiResponse;
import com.hst.security.JwtTokenProvider;
import com.hst.service.CityVillageMasterService;
import com.hst.service.CloudinaryService;
import com.hst.service.PasswordResetRequestService;
import com.hst.service.RegistrationNumberService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.http.ResponseCookie;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;
import jakarta.validation.Valid;
import org.springframework.validation.BindingResult;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.http.*;
import org.springframework.web.multipart.MultipartFile;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@RestController
@RequestMapping("/api/auth/")
public class AuthController {
	private static final Logger log = LoggerFactory.getLogger(AuthController.class);

	private final CloudinaryService cloudinaryService;
	private final PasswordResetRequestService passwordResetRequestService;
	private final RegistrationNumberService registrationNumberService;
	private final CityVillageMasterService cityVillageMasterService;
	private final AuthenticationManager authenticationManager;
	private final JwtTokenProvider jwtTokenProvider;
	private final UserRepository userRepository;
	private final PasswordEncoder passwordEncoder;

	public AuthController(AuthenticationManager authenticationManager, JwtTokenProvider jwtTokenProvider,
			UserRepository userRepository, PasswordEncoder passwordEncoder,
			CloudinaryService cloudinaryService, PasswordResetRequestService passwordResetRequestService,
			RegistrationNumberService registrationNumberService, CityVillageMasterService cityVillageMasterService) {
		this.authenticationManager = authenticationManager;
		this.jwtTokenProvider = jwtTokenProvider;
		this.userRepository = userRepository;
		this.passwordEncoder = passwordEncoder;
		this.cloudinaryService = cloudinaryService;
		this.passwordResetRequestService = passwordResetRequestService;
		this.registrationNumberService = registrationNumberService;
		this.cityVillageMasterService = cityVillageMasterService;
	}

	private static final String APPROVED = "स्वीकृत";
	private static final String APPROVAL_PENDING = "प्रक्रिया में";
	private static final long COOKIE_MAX_AGE_SECONDS = 7L * 24 * 60 * 60;

	private ResponseEntity<ApiResponse<Map<String, Object>>> fieldError(String field, String message) {
		Map<String, Object> errors = new HashMap<>();
		errors.put(field, message);
		return ResponseEntity.badRequest().body(new ApiResponse<>(false, message, errors));
	}

	@PostMapping("/login")
	public ResponseEntity<ApiResponse<Map<String, String>>> login(@RequestBody LoginRequest request,
			HttpServletResponse response, HttpServletRequest httpRequest) {
		Optional<User> optionalUser = userRepository.findByMobile(request.getMobile());
		if (optionalUser.isEmpty()) {
			return ResponseEntity.badRequest().body(new ApiResponse<>(false, "मोबाइल नंबर पंजीकृत नहीं है।", null));
		}

		User user = optionalUser.get();
		if (!APPROVED.equals(user.getApproved())) {
			return ResponseEntity.badRequest()
					.body(new ApiResponse<>(false, "आपका पंजीकरण अनुमोदित नहीं है।कृपया प्रतीक्षा करें।", null));
		}
		try {
			authenticationManager
					.authenticate(new UsernamePasswordAuthenticationToken(request.getMobile(), request.getPassword()));
		} catch (BadCredentialsException e) {
			return ResponseEntity.badRequest()
					.body(new ApiResponse<>(false, "लॉगिन करने में विफल . यूजरनेम पासवर्ड गलत है।", null));
		}

		String token = jwtTokenProvider.generateToken(request.getMobile(), List.of(user.getRole()));

		ResponseCookie.ResponseCookieBuilder cookieBuilder = ResponseCookie.from("authToken", token)
				.httpOnly(true)
				.path("/")
				.maxAge(COOKIE_MAX_AGE_SECONDS)
				.sameSite("Lax");
		if (httpRequest.isSecure()) {
			cookieBuilder.secure(true);
		}
		response.addHeader("Set-Cookie", cookieBuilder.build().toString());

		return ResponseEntity.ok(new ApiResponse<>(true, user.getFullName(), null));
	}

	@PostMapping(value = "/register", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
	public ResponseEntity<ApiResponse<Map<String, Object>>> register(
			@Valid @RequestPart("data") RegistrationRequest req,
			BindingResult bindingResult,
			@RequestPart(value = "file", required = false) MultipartFile file) {
		if (bindingResult.hasErrors()) {
			Map<String, Object> errors = new HashMap<>();
			bindingResult.getFieldErrors().forEach(error -> errors.put(error.getField(), error.getDefaultMessage()));
			return ResponseEntity.badRequest().body(new ApiResponse<>(false, "कृपया सभी आवश्यक फ़ील्ड सही से भरें।", errors));
		}

		if (userRepository.existsByMobile(req.getMobile())) {
			return ResponseEntity.badRequest().body(new ApiResponse<>(false, "मोबाइल नंबर पहले से पंजीकृत है।", null));
		}

		if (req.getCity() != null && !req.getCity().isBlank()
				&& !cityVillageMasterService.isValidCityOrVillage(req.getCity())) {
			return fieldError("city", "दर्ज किया गया शहर/गाँव मान्य नहीं है। कृपया सूची से चुनें।");
		}
		if (req.getHomeDistrict() != null && !req.getHomeDistrict().isBlank()
				&& !cityVillageMasterService.isValidCityOrVillage(req.getHomeDistrict())) {
			return fieldError("homeDistrict", "दर्ज किया गया जिला मान्य नहीं है। कृपया सूची से चुनें।");
		}

		User user = new User();
		user.setCreatedDate(LocalDate.now());
		user.setMobile(req.getMobile());
		user.setPassword(passwordEncoder.encode(req.getPassword()));
		user.setFullName(req.getFullName());
		user.setFatherName(req.getFatherName());
		user.setGotra(req.getGotra());
		user.setDateOfBirth(req.getDateOfBirth());
		user.setGender(req.getGender());
		user.setAddress(req.getAddress());
		user.setEmail(req.getEmail());
		user.setEducation(req.getEducation());
		user.setOccupation(req.getOccupation());
		user.setHomeDistrict(req.getHomeDistrict());
		user.setAadharNumber(req.getAadharNumber());
		user.setBloodGroup(req.getBloodGroup());
		user.setMaritalStatus(req.getMaritalStatus());
		user.setOrganizationAffiliation(req.getOrganizationAffiliation());
		user.setContribution(req.getContribution());
		user.setAgreeToTerms(req.isAgreeToTerms());
		user.setRole("USER");
		user.setApproved(APPROVAL_PENDING);
		user.setRegistrationNo(registrationNumberService.generateRegistrationNumber());

		// 🖼️ Upload profile image together with registration (no auth needed yet)
		if (file != null && !file.isEmpty()) {
			try {
				String imageUrl = cloudinaryService.uploadFile(file, "profile_images");
				user.setProfileImagePath(imageUrl);
			} catch (IOException e) {
				log.warn("⚠️ प्रोफ़ाइल छवि अपलोड विफल (पंजीकरण जारी): {}", e.getMessage());
			}
		}

		userRepository.save(user);

		Map<String, Object> responseData = new HashMap<>();
		responseData.put("userId", user.getId());
		responseData.put("registrationNo", user.getRegistrationNo());

		return ResponseEntity.ok(new ApiResponse<>(true,
				"आपकी पंजीकरण अनुरोध सफलतापूर्वक सबमिट हो गया है, कृपया अनुमोदन की प्रतीक्षा करें।", responseData));
	}

	@PostMapping("/upload-profile-image")
	public ResponseEntity<?> uploadProfileImage(@RequestParam("file") MultipartFile file,
			@RequestParam("userId") Long userId, Authentication authentication) {

		if (file.isEmpty()) {
			return ResponseEntity.badRequest().body(Map.of("message", "⚠️ फ़ाइल खाली है"));
		}

		// IDOR FIX: Verify the userId matches the authenticated user
		String mobile = authentication.getName();
		Optional<User> loggedInUserOpt = userRepository.findByMobile(mobile);
		if (loggedInUserOpt.isEmpty()) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body(Map.of("message", "यूज़र नहीं मिला"));
		}
		User loggedInUser = loggedInUserOpt.get();
		if (!loggedInUser.getId().equals(userId)) {
			return ResponseEntity.status(HttpStatus.FORBIDDEN).body(Map.of("message", "⚠️ आप केवल अपनी छवि अपलोड कर सकते हैं"));
		}

		try {
			 String imageUrl = cloudinaryService.uploadFile(file, "profile_images");
			// Update user
			loggedInUser.setProfileImagePath(imageUrl);
			userRepository.save(loggedInUser);

			return ResponseEntity.ok(
					Map.of("message", "✅ छवि सफलतापूर्वक अपलोड हुई", "filePath", imageUrl));

		} catch (IOException e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body(Map.of("message", "❌ फ़ाइल सेव करने में त्रुटि", "error", e.getMessage()));
		}
	}

	@PostMapping("/forgot-password")
	public ResponseEntity<?> requestPasswordReset(@RequestParam String mobile, @RequestParam String newPassword,
			@RequestParam(required = false) String reason) {

		Optional<User> userOpt = userRepository.findByMobile(mobile);
		if (userOpt.isEmpty()) {
			return ResponseEntity.badRequest().body(Map.of("message", "मोबाइल नंबर पंजीकृत नहीं है।"));
		}

		PasswordResetRequest req = new PasswordResetRequest();
		req.setMobile(mobile);
		req.setNewPassword(passwordEncoder.encode(newPassword));
		req.setReason(reason);
		req.setStatus("PENDING");
		req.setRequestDate(LocalDateTime.now());
		passwordResetRequestService.save(req);

		return ResponseEntity
				.ok(Map.of("message", "पासवर्ड रीसेट अनुरोध भेज दिया गया है। कृपया अनुमोदन की प्रतीक्षा करें।"));
	}

	@PostMapping("/makeAdmin")
	public ResponseEntity<ApiResponse<Map<String, String>>> approveUser() {
		Optional<User> userOpt = userRepository.findByMobile("8089101719");
		if (userOpt.isEmpty()) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND)
					.body(new ApiResponse<>(false, "यूज़र नहीं मिला।", null));
		}
		User user = userOpt.get();
		user.setApprovedRejectDate(LocalDate.now());
		user.setRole("ADMIN");
		user.setApproved(APPROVED);
		userRepository.save(user);
		return ResponseEntity.ok(new ApiResponse<>(true, "यूज़र को सफलतापूर्वक अनुमोदित किया गया।", null));
	}
	@GetMapping("/me")
	public ResponseEntity<ApiResponse<Map<String, Object>>> me(Authentication authentication) {

	    if (authentication == null || !authentication.isAuthenticated()) {
	        return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
	                .body(new ApiResponse<>(false, "Not authenticated", null));
	    }

	    String mobile = authentication.getName();

	    User user = userRepository.findByMobile(mobile)
	            .orElseThrow(() -> new RuntimeException("User not found"));

	    Map<String, Object> data = new HashMap<>();
	    data.put("mobile", user.getMobile());
	    data.put("fullName", user.getFullName());
	    data.put("role", user.getRole());

	    return ResponseEntity.ok(
	            new ApiResponse<>(true, "User info", data)
	    );
	}

}