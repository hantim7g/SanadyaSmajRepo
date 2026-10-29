package com.hst.controller;

import com.hst.entity.User;
import com.hst.entity.LoginUser;
import com.hst.repository.LoginUserRepository;
import com.hst.repository.UserRepository;
import com.hst.security.JwtTokenProvider;
import com.hst.service.RegistrationNumberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.http.ResponseCookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.Optional;
import java.util.List;

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
    private LoginUserRepository loginUserRepository;

    @Autowired
    private RegistrationNumberService registrationNumberService;

    @Autowired
    private JwtTokenProvider jwtTokenProvider;

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
        Optional<LoginUser> accountOpt = loginUserRepository.findByMobile(mobile);
        if (accountOpt.isEmpty()) {
            return "redirect:/register";
        }

        LoginUser account = accountOpt.get();
        model.addAttribute("mobileNumber",
                account.getMobile() != null && account.getMobile().startsWith("GOOGLE_") ? "" : account.getMobile());
        User user = userRepository.findByLoginUser_Mobile(mobile).orElseGet(() -> {
            User profile = new User();
            profile.setLoginUser(account);
            return profile;
        });

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
    @Transactional
    public String saveCompleteProfile(
            @RequestParam String fullName,
            @RequestParam(required = false) String fatherName,
            @RequestParam(required = false) String gotra,
            @RequestParam(required = false) String dateOfBirth,
            @RequestParam(required = false) String gender,
            @RequestParam(required = false) String address,
            @RequestParam (required = false) String mobile,
            @RequestParam(required = false) String city,
            @RequestParam(required = false) String homeDistrict,
            @RequestParam(required = false) String education,
            @RequestParam(required = false) String occupation,
            @RequestParam(required = false) String bloodGroup,
            @RequestParam(required = false) String maritalStatus,
            Authentication authentication,
            HttpServletRequest request,
            HttpServletResponse response,
            RedirectAttributes redirect) {

        if (authentication == null) {
            return "redirect:/login";
        }

    String     mobileSystem = authentication.getName();

        Optional<LoginUser> accountOpt = loginUserRepository.findByMobile(mobileSystem);
        if (accountOpt.isEmpty()) {
            return "redirect:/register";
        }

        LoginUser account = accountOpt.get();
        User user = userRepository.findByLoginUser_Mobile(mobileSystem).orElseGet(User::new);
        user.setLoginUser(account);

        if(mobile != null && !mobile.isBlank() && !mobile.equals(mobileSystem)) {
            if (!mobile.matches("^[0-9]{10}$")) {
                redirect.addFlashAttribute("errorMessage", "मान्य 10 अंकों का मोबाइल नंबर दर्ज करें।");
                return "redirect:/register/complete";
            }
            // Check if the new mobile number is already registered
            if (loginUserRepository.existsByMobile(mobile)) {
                redirect.addFlashAttribute("errorMessage", "मोबाइल नंबर पहले से पंजीकृत है। कृपया एक अलग नंबर दर्ज करें।");
                return "redirect:/register/complete";
            }
            else {
                account.setMobile(mobile);
            }

        }

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
        user.setCreatedDate(user.getCreatedDate() == null ? LocalDate.now() : user.getCreatedDate());
        user.setApproved("प्रक्रिया में");
        user.setAgreeToTerms(true);
        account.setAccountType("MEMBER");

        // Generate registration number if not already assigned
        if (user.getRegistrationNo() == null || user.getRegistrationNo().isBlank()) {
            String regNo = registrationNumberService.generateRegistrationNumber();
            user.setRegistrationNo(regNo);
        }

        loginUserRepository.save(account);
        userRepository.save(user);

        String token = jwtTokenProvider.generateToken(account.getMobile(), List.of(account.getRole()));
        ResponseCookie cookie = ResponseCookie.from("authToken", token)
            .httpOnly(true)
            .secure(request.isSecure())
            .path("/")
            .maxAge(7L * 24 * 60 * 60)
            .sameSite("Lax")
            .build();
        response.addHeader("Set-Cookie", cookie.toString());

        redirect.addFlashAttribute("successMessage",
                "आपकी प्रोफ़ाइल सफलतापूर्वक पूर्ण हुई। कृपया अनुमोदन की प्रतीक्षा करें।");
        return "redirect:/home";
    }
}
