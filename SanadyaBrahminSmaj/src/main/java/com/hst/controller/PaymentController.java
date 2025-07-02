package com.hst.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.hst.entity.Payment;
import com.hst.entity.User;
import com.hst.repository.UserRepository;
import com.hst.service.PaymentService;
import com.hst.service.UserService;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.nio.file.*;
import java.security.Principal;
import java.sql.Date;
import java.util.Optional;
import java.util.UUID;

import com.hst.entity.Payment;
import com.hst.entity.User;
import com.hst.repository.UserRepository;
import com.hst.service.PaymentService;

import jakarta.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Optional;

@RestController
@RequestMapping("/api/payment")
public class PaymentController {
	@Value("${upload.image.dir}")
	private String uploadDir;

	@Autowired
	private UserRepository userRepository;
	@Autowired
	private UserService userService;
	
	private final PaymentService paymentService;

	public PaymentController(PaymentService paymentService) {
		this.paymentService = paymentService;
	}

	@PostMapping(value = "/add", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
	public ResponseEntity<?> addPayment(@RequestPart("payment") String paymentJson,
			@RequestPart(value = "receiptImage", required = false) MultipartFile receiptImage,
			Authentication authentication) {
		if (authentication == null || !authentication.isAuthenticated()) {
			return ResponseEntity.status(HttpServletResponse.SC_UNAUTHORIZED).body("Unauthorized");
		}

		String mobile = authentication.getName(); // mobile from JWT

		Optional<User> userOptional = userRepository.findByMobile(mobile);
		if (userOptional.isEmpty()) {
			return ResponseEntity.status(HttpServletResponse.SC_UNAUTHORIZED).body("User not found");
		}

		User user = userOptional.get();

		// 🧾 JSON को Payment object में बदलें
		ObjectMapper objectMapper = new ObjectMapper();
		Payment payment;
		try {
			payment = objectMapper.readValue(paymentJson, Payment.class);
		} catch (IOException e) {
			return ResponseEntity.badRequest().body("Invalid payment data");
		}

		// 🔗 user सेट करें
		payment.setUser(user);
		payment.setCrtBy(user.getId());
		payment.setCrtDt(Date.valueOf(LocalDate.now()));
		
		
		// 🖼️ Save receipt image if present
		if (receiptImage != null && !receiptImage.isEmpty()) {
			try {
				String fileName = UUID.randomUUID() + "_" + receiptImage.getOriginalFilename();
				Path filePath = Paths.get(uploadDir).resolve(fileName);
				Files.createDirectories(filePath.getParent());
				Files.write(filePath, receiptImage.getBytes());
				payment.setReceiptImagePath(fileName); // 🆕 आप को entity में ये field add करनी होगी
			} catch (IOException e) {
				return ResponseEntity.status(500).body("Failed to save receipt image");
			}
		}

		Payment saved = paymentService.addPayment(payment);

		if (payment.getDescription() != null && payment.getDescription().toLowerCase().contains("वार्षिक शुल्क")
				&& payment.getPaymentDate().toLocalDate().getYear() == LocalDate.now().getYear()
				&& "सफल".equalsIgnoreCase(payment.getStatus())) {

			user.setAnnualFeeStatus("प्रक्रिया में"); // 0 = not due (paid) // 1 due // 2 yet to validate
			user.setLastAnnualFeePaid(payment.getPaymentDate().toLocalDate());
			user.setLastAnnualFeeAmount(payment.getAmount());
			//user.setAnnualFeeValidated("प्रक्रिया में");
			userRepository.save(user); // 💾 Save updated fee info
		}
		return ResponseEntity.ok(saved);
	}
	@PostMapping(value = "/member/payment/update", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
	public ResponseEntity<String> updatePayment(
	        @RequestParam("Id") Long paymentId,
	        @RequestParam("transactionId") String transactionId,
	        @RequestParam("amount") double amount,
	        @RequestParam("paymentMode") String paymentMode,
	        @RequestParam("description") String description,
	        @RequestParam("status") String status,
	        @RequestParam("paymentDate") Date paymentDate,
	        @RequestParam("feeFrom") Date feeFrom,
	        @RequestParam("feeTo") Date feeTo,
	        @RequestParam("reason") String reason,
	        @RequestParam(value = "receiptImage", required = false) MultipartFile receiptImage,
	        Principal principal) {

	    Payment paymentDB = paymentService.findPaymentById(paymentId);
	    if (!"प्रक्रिया में".equalsIgnoreCase(paymentDB.getValidated())) {
	        return ResponseEntity.status(HttpStatus.BAD_REQUEST)
	                .body("❌ Payment cannot be updated as it is already processed.");
	    }

	    User user = userService.findByMobile(principal.getName());

	    paymentDB.setTransactionId(transactionId);
	    paymentDB.setAmount(amount);
	    paymentDB.setPaymentMode(paymentMode);
	    paymentDB.setDescription(description);
	    paymentDB.setStatus(status);
	    paymentDB.setPaymentDate(paymentDate);
	    paymentDB.setReason(reason);
	    paymentDB.setFeeFrom(feeFrom);
	    paymentDB.setFeeTo(feeTo);
	    // ✅ If receipt image is provided, save it
	    if (receiptImage != null && !receiptImage.isEmpty()) {
	        try {
	            String fileName = UUID.randomUUID() + "_" + receiptImage.getOriginalFilename();
	            Path filePath = Paths.get(uploadDir+"/receiptImage/").resolve(fileName);
	            Files.createDirectories(filePath.getParent());
	            Files.write(filePath, receiptImage.getBytes());
	            paymentDB.setReceiptImagePath("receiptImage/"+fileName); // ✅ Update image path
	        } catch (IOException e) {
	            return ResponseEntity.status(500).body("❌ Failed to save receipt image.");
	        }
	    }

	    paymentDB.setLstUpBy(user.getId());
	    paymentDB.setLstUpDt(Date.valueOf(LocalDate.now()));

	    try {
	        paymentService.savePayment(paymentDB);
	        return ResponseEntity.ok("redirect:/member/profile");
	    } catch (Exception e) {
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
	                .body("❌ Failed to update payment. Please try again.");
	    }
	}


}
