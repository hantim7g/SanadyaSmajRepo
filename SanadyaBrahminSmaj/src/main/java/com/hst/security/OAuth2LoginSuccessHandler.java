package com.hst.security;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseCookie;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.List;

/**
 * After a successful Google OAuth2 login, this handler:
 * 1. Generates a JWT token for the user
 * 2. Sets it as an HttpOnly cookie (same as regular login)
 * 3. Redirects based on user state:
 *    - Existing approved member → /home
 *    - New Google user (pending approval) → /register/complete
 *    - First-time user → /register/complete (profile completion)
 */
@Component
public class OAuth2LoginSuccessHandler implements AuthenticationSuccessHandler {

    private static final Logger log = LoggerFactory.getLogger(OAuth2LoginSuccessHandler.class);

    @Autowired
    private JwtTokenProvider jwtTokenProvider;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request,
                                        HttpServletResponse response,
                                        Authentication authentication) throws IOException {

        OAuth2User oAuth2User = (OAuth2User) authentication.getPrincipal();

        String userMobile = oAuth2User.getAttribute("userMobile");
        String userRole = oAuth2User.getAttribute("userRole");
        String fullName = oAuth2User.getAttribute("fullName");
        String userApproved = oAuth2User.getAttribute("userApproved");

        if (userMobile == null) {
            log.error("OAuth2 login failed: no userMobile in attributes");
            response.sendRedirect("/?error=oauth_failed");
            return;
        }

        // Generate JWT token (same format as regular login)
        String token = jwtTokenProvider.generateToken(userMobile, List.of(userRole.replace("ROLE_", "")));

        ResponseCookie cookie = ResponseCookie.from("authToken", token)
                .httpOnly(true)
                .secure(request.isSecure())
                .path("/")
                .maxAge(7 * 24 * 60 * 60) // 7 days
                .sameSite("Lax")
                .build();

        response.addHeader("Set-Cookie", cookie.toString());

        log.info("OAuth2 login successful: mobile={}, role={}, name={}, approved={}",
                userMobile, userRole, fullName, userApproved);

        // ----------------------------------------------------------------
        // Redirect logic based on user state
        // ----------------------------------------------------------------
        boolean isPending = userApproved == null || "प्रक्रिया में".equals(userApproved);

        if (isPending) {
            // New Google user — redirect to complete registration profile
            log.info("Redirecting pending user to profile completion: mobile={}", userMobile);
            response.sendRedirect("/register/complete");
        } else {
            // Approved member — go to home
            response.sendRedirect("/home");
        }
    }
}
