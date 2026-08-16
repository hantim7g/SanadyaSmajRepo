package com.hst.security;

import com.hst.entity.User;
import com.hst.repository.UserRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.oauth2.client.userinfo.DefaultOAuth2UserService;
import org.springframework.security.oauth2.client.userinfo.OAuth2UserRequest;
import org.springframework.security.oauth2.core.OAuth2AuthenticationException;
import org.springframework.security.oauth2.core.user.DefaultOAuth2User;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;

/**
 * Custom OAuth2 user service that handles Google login for three scenarios:
 *
 * 1. Existing member (matched by email) → logs in with their current role
 * 2. Existing Google-linked user (matched by GOOGLE_<id> mobile) → logs in
 * 3. First-time Google user → creates a pending member (role=USER, approved=प्रक्रिया में)
 *    so they can complete registration later and get admin approval for full access.
 *
 * Even before admin approval, the user can:
 *   - Browse and book rooms
 *   - Register for Vivah (matrimony)
 *   - View matrimony listings
 */
@Service
public class CustomOAuth2UserService extends DefaultOAuth2UserService {

    private static final Logger log = LoggerFactory.getLogger(CustomOAuth2UserService.class);
    private static final String GOOGLE_MOBILE_PREFIX = "GOOGLE_";

    @Autowired
    private UserRepository userRepository;

    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
        OAuth2User oAuth2User = super.loadUser(userRequest);

        String email = oAuth2User.getAttribute("email");
        String name = oAuth2User.getAttribute("name");
        String googleId = oAuth2User.getAttribute("sub");
        String googleMobile = GOOGLE_MOBILE_PREFIX + googleId;

        log.info("Google OAuth login attempt: email={}, name={}", email, name);

        // ----------------------------------------------------------------
        // 1. Try to find existing user by email (registered member)
        // ----------------------------------------------------------------
        if (email != null && !email.isBlank()) {
            try {
                Optional<User> byEmail = userRepository.findByEmail(email);
                if (byEmail.isPresent()) {
                    User existing = byEmail.get();
                    log.info("Found existing member by email: {} — logging in as USER", email);
                    return buildOAuth2User(oAuth2User, existing, "ROLE_USER");
                }
            } catch (Exception e) {
                log.warn("Error looking up email {}: {}", email, e.getMessage());
            }
        }

        // ----------------------------------------------------------------
        // 2. Check if a Google-linked user already exists (by GOOGLE_<id> mobile)
        // ----------------------------------------------------------------
        Optional<User> existingGoogleUser = userRepository.findByMobile(googleMobile);
        if (existingGoogleUser.isPresent()) {
            User user = existingGoogleUser.get();
            log.info("Found existing Google user: {} — logging in", googleMobile);
            return buildOAuth2User(oAuth2User, user, "ROLE_" + user.getRole());
        }

        // ----------------------------------------------------------------
        // 3. First-time Google login — create a pending member
        // ----------------------------------------------------------------
        log.info("Creating new pending member for Google login: email={}", email);
        User newUser = new User();
        newUser.setMobile(googleMobile);
        newUser.setPassword(UUID.randomUUID().toString()); // Random — not used for OAuth
        newUser.setFullName(name != null ? name : "Google User");
        newUser.setEmail(email);
        newUser.setRole("USER");
        // Pending — admin must approve for full access
        newUser.setApproved("प्रक्रिया में");
        newUser.setCreatedDate(LocalDate.now());
        newUser.setAgreeToTerms(true);
        newUser.setAuthProvider("GOOGLE");
        userRepository.save(newUser);

        log.info("Pending member created: mobile={}, email={}", googleMobile, email);
        return buildOAuth2User(oAuth2User, newUser, "ROLE_USER");
    }

    /**
     * Build an OAuth2User with the user's details and role.
     */
    private OAuth2User buildOAuth2User(OAuth2User original, User user, String role) {
        Map<String, Object> attributes = new HashMap<>(original.getAttributes());
        attributes.put("userMobile", user.getMobile());
        attributes.put("userRole", role);
        attributes.put("fullName", user.getFullName());
        attributes.put("userApproved", user.getApproved());

        return new DefaultOAuth2User(
                java.util.List.of(
                        new org.springframework.security.core.authority.SimpleGrantedAuthority(role)
                ),
                attributes,
                "email"
        );
    }
}
