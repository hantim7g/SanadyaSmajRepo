package com.hst.controller;

import com.hst.entity.User;
import com.hst.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/admin")
public class AdminController {

    private final UserRepository userRepository;

    @Autowired
    public AdminController(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

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
            user.setApproved(true);
            userRepository.save(user);
            return ResponseEntity.ok("यूज़र को सफलतापूर्वक अनुमोदित किया गया।");
        } else {
            return ResponseEntity.status(404).body("यूज़र नहीं मिला।");
        }
    }
}
