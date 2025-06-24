package com.hst.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.hst.entity.Payment;
import com.hst.entity.User;
import com.hst.repository.UserRepository;
import com.hst.service.PaymentService;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.nio.file.*;
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
	private  UserRepository    userRepository;
    
    private final PaymentService paymentService;
    public PaymentController(PaymentService paymentService) {
        this.paymentService = paymentService;
    }

    @PostMapping(value = "/add", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<?> addPayment(
            @RequestPart("payment") String paymentJson,
            @RequestPart(value = "receiptImage", required = false) MultipartFile receiptImage,
            Authentication authentication
    ) {
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
        return ResponseEntity.ok(saved);
    }
}
