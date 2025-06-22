package com.hst.controller;

import com.hst.dto.LoginRequest;
import com.hst.entity.User;
import com.hst.repository.UserRepository;
import com.hst.security.JwtTokenProvider;
import com.hst.service.RegistrationNumberService;

import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.*;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.core.Authentication;
import java.util.Map;
import java.util.Optional;

import com.hst.response.ApiResponse;

@RestController
@RequestMapping("/api/auth/")
public class AuthController {

	@Autowired
	private RegistrationNumberService registrationNumberService;
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
	    if (!user.isApproved()) {
	        return ResponseEntity.badRequest().body(new ApiResponse<>(false, "आपका पंजीकरण अनुमोदित नहीं है।", null));
	    }

	    authenticationManager.authenticate(
	        new UsernamePasswordAuthenticationToken(request.getMobile(), request.getPassword())
	    );

	    String token = jwtTokenProvider.generateToken(request.getMobile());

	    // ✅ Set token in HttpOnly Cookie
	    Cookie cookie = new Cookie("authToken", token);
	    cookie.setHttpOnly(true);
	    cookie.setPath("/");
	    cookie.setMaxAge(7 * 24 * 60 * 60); // 7 days
	    response.addCookie(cookie);

	    return ResponseEntity.ok(new ApiResponse<>(true, user.getFullName(), Map.of("token", token)));
	}

	@PostMapping("/register")
	public ResponseEntity<ApiResponse<Map<String, String>>> register(@RequestBody User req) {
		if (userRepository.existsByMobile(req.getMobile())) {
			return ResponseEntity.badRequest().body(new ApiResponse<>(false, "मोबाइल नंबर पहले से पंजीकृत है।", null));
		}

		User user = new User();

		if (req.getMobile() != null)
			user.setMobile(req.getMobile());
		if (req.getPassword() != null)
			user.setPassword(passwordEncoder.encode(req.getPassword()));
		if (req.getFullName() != null)
			user.setFullName(req.getFullName());
		if (req.getFatherName() != null)
			user.setFatherName(req.getFatherName());
		if (req.getGotra() != null)
			user.setGotra(req.getGotra());
		if (req.getDateOfBirth() != null)
			user.setDateOfBirth(req.getDateOfBirth());
		if (req.getGender() != null)
			user.setGender(req.getGender());
		if (req.getAddress() != null)
			user.setAddress(req.getAddress());
		if (req.getEmail() != null)
			user.setEmail(req.getEmail());
		if (req.getEducation() != null)
			user.setEducation(req.getEducation());
		if (req.getOccupation() != null)
			user.setOccupation(req.getOccupation());
		if (req.getHomeDistrict() != null)
			user.setHomeDistrict(req.getHomeDistrict());
		if (req.getAadharNumber() != null)
			user.setAadharNumber(req.getAadharNumber());
		if (req.getBloodGroup() != null)
			user.setBloodGroup(req.getBloodGroup());
		if (req.getMaritalStatus() != null)
			user.setMaritalStatus(req.getMaritalStatus());
		if (req.getOrganizationAffiliation() != null)
			user.setOrganizationAffiliation(req.getOrganizationAffiliation());
		if (req.getContribution() != null)
			user.setContribution(req.getContribution());
		if (req.isAgreeToTerms())
			user.setAgreeToTerms(true);
		
			user.setRole("USER");
		

		user.setApproved(false); // Approval required

		String regNo = registrationNumberService.generateRegistrationNumber();
		user.setRegistrationNo(regNo);
		userRepository.save(user);

		return ResponseEntity.ok(new ApiResponse<>(true,
				"आपकी पंजीकरण अनुरोध सफलतापूर्वक सबमिट हो गया है, कृपया अनुमोदन की प्रतीक्षा करें।", null));
	}
}
