package com.hst.controller;

import com.hst.entity.User;
import com.hst.repository.UserRepository;
import com.hst.service.RegistrationNumberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;
import java.util.Optional;

/**
 * Handles profile completion for users who registered via Google OAuth.
 * These users have limited info (email, name) and need to fill in
 * the remaining registration fields before admin approval.
 */
@Controller
public class ProfileCompletionController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private RegistrationNumberService registrationNumberService;

    /**
     * Show the profile completion form for Google-registered users.
     * Pre-fills fields that Google already provided (name, email).
     */
    @GetMapping("/register/complete")
    public String showCompleteForm(Model model, Authentication authentication) {
        if (authentication == null) {
            return "redirect:/login";
        }

        String mobile = authentication.getName();
        Optional<User> userOpt = userRepository.findByMobile(mobile);
        if (userOpt.isEmpty()) {
            return "redirect:/register";
        }

        User user = userOpt.get();

        // Only allow profile completion for Google-auth users or pending users
        if (!"GOOGLE".equals(user.getAuthProvider()) && !"प्रक्रिया में".equals(user.getApproved())) {
            return "redirect:/home";
        }

        model.addAttribute("user", user);
        return "register-complete";
    }

    /**
     * Save the completed profile and generate registration number.
     * After this, the user goes into admin approval queue.
     */
    @PostMapping("/register/complete")
    public String saveCompleteProfile(
            @RequestParam String fullName,
            @RequestParam(required = false) String fatherName,
            @RequestParam(required = false) String gotra,
            @RequestParam(required = false) String dateOfBirth,
            @RequestParam(required = false) String gender,
            @RequestParam(required = false) String address,
            @RequestParam(required = false) String city,
            @RequestParam(required = false) String homeDistrict,
            @RequestParam(required = false) String education,
            @RequestParam(required = false) String occupation,
            @RequestParam(required = false) String bloodGroup,
            @RequestParam(required = false) String maritalStatus,
            Authentication authentication,
            RedirectAttributes redirect) {

        if (authentication == null) {
            return "redirect:/login";
        }

        String mobile = authentication.getName();
        Optional<User> userOpt = userRepository.findByMobile(mobile);
        if (userOpt.isEmpty()) {
            return "redirect:/register";
        }

        User user = userOpt.get();

        // Update all profile fields
        if (fullName != null && !fullName.isBlank()) {
            user.setFullName(fullName);
        }
        user.setFatherName(fatherName);
        user.setGotra(gotra);
        if (dateOfBirth != null && !dateOfBirth.isBlank()) {
            user.setDateOfBirth(LocalDate.parse(dateOfBirth));
        }
        user.setGender(gender);
        user.setAddress(address);
        user.setCity(city);
        user.setHomeDistrict(homeDistrict);
        user.setEducation(education);
        user.setOccupation(occupation);
        user.setBloodGroup(bloodGroup);
        user.setMaritalStatus(maritalStatus);

        // Generate registration number if not already assigned
        if (user.getRegistrationNo() == null || user.getRegistrationNo().isBlank()) {
            String regNo = registrationNumberService.generateRegistrationNumber();
            user.setRegistrationNo(regNo);
        }

        userRepository.save(user);

        redirect.addFlashAttribute("successMessage",
                "आपकी प्रोफ़ाइल सफलतापूर्वक पूर्ण हुई। कृपया अनुमोदन की प्रतीक्षा करें।");
        return "redirect:/home";
    }
}
