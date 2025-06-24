// UserProfileController.java
package com.hst.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.security.Principal;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;

// If using @Autowired or Repository
import org.springframework.beans.factory.annotation.Autowired;

import com.hst.entity.Payment;
import com.hst.entity.User;
import com.hst.repository.UserRepository;

import com.hst.entity.User;
import com.hst.repository.UserRepository;
import com.hst.response.ApiResponse;
import com.hst.security.JwtTokenProvider;
import com.hst.service.PaymentService;
import com.hst.service.UserService;

import jakarta.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/user")
public class UserProfileController {
	
	@Autowired
	private PaymentService paymentService;
	
	@Autowired
	private UserService userService;
	@Autowired
	private UserRepository userRepository;
	@Autowired
	private JwtTokenProvider jwtTokenProvider;

	@GetMapping("/profile")
	public User getProfile(HttpServletRequest request) {
		String token = jwtTokenProvider.resolveToken(request);
		String mobile = jwtTokenProvider.getUsernameFromToken(token);
		return userRepository.findByMobile(mobile).orElse(null);
	}

	@PostMapping("/update")
	public ResponseEntity<ApiResponse<String>> updateProfile(@RequestHeader("Authorization") String authHeader,
			@RequestBody User user) {
		String token = authHeader.replace("Bearer ", "");
		String mobile = jwtTokenProvider.getUsernameFromToken(token);

		User existingUser = userRepository.findByMobile(mobile).orElseThrow();

		// Update editable fields only
		existingUser.setAddress(user.getAddress());
		existingUser.setEducation(user.getEducation());
		existingUser.setOccupation(user.getOccupation());
		existingUser.setBloodGroup(user.getBloodGroup());
		existingUser.setMaritalStatus(user.getMaritalStatus());

		userRepository.save(existingUser);
		return ResponseEntity.ok(new ApiResponse<>(true, "प्रोफ़ाइल सफलतापूर्वक सहेजी गई।", null));
	}

	@PostMapping("/upload-image")
	public ResponseEntity<?> uploadProfileImage(@RequestParam("image") MultipartFile image, Principal principal) {
		String mobile = principal.getName();
		Optional<User> optionalUser = userRepository.findByMobile(mobile);
		if (optionalUser.isEmpty())
			return ResponseEntity.badRequest().body("User not found");

		User user = optionalUser.get();

		try {
			String fileName = UUID.randomUUID() + "_" + image.getOriginalFilename();
			Path storageDir = Paths.get("C:/data/uploads/images/profile_images");
			Files.createDirectories(storageDir);
			Path filePath = storageDir.resolve(fileName);
			Files.write(filePath, image.getBytes());

			String publicUrl = "/images/profile_images/" + fileName;
			user.setProfileImagePath(publicUrl);
			userRepository.save(user);

			return ResponseEntity.ok(Map.of("imagePath", publicUrl));
		} catch (IOException e) {
			return ResponseEntity.status(500).body("Failed to upload image");
		}
	}
	@GetMapping("/payments")
	public ResponseEntity<List<Payment>> getUserPayments(Authentication auth) {
	    String mobile = auth.getName();
	    User user = userRepository.findByMobile(mobile).orElseThrow();
	    List<Payment> payments = paymentService.getPaymentsByUserId(user.getId());
	    return ResponseEntity.ok(payments);
	}

}
