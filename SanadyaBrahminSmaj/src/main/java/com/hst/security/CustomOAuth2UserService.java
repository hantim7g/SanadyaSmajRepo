package com.hst.security;

import com.hst.entity.User;
import com.hst.entity.LoginUser;
import com.hst.repository.LoginUserRepository;
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

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;

/**
 * Custom OAuth2 user service that handles Google login for three scenarios:
 *
 * 1. Existing member (matched by email) → logs in with their current role
 * 2. Existing Google-linked user (matched by GOOGLE_<id> mobile) → logs in
 * 3. First-time Google user → creates a room/matrimony login account only.
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

    @Autowired
    private LoginUserRepository loginUserRepository;

    @Override
    public OAuth2User loadUser(OAuth2UserRequest userRequest) throws OAuth2AuthenticationException {
        OAuth2User oAuth2User = super.loadUser(userRequest);

        String email = oAuth2User.getAttribute("email");
        String name = oAuth2User.getAttribute("name");
        String googleId = oAuth2User.getAttribute("sub");
        String googleMobile = GOOGLE_MOBILE_PREFIX + googleId;

        log.info("Google OAuth login attempt: email={}, name={}", email, name);

        // ----------------------------------------------------------------
        // 1. Find an existing login account by email.
        // ----------------------------------------------------------------
        if (email != null && !email.isBlank()) {
            try {
                Optional<LoginUser> byEmail = loginUserRepository.findFirstByEmailOrderByIdAsc(email);
                if (byEmail.isPresent()) {
                    LoginUser existing = byEmail.get();
                    User member = userRepository.findByLoginUser_Mobile(existing.getMobile()).orElse(null);
                    log.info("Found existing login account by email: {}", email);
                    return buildOAuth2User(oAuth2User, existing, member);
                }
            } catch (Exception e) {
                log.warn("Error looking up email {}: {}", email, e.getMessage());
            }
        }

        // ----------------------------------------------------------------
        // 2. Check if a Google-linked account already exists (by GOOGLE_<id> mobile)
        // ----------------------------------------------------------------
        Optional<LoginUser> existingGoogleUser = loginUserRepository.findByMobile(googleMobile);
        if (existingGoogleUser.isPresent()) {
            LoginUser account = existingGoogleUser.get();
            log.info("Found existing Google user: {} — logging in", googleMobile);
            User member = userRepository.findByLoginUser_Mobile(googleMobile).orElse(null);
            return buildOAuth2User(oAuth2User, account, member);
        }

        // ----------------------------------------------------------------
        // 3. First-time Google login creates an account only. Member details can
        // be added later if the account holder chooses member registration.
        // ----------------------------------------------------------------
        log.info("Creating login account for Google user: email={}", email);
        LoginUser account = new LoginUser();
        account.setMobile(googleMobile);
        account.setPassword(UUID.randomUUID().toString());
        account.setFullName(name != null ? name : "Google User");
        account.setEmail(email);
        account.setRole("USER");
        account.setAuthProvider("GOOGLE");
        account.setAccountType("ROOM_MATRIMONY");
        loginUserRepository.save(account);

        log.info("Google login account created: mobile={}, email={}", googleMobile, email);
        return buildOAuth2User(oAuth2User, account, null);
    }

    /**
     * Build an OAuth2User with the user's details and role.
     */
    private OAuth2User buildOAuth2User(OAuth2User original, LoginUser account, User member) {
        Map<String, Object> attributes = new HashMap<>(original.getAttributes());
        String role = "ROLE_" + account.getRole();
        attributes.put("userMobile", account.getMobile());
        attributes.put("userRole", role);
        attributes.put("fullName", account.getFullName());
        attributes.put("userApproved", member != null ? member.getApproved() : null);
        attributes.put("hasMemberProfile", member != null);

        return new DefaultOAuth2User(
                java.util.List.of(
                        new org.springframework.security.core.authority.SimpleGrantedAuthority(role)
                ),
                attributes,
                "email"
        );
    }
}
