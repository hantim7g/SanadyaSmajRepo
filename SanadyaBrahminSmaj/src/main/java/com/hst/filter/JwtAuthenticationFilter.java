package com.hst.filter;

import com.hst.security.JwtTokenProvider;
import com.hst.service.CustomUserDetailsService;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.ResponseCookie;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;
import org.springframework.security.core.userdetails.UserDetails;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@Component
public class JwtAuthenticationFilter extends OncePerRequestFilter {

    private static final Logger log = LoggerFactory.getLogger(JwtAuthenticationFilter.class);
    private static final String TOKEN_COOKIE_NAME = "authToken";

    private final JwtTokenProvider jwtProvider;
    private final CustomUserDetailsService userDetailsService;

    public JwtAuthenticationFilter(JwtTokenProvider jwtProvider,
                                   CustomUserDetailsService userDetailsService) {
        this.jwtProvider = jwtProvider;
        this.userDetailsService = userDetailsService;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request,
                                    HttpServletResponse response,
                                    FilterChain filterChain)
            throws ServletException, IOException {

        try {
            // 1️⃣ Extract token (Header → Cookie)
            String token = jwtProvider.getJwtFromHeader(request);
            if (token == null) {
                token = jwtProvider.getJwtFromCookies(request);
            }

            // 2️⃣ Validate token
            if (token != null && jwtProvider.validateToken(token)) {

                // 3️⃣ Avoid duplicate authentication
                if (SecurityContextHolder.getContext().getAuthentication() == null) {

                    String username = jwtProvider.getUsernameFromToken(token);

                    UserDetails userDetails =
                            userDetailsService.loadUserByUsername(username);

                    List<SimpleGrantedAuthority> authorities =
                            jwtProvider.getRolesFromToken(token)
                                    .stream()
                                    .map(SimpleGrantedAuthority::new)
                                    .collect(Collectors.toList());

                    UsernamePasswordAuthenticationToken authentication =
                            new UsernamePasswordAuthenticationToken(
                                    userDetails, null, authorities);

                    authentication.setDetails(
                            new WebAuthenticationDetailsSource().buildDetails(request));

                    SecurityContextHolder.getContext().setAuthentication(authentication);
                }
            }
            // 4️⃣ Invalid token → clear cookie
            else if (token != null) {
                clearAuthCookie(response, request.isSecure());
            }

        } catch (Exception ex) {
            log.warn("JWT authentication error: {}", ex.getMessage());
            clearAuthCookie(response, request.isSecure());
        }

        filterChain.doFilter(request, response);
    }

    private void clearAuthCookie(HttpServletResponse response, boolean secure) {
        ResponseCookie cookie = ResponseCookie.from(TOKEN_COOKIE_NAME, "")
                .httpOnly(true)
                .secure(secure)
                .path("/")
                .maxAge(0)
                .sameSite("Lax")
                .build();

        response.addHeader("Set-Cookie", cookie.toString());
    }
}
