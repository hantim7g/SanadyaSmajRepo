package com.hst.phonepe;

import java.io.IOException;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.hst.dto.PaymentRequest;
import com.hst.entity.Payment;
import com.hst.entity.User;
import com.hst.repository.PaymentRepository;
import com.hst.repository.UserRepository;
import com.phonepe.sdk.pg.common.exception.PhonePeException;
import com.phonepe.sdk.pg.common.models.response.CallbackResponse;
import com.phonepe.sdk.pg.common.models.response.OrderStatusResponse;
import com.phonepe.sdk.pg.payments.v2.StandardCheckoutClient;

import jakarta.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
@RestController
@RequestMapping("/api/phonepe")
public class PhonePeController {

    @Autowired
    private PPPaymentService paymentService;
    @Autowired
    private StandardCheckoutClient client;
    @Autowired
    private PaymentRepository paymentRepository;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private PPPaymentService ppPaymentService;
    
    @PostMapping(value = "/pay", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<?> initiateOnlinePayment(
            @RequestPart("payment") String paymentJson,
            Authentication authentication) {

        if (authentication == null || !authentication.isAuthenticated()) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Unauthorized");
        }

        User user = userRepository.findByMobile(authentication.getName())
                .orElseThrow(() -> new RuntimeException("User not found"));

        ObjectMapper objectMapper = new ObjectMapper();
        
        try {
            PaymentRequest req = objectMapper.readValue(paymentJson, PaymentRequest.class);
            
            // This service will save the 'Pending' state and return the PhonePe URL
            String redirectUrl = "https://yourwebsite.com/payment-completion";
            String gatewayUrl = "";//paymentService.initiatePhonePeTransaction(user, req, redirectUrl);

            return ResponseEntity.ok(Map.of("redirectUrl", gatewayUrl));

        } catch (IOException e) {
            return ResponseEntity.badRequest().body("Invalid payment data");
        }
    }

    @PostMapping("/pay/offline")
    public ResponseEntity<?> initiateOfflinePayment(
			@RequestBody PaymentRequest req,
			Authentication authentication) {

		if (authentication == null || !authentication.isAuthenticated()) {
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Unauthorized");
		}

		User user = userRepository.findByMobile(authentication.getName())
				.orElseThrow(() -> new RuntimeException("User not found"));

		// This service will save the 'Pending' state and return a confirmation message
	//	paymentService.initiateOfflineTransaction(user, req);

		return ResponseEntity.ok(Map.of("message", "Offline payment initiated. Please complete the payment and contact support."));
	}
    @PostMapping("/webhook")
    public ResponseEntity<String> handleWebhook(
            @RequestHeader("Authorization") String auth,
            @RequestBody String body) {
        try {
            // Validate request authenticity
            CallbackResponse response = client.validateCallback("USER", "PASS", auth, body);
            
            String mTxnId = response.getPayload().getMerchantOrderId();
            String state = response.getPayload().getState(); // COMPLETED or FAILED

            // Find the record in your database
            Optional<Payment> paymentOpt = paymentRepository.findByTransactionId(mTxnId);
            
            if (paymentOpt.isPresent()) {
                Payment payment = paymentOpt.get();
                
                if ("COMPLETED".equals(state)) {
                    payment.setStatus("SUCCESS");
                    payment.setValidated("सफल"); // Update Hindi status if needed
                } else {
                    payment.setStatus("FAILED");
                    payment.setValidated("विफल");
                }
                
                payment.setLstUpDt(new java.sql.Date(System.currentTimeMillis()));
                paymentRepository.save(payment);
            }
            
            return ResponseEntity.ok("ACK");
        } catch (PhonePeException e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
    }
    @GetMapping("/check-status/{txnId}")
    public ResponseEntity<Map<String, String>> manualCheckStatus(@PathVariable String txnId) {
        try {
            // 1. Query PhonePe SDK
//            OrderStatusResponse response = client.getOrderStatus(txnId);
            String phonePeState = ppPaymentService.orderStatus(txnId);
            
            String state = phonePeState; // COMPLETED, FAILED, or PENDING

            // 2. Find and Update the Payment entity in DB
            Optional<Payment> paymentOpt = paymentRepository.findByTransactionId(txnId);
            if (paymentOpt.isPresent()) {
                Payment payment = paymentOpt.get();
                
                // Map PhonePe state to your entity status
                if ("COMPLETED".equalsIgnoreCase(state)) {
                    payment.setStatus("SUCCESS");
                    payment.setValidated("सफल");
                } else if ("FAILED".equalsIgnoreCase(state)) {
                    payment.setStatus("FAILED");
                    payment.setValidated("विफल");
                }
                
                payment.setLstUpDt(new java.sql.Date(System.currentTimeMillis()));
                paymentRepository.save(payment);
            }

            return ResponseEntity.ok(Map.of("status", state));
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                                 .body(Map.of("error", "Unable to fetch status"));
        }
    }
}