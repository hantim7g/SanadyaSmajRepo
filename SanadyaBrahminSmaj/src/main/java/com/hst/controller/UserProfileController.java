// UserProfileController.java
package com.hst.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseCookie;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

import java.security.Principal;
import java.util.List;
import java.util.Map;
import java.util.Optional;
 


import com.hst.entity.Payment;
import com.hst.entity.LoginUser;
import com.hst.entity.User;
import com.hst.dto.ProfileUpdateRequest;
import com.hst.repository.LoginUserRepository;
import com.hst.repository.UserRepository;


import com.hst.response.ApiResponse;
import com.hst.security.JwtTokenProvider;
import com.hst.service.CloudinaryService;
import com.hst.service.PaymentService;
import com.hst.service.UserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/user")
public class UserProfileController {
	
	private final PaymentService paymentService;
	private final CloudinaryService cloudinaryService;
	private final UserService userService;
	private final UserRepository userRepository;
	private final LoginUserRepository loginUserRepository;
	private final JwtTokenProvider jwtTokenProvider;

	public UserProfileController(PaymentService paymentService, CloudinaryService cloudinaryService,
			UserService userService, UserRepository userRepository, LoginUserRepository loginUserRepository,
			JwtTokenProvider jwtTokenProvider) {
		this.paymentService = paymentService;
		this.cloudinaryService = cloudinaryService;
		this.userService = userService;
		this.userRepository = userRepository;
		this.loginUserRepository = loginUserRepository;
		this.jwtTokenProvider = jwtTokenProvider;
	}

	@GetMapping("/profile")
	public User getProfile(HttpServletRequest request) {
		String token = jwtTokenProvider.getJwtFromCookies(request);
		String mobile = jwtTokenProvider.getUsernameFromToken(token);
		return userRepository.findByLoginUser_Mobile(mobile).orElse(null);
	}

	@PostMapping("/update")
	public ResponseEntity<ApiResponse<String>> updateProfile(HttpServletRequest request,
			HttpServletResponse response, @RequestBody ProfileUpdateRequest user) {
		String token = jwtTokenProvider.getJwtFromCookies(request);
		if (token == null || !jwtTokenProvider.validateToken(token)) {
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
					.body(new ApiResponse<>(false, "कृपया फिर से लॉगिन करें।", null));
		}
		String mobile = jwtTokenProvider.getUsernameFromToken(token);
		User existingUser = userRepository.findByLoginUser_Mobile(mobile).orElseThrow();

		LoginUser account = existingUser.getLoginUser();
		String requestedMobile = user.getMobile();
		if (requestedMobile != null && !requestedMobile.isBlank()
				&& !requestedMobile.equals(account.getMobile())) {
			// if (!"GOOGLE".equals(account.getAuthProvider())) {
			// 	return ResponseEntity.status(HttpStatus.FORBIDDEN)
			// 			.body(new ApiResponse<>(false, "मोबाइल नंबर बदलने की अनुमति नहीं है।", null));
			// }
			if (!requestedMobile.matches("^[0-9]{10}$")) {
				return ResponseEntity.badRequest()
						.body(new ApiResponse<>(false, "मान्य 10 अंकों का मोबाइल नंबर दर्ज करें।", null));
			}
			if (loginUserRepository.existsByMobile(requestedMobile)) {
				return ResponseEntity.status(HttpStatus.CONFLICT)
						.body(new ApiResponse<>(false, "मोबाइल नंबर पहले से पंजीकृत है। कृपया दूसरा नंबर दर्ज करें।", null));
			}
			account.setMobile(requestedMobile);
		}

		// Update editable fields only
		existingUser.setAddress(user.getAddress());
		existingUser.setEducation(user.getEducation());
		existingUser.setOccupation(user.getOccupation());
		existingUser.setBloodGroup(user.getBloodGroup());
		existingUser.setMaritalStatus(user.getMaritalStatus());

		// Only update Aadhaar if a valid 12-digit number is provided (skip masked/null/blank)
		String aadhar = user.getAadharNumber();
		if (aadhar != null && !aadhar.isBlank() && aadhar.matches("^[0-9]{12}$")) {
			existingUser.setAadharNumber(aadhar);
		}

		userRepository.save(existingUser);
		if (requestedMobile != null && !requestedMobile.isBlank()
				&& !requestedMobile.equals(mobile) && "GOOGLE".equals(account.getAuthProvider())) {
			loginUserRepository.save(account);
			String updatedToken = jwtTokenProvider.generateToken(
					account.getMobile(), jwtTokenProvider.getRolesFromToken(token));
			ResponseCookie cookie = ResponseCookie.from("authToken", updatedToken)
					.httpOnly(true)
					.secure(request.isSecure())
					.path("/")
					.maxAge(7L * 24 * 60 * 60)
					.sameSite("Lax")
					.build();
			response.addHeader("Set-Cookie", cookie.toString());
		}
		return ResponseEntity.ok(new ApiResponse<>(true, "प्रोफ़ाइल सफलतापूर्वक सहेजी गई।", null));
	}

	@PostMapping("/upload-image")
	public ResponseEntity<?> uploadProfileImage(@RequestParam("image") MultipartFile image, Principal principal) {
		String mobile = principal.getName();
		Optional<User> optionalUser = userRepository.findByLoginUser_Mobile(mobile);
		if (optionalUser.isEmpty())
			return ResponseEntity.badRequest().body("User not found");

		User user = optionalUser.get();

		try {
//			String fileName = UUID.randomUUID() + "_" + image.getOriginalFilename();
//			Path storageDir = Paths.get("C:/data/uploads/images/profile_images");
//			Files.createDirectories(storageDir);
//			Path filePath = storageDir.resolve(fileName);
//			Files.write(filePath, image.getBytes());
//
//			String publicUrl = "/images/profile_images/" + fileName;
			 // If using Cloudinary, replace above lines with:
			String publicUrl = cloudinaryService.uploadFile(image, "profile_images");
			user.setProfileImagePath(publicUrl);
			userRepository.save(user);

			return ResponseEntity.ok(Map.of("imagePath", publicUrl));
		} catch (IOException e) {
			return ResponseEntity.status(500).body("छवि अपलोड करने में विफल.कृपया प्रोफ़ाइल अनुभाग में अपडेट करें.");
		}
	}
	@GetMapping("/payments")
	public ResponseEntity<List<Payment>> getUserPayments(Authentication auth) {
	    String mobile = auth.getName();
	    List<Payment> payments = paymentService.getPaymentsByMobile(mobile);
	    return ResponseEntity.ok(payments);
	}

}
