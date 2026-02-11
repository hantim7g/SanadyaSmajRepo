package com.hst.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.hst.entity.Payment;
import com.hst.entity.User;
import com.hst.repository.UserRepository;
import com.hst.service.AuditLogService;
import com.hst.service.CloudinaryService;
import com.hst.service.PaymentService;
import com.hst.service.UserService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.*;
import java.sql.Date;
import java.time.LocalDate;
import java.util.Optional;
import java.util.Set;
import java.util.UUID;

@RestController
@RequestMapping("/api/payment")
public class PaymentController {
	
	@Autowired
	private CloudinaryService cloudinaryService;
	private final AuditLogService auditLogService;

    private static final Set<String> ALLOWED_IMAGE_TYPES =
            Set.of("image/jpeg", "image/png", "image/jpg");

    private static final long MAX_FILE_SIZE = 5 * 1024 * 1024; // 5MB

    @Value("${upload.image.dir}")
    private String uploadDir;

    private final PaymentService paymentService;
    private final UserService userService;
    private final UserRepository userRepository;
    private final ObjectMapper objectMapper;

    public PaymentController(PaymentService paymentService,
                             UserService userService,
                             UserRepository userRepository,
                             ObjectMapper objectMapper,
                             AuditLogService auditLogService) {
        this.paymentService = paymentService;
        this.userService = userService;
        this.userRepository = userRepository;
        this.objectMapper = objectMapper;
        		this.auditLogService = auditLogService;
    }

    /* =========================
       ADD PAYMENT
       ========================= */
    @PostMapping(value = "/add", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<?> addPayment(
            @RequestPart("payment") String paymentJson,
            @RequestPart(value = "receiptImage", required = false) MultipartFile receiptImage,
            Authentication authentication,HttpServletRequest request) {

        if (authentication == null || !authentication.isAuthenticated()) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Unauthorized");
        }

        User user = userRepository.findByMobile(authentication.getName())
                .orElseThrow(() -> new RuntimeException("User not found"));

        Payment payment;
        try {
            payment = objectMapper.readValue(paymentJson, Payment.class);
        } catch (IOException e) {
            return ResponseEntity.badRequest().body("Invalid payment data");
        }

        payment.setUser(user);
        payment.setCrtBy(user.getId());
        payment.setCrtDt(Date.valueOf(LocalDate.now()));

        if (receiptImage != null && !receiptImage.isEmpty()) {
            String imagePath = saveReceiptImage(receiptImage);
            payment.setReceiptImagePath(imagePath);
        }

        Payment savedPayment = paymentService.addPayment(payment);


auditLogService.log(
        "PAYMENT_CREATED",
        "Payment",
        savedPayment.getId(),
        user.getId(),
        user.getMobile(),
        "Payment created with amount: " + savedPayment.getAmount(),
        request
);
        
        return ResponseEntity.ok(savedPayment.getId());
    }

    /* =========================
       UPDATE PAYMENT (OWNER ONLY)
       ========================= */
    @PostMapping(value = "/member/payment/update", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<?> updatePayment(
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
            Authentication authentication,
            HttpServletRequest request) {

        User user = userService.findByMobile(authentication.getName());

        Payment payment = paymentService.findPaymentById(paymentId);

        
        if (!payment.getUser().getId().equals(user.getId())) {

            auditLogService.log(
                    "UNAUTHORIZED_PAYMENT_UPDATE",
                    "Payment",
                    paymentId,
                    user.getId(),
                    user.getMobile(),
                    "Attempted to update payment not owned by user",
                    request
            );

            return ResponseEntity.status(HttpStatus.FORBIDDEN)
                    .body("You are not allowed to update this payment");
        }
        // 🔐 Ownership check (CRITICAL)
        if (!payment.getUser().getId().equals(user.getId())) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN)
                    .body("You are not allowed to update this payment");
        }

        if (!"प्रक्रिया में".equalsIgnoreCase(payment.getValidated())) {
            return ResponseEntity.badRequest()
                    .body("Payment already processed");
        }

        payment.setTransactionId(transactionId);
        payment.setAmount(amount);
        payment.setPaymentMode(paymentMode);
        payment.setDescription(description);
        payment.setStatus(status);
        payment.setPaymentDate(paymentDate);
        payment.setReason(reason);
        payment.setFeeFrom(feeFrom);
        payment.setFeeTo(feeTo);
        payment.setLstUpBy(user.getId());
        payment.setLstUpDt(Date.valueOf(LocalDate.now()));

        if (receiptImage != null && !receiptImage.isEmpty()) {
            String imagePath = saveReceiptImage(receiptImage);
            payment.setReceiptImagePath(imagePath);
        }

        paymentService.savePayment(payment);
        


        auditLogService.log(
                "PAYMENT_UPDATED",
                "Payment",
                payment.getId(),
                user.getId(),
                user.getMobile(),
                "Payment updated. Status: " + payment.getStatus(),
                request
        );

        return ResponseEntity.ok("Payment updated successfully");
    }

    /* =========================
       SECURE FILE SAVE
       ========================= */
    private String saveReceiptImage(MultipartFile file) {

        if (!ALLOWED_IMAGE_TYPES.contains(file.getContentType())) {
            throw new RuntimeException("Invalid image type");
        }

        if (file.getSize() > MAX_FILE_SIZE) {
            throw new RuntimeException("File size exceeds limit");
        }

        String safeFileName = UUID.randomUUID() + ".jpg";

        try {
//            Path uploadPath = Paths.get(uploadDir, "receiptImage");
//            Files.createDirectories(uploadPath);
//
//            Path targetPath = uploadPath.resolve(safeFileName);
//            Files.copy(file.getInputStream(), targetPath, StandardCopyOption.REPLACE_EXISTING);

            String cloudinaryUrl = cloudinaryService.uploadFile(file, "receiptImage");
            return cloudinaryUrl;

        } catch (IOException e) {
            throw new RuntimeException("Failed to store receipt image");
        }
    }
}
