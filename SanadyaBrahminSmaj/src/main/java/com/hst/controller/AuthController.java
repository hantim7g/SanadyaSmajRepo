package com.hst.controller;

import com.hst.dto.LoginRequest;
import com.hst.entity.User;
import com.hst.repository.UserRepository;
import com.hst.response.ApiResponse;
import com.hst.security.JwtTokenProvider;
import com.hst.service.RegistrationNumberService;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/api/auth/")
public class AuthController {

    @Autowired
    private RegistrationNumberService registrationNumberService;

    private final AuthenticationManager authenticationManager;
    private final JwtTokenProvider jwtTokenProvider;
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    public AuthController(AuthenticationManager authenticationManager,
                          JwtTokenProvider jwtTokenProvider,
                          UserRepository userRepository,
                          PasswordEncoder passwordEncoder) {
        this.authenticationManager = authenticationManager;
        this.jwtTokenProvider = jwtTokenProvider;
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @PostMapping("/login")
    public ResponseEntity<ApiResponse<Map<String, String>>> login(@RequestBody LoginRequest request,
                                                                   HttpServletResponse response) {
        Optional<User> optionalUser = userRepository.findByMobile(request.getMobile());
        if (optionalUser.isEmpty()) {
            return ResponseEntity.badRequest()
                    .body(new ApiResponse<>(false, "मोबाइल नंबर पंजीकृत नहीं है।", null));
        }

        User user = optionalUser.get();
        if (!user.isApproved()) {
            return ResponseEntity.badRequest()
                    .body(new ApiResponse<>(false, "आपका पंजीकरण अनुमोदित नहीं है।", null));
        }

        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(request.getMobile(), request.getPassword())
        );

        String token = jwtTokenProvider.generateToken(request.getMobile(),user.getRole());

        Cookie cookie = new Cookie("authToken", token);
        cookie.setHttpOnly(true);
        cookie.setPath("/");
        cookie.setMaxAge(7 * 24 * 60 * 60);
        response.addCookie(cookie);

        return ResponseEntity.ok(new ApiResponse<>(true, user.getFullName(), Map.of("token", token)));
    }

    @PostMapping("/register")
    public ResponseEntity<ApiResponse<Map<String, String>>> register(@RequestBody User req) {
        if (userRepository.existsByMobile(req.getMobile())) {
            return ResponseEntity.badRequest()
                    .body(new ApiResponse<>(false, "मोबाइल नंबर पहले से पंजीकृत है।", null));
        }

        User user = new User();
        user.setMobile(req.getMobile());
        user.setPassword(passwordEncoder.encode(req.getPassword()));
        user.setFullName(req.getFullName());
        user.setFatherName(req.getFatherName());
        user.setGotra(req.getGotra());
        user.setDateOfBirth(req.getDateOfBirth());
        user.setGender(req.getGender());
        user.setAddress(req.getAddress());
        user.setEmail(req.getEmail());
        user.setEducation(req.getEducation());
        user.setOccupation(req.getOccupation());
        user.setHomeDistrict(req.getHomeDistrict());
        user.setAadharNumber(req.getAadharNumber());
        user.setBloodGroup(req.getBloodGroup());
        user.setMaritalStatus(req.getMaritalStatus());
        user.setOrganizationAffiliation(req.getOrganizationAffiliation());
        user.setContribution(req.getContribution());
        user.setAgreeToTerms(req.isAgreeToTerms());

        user.setRole("USER"); // ✅ Add Spring Security compatible role format
        user.setApproved(false);

        String regNo = registrationNumberService.generateRegistrationNumber();
        user.setRegistrationNo(regNo);
        userRepository.save(user);

        return ResponseEntity.ok(new ApiResponse<>(true,
                "आपकी पंजीकरण अनुरोध सफलतापूर्वक सबमिट हो गया है, कृपया अनुमोदन की प्रतीक्षा करें।", null));
    }
   

}
