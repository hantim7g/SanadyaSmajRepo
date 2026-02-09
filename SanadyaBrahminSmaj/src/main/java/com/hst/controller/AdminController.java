package com.hst.controller;

import com.hst.entity.PasswordResetRequest;
import com.hst.entity.User;
import com.hst.repository.UserRepository;
import com.hst.service.PasswordResetRequestService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/admin")
public class AdminController {
    private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger(AdminController.class);

    
    @Autowired
    private  UserRepository userRepository;
    @Autowired
    private PasswordResetRequestService passwordResetRequestService;

    // ⏳ Get all users with approved = false
    @GetMapping("/pending-users")
    public List<User> getPendingUsers() {
        return userRepository.findByApprovedFalse();
    }

    // ✅ Approve a user by ID
    @PutMapping("/approve/{id}")
    public ResponseEntity<String> approveUser(@PathVariable Long id) {
        Optional<User> userOpt = userRepository.findById(id);
        if (userOpt.isPresent()) {
            User user = userOpt.get();
            user.setApprovedRejectDate(LocalDate.now());
            user.setApproved("स्वीकृत");
            userRepository.save(user);
            return ResponseEntity.ok("यूज़र को सफलतापूर्वक अनुमोदित किया गया।");
        } else {
            return ResponseEntity.status(404).body("यूज़र नहीं मिला।");
        }
    }
    @PostMapping("/password-reset/{id}/approve")
    public ResponseEntity<?> approveReset(@PathVariable Long id,
                                          @RequestParam(required = false) String adminRemarks) {
        PasswordResetRequest req = passwordResetRequestService.findById(id);
        if (req == null || !"PENDING".equals(req.getStatus())) {
            return ResponseEntity.badRequest().body(Map.of("message", "अनुरोध मान्य नहीं है।"));
        }

        Optional<User> userOpt = userRepository.findByMobile(req.getMobile());
        if (userOpt.isEmpty()) return ResponseEntity.status(404).body(Map.of("message", "यूज़र नहीं मिला।"));

        User user = userOpt.get();
        user.setPassword(req.getNewPassword()); // Set approved new password
        userRepository.save(user);

        req.setStatus("APPROVED");
        req.setAdminRemarks(adminRemarks);
        req.setDecisionDate(LocalDateTime.now());
        passwordResetRequestService.save(req);

        return ResponseEntity.ok(Map.of("message", "पासवर्ड सफलतापूर्वक स्वीकृत किया गया"));
    }
    @PostMapping("/password-reset/{id}/reject")
    public ResponseEntity<?> rejectReset(@PathVariable Long id,
                                         @RequestParam String adminRemarks) {
        PasswordResetRequest req = passwordResetRequestService.findById(id);
        if (req == null || !"PENDING".equals(req.getStatus())) {
            return ResponseEntity.badRequest().body(Map.of("message", "अनुरोध मान्य नहीं है।"));
        }

        req.setStatus("REJECTED");
        req.setAdminRemarks(adminRemarks);
        req.setDecisionDate(LocalDateTime.now());
        passwordResetRequestService.save(req);

        return ResponseEntity.ok(Map.of("message", "अनुरोध अस्वीकृत किया गया"));
    }


}