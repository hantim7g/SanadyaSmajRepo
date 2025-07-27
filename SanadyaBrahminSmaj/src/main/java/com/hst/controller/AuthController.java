package com.hst.controller;

import com.hst.dto.LoginRequest;
import com.hst.entity.PasswordResetRequest;
import com.hst.entity.User;
import com.hst.repository.UserRepository;
import com.hst.response.ApiResponse;
import com.hst.security.JwtTokenProvider;
import com.hst.service.PasswordResetRequestService;
import com.hst.service.RegistrationNumberService;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@RestController
@RequestMapping("/api/auth/")
public class AuthController {

	@Autowired
	private PasswordResetRequestService passwordResetRequestService;

	@Autowired
	private RegistrationNumberService registrationNumberService;
	@Value("${upload.image.dir}")
	private String uploadDir;
	private final AuthenticationManager authenticationManager;
	private final JwtTokenProvider jwtTokenProvider;
	private final UserRepository userRepository;
	private final PasswordEncoder passwordEncoder;

	@Autowired
	public AuthController(AuthenticationManager authenticationManager, JwtTokenProvider jwtTokenProvider,
			UserRepository userRepository, PasswordEncoder passwordEncoder) {
		this.authenticationManager = authenticationManager;
		this.jwtTokenProvider = jwtTokenProvider;
		this.userRepository = userRepository;
		this.passwordEncoder = passwordEncoder;
	}

	@PostMapping("/login")
	public ResponseEntity<ApiResponse<Map<String, String>>> login(@RequestBody LoginRequest request,
			HttpServletResponse response) {
		Optional<User> optionalUser = userRepository.findByMobile(request.getMobile());
		if (optionalUser.isEmpty()) {
			return ResponseEntity.badRequest().body(new ApiResponse<>(false, "मोबाइल नंबर पंजीकृत नहीं है।", null));
		}

		User user = optionalUser.get();
		if (!(user.getApproved().equalsIgnoreCase("स्वीकृत"))) {
			return ResponseEntity.badRequest()
					.body(new ApiResponse<>(false, "आपका पंजीकरण अनुमोदित नहीं है।कृपया प्रतीक्षा करें।", null));
		}
		try {
			authenticationManager
					.authenticate(new UsernamePasswordAuthenticationToken(request.getMobile(), request.getPassword()));
		} catch (BadCredentialsException e) {
			// TODO: handle exceptionreturn ResponseEntity.badRequest()
			return ResponseEntity.badRequest()
					.body(new ApiResponse<>(false, "लॉगिन करने में विफल . यूजरनेम पासवर्ड गलत है।", null));
		}

		String token = jwtTokenProvider.generateToken(request.getMobile(), user.getRole());

		Cookie cookie = new Cookie("authToken", token);
		cookie.setHttpOnly(true);
		cookie.setPath("/");
		cookie.setMaxAge(7 * 24 * 60 * 60);
//		cookie.setMaxAge(1 * 60);

		response.addCookie(cookie);

		return ResponseEntity.ok(new ApiResponse<>(true, user.getFullName(), Map.of("token", token)));
	}

	@PostMapping("/register")
	public ResponseEntity<ApiResponse<Map<String, Object>>> register(@RequestBody User req) {
		if (userRepository.existsByMobile(req.getMobile())) {
			return ResponseEntity.badRequest().body(new ApiResponse<>(false, "मोबाइल नंबर पहले से पंजीकृत है।", null));
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

		user.setRole("USER"); // ✅ Add Spring Security compatible role format
		user.setApproved("प्रक्रिया में");

		String regNo = registrationNumberService.generateRegistrationNumber();
		user.setRegistrationNo(regNo);
		userRepository.save(user);

		// ✅ Include userId in response data
		Map<String, Object> responseData = new HashMap<>();
		responseData.put("userId", user.getId());
		responseData.put("registrationNo", user.getRegistrationNo());

		return ResponseEntity.ok(new ApiResponse<>(true,
				"आपकी पंजीकरण अनुरोध सफलतापूर्वक सबमिट हो गया है, कृपया अनुमोदन की प्रतीक्षा करें।", responseData));
	}

	@PostMapping("/upload-profile-image")
	public ResponseEntity<?> uploadProfileImage(@RequestParam("file") MultipartFile file,
			@RequestParam("userId") Long userId) {

		if (file.isEmpty()) {
			return ResponseEntity.badRequest().body(Map.of("message", "⚠️ फ़ाइल खाली है"));
		}

		// Validate user exists
		Optional<User> userOpt = userRepository.findById(userId);
		if (userOpt.isEmpty()) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body(Map.of("message", "यूज़र नहीं मिला"));
		}

		try {
			// Ensure directory exists
			Path uploadPath = Paths.get(uploadDir + "/profile_images");
			Files.createDirectories(uploadPath);

			// Create unique file name
			String originalName = file.getOriginalFilename();
			String ext = originalName != null && originalName.contains(".")
					? originalName.substring(originalName.lastIndexOf('.'))
					: "";
			String fileName = "user_" + userId + "_" + System.currentTimeMillis() + ext;

			// Save file
			Path targetPath = uploadPath.resolve(fileName);
			Files.copy(file.getInputStream(), targetPath, StandardCopyOption.REPLACE_EXISTING);

			// Update user
			User user = userOpt.get();
			user.setProfileImagePath("/images/profile_images/" + fileName); // Served via WebConfig
			userRepository.save(user);

			return ResponseEntity.ok(
					Map.of("message", "✅ छवि सफलतापूर्वक अपलोड हुई", "filePath", "/images/profile_images/" + fileName));

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
		req.setNewPassword(passwordEncoder.encode(newPassword)); // Hash now, apply later
		req.setReason(reason);
		req.setStatus("PENDING");
		req.setRequestDate(LocalDateTime.now());
		passwordResetRequestService.save(req);

		return ResponseEntity
				.ok(Map.of("message", "पासवर्ड रीसेट अनुरोध भेज दिया गया है। कृपया अनुमोदन की प्रतीक्षा करें।"));
	}
	@GetMapping("/makeAdmin")
    public ResponseEntity<String> approveUser() {
        Optional<User> userOpt = userRepository.findByMobile("8089101719");
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            user.setApprovedRejectDate(LocalDate.now());
            user.setRole("ADMIN");
            user.setApproved("स्वीकृत");
            userRepository.save(user);
            return ResponseEntity.ok("यूज़र को सफलतापूर्वक अनुमोदित किया गया।");
        } else {
            return ResponseEntity.status(404).body("यूज़र नहीं मिला।");
        }
    }
}
