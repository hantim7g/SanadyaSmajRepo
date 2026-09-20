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
 * Handles the "Apply for Membership" upgrade flow.
 * Users who registered as 'Booking' or 'Matrimony' can upgrade to 'Member'
 * by completing the member-only profile fields.
 */
@Controller
public class MembershipController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private RegistrationNumberService registrationNumberService;

    /**
     * Show the membership application form (reuses register-complete.jsp in membership mode).
     */
    @GetMapping("/membership/apply")
    public String showMembershipForm(Model model, Authentication authentication) {
        if (authentication == null || !authentication.isAuthenticated()) {
            return "redirect:/login";
        }

        String mobile = authentication.getName();
        Optional<User> userOpt = userRepository.findByMobile(mobile);
        if (userOpt.isEmpty()) {
            return "redirect:/register";
        }

        User user = userOpt.get();
        // Already a member — nothing to apply for
        if ("Member".equals(user.getUserType())) {
            return "redirect:/home";
        }

        model.addAttribute("user", user);
        model.addAttribute("membershipMode", true);
        return "register-complete";
    }

    /**
     * Save the membership application: update profile fields and upgrade userType to 'Member'.
     */
    @PostMapping("/membership/apply")
    public String applyForMembership(
            @RequestParam(required = false) String fullName,
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

        // Update profile fields
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

        // Upgrade to Member
        user.setUserType("Member");

        // Ensure registration number is assigned
        if (user.getRegistrationNo() == null || user.getRegistrationNo().isBlank()) {
            user.setRegistrationNo(registrationNumberService.generateRegistrationNumber());
        }

        userRepository.save(user);

        redirect.addFlashAttribute("successMessage",
                "आपका सदस्यता आवेदन सफलतापूर्वक सबमिट हो गया है। अब आप सदस्य के रूप में पंजीकृत हैं।");
        return "redirect:/home";
    }
}