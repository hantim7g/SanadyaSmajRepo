package com.hst.security;

import com.hst.filter.JwtAuthenticationFilter;
import com.hst.service.CustomUserDetailsService;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Configuration
public class SecurityConfig {

    private static final Logger log = LoggerFactory.getLogger(SecurityConfig.class);

    private final CustomUserDetailsService userDetailsService;
    private final JwtAuthenticationFilter jwtFilter;
    private final CustomAccessDeniedHandler accessDeniedHandler;

    public SecurityConfig(CustomUserDetailsService userDetailsService,
                          JwtAuthenticationFilter jwtFilter,
                          CustomAccessDeniedHandler accessDeniedHandler) {
        this.userDetailsService = userDetailsService;
        this.jwtFilter = jwtFilter;
        this.accessDeniedHandler = accessDeniedHandler;
    }

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {

        log.info("🔐 Initializing SecurityFilterChain...");

        http
            /* ---------- CORS ---------- */
        .cors(cors -> cors.configurationSource(request -> {
            CorsConfiguration config = new CorsConfiguration();
            String origin = request.getHeader("Origin");
            if (origin != null && !origin.isBlank()) {
                log.debug("🌐 CORS request from origin: {}", origin);
            }
            config.addAllowedOriginPattern("*");
            config.addAllowedMethod("*");
            config.addAllowedHeader("*");
            config.setAllowCredentials(true);
            return config;
        }))

            /* ---------- CSRF ---------- */
            .csrf(csrf -> csrf.disable())

            /* ---------- SESSION ---------- */
            .sessionManagement(session ->
                session.sessionCreationPolicy(SessionCreationPolicy.STATELESS)
            )

            /* ---------- AUTHORIZATION ---------- */
            .authorizeHttpRequests(auth -> auth

                /* 🔐 ADMIN ONLY — specific paths first (evaluated in order) */
                .requestMatchers("/admin/**").hasAuthority("ROLE_ADMIN")
                .requestMatchers("/api/admin/**").hasAuthority("ROLE_ADMIN")
                .requestMatchers("/api/auth/makeAdmin").hasAuthority("ROLE_ADMIN")
                .requestMatchers("/bookings/admin/**").hasAuthority("ROLE_ADMIN")
                .requestMatchers("/bookings/checkin/**").hasAuthority("ROLE_ADMIN")
                .requestMatchers("/bookings/checkout/**").hasAuthority("ROLE_ADMIN")
                .requestMatchers("/officials/admin/**").hasAuthority("ROLE_ADMIN")
                .requestMatchers("/rooms/admin").hasAuthority("ROLE_ADMIN")
                .requestMatchers("/rooms/admin/**").hasAuthority("ROLE_ADMIN")
                .requestMatchers("/rooms/delete/**").hasAuthority("ROLE_ADMIN")
                .requestMatchers("/rooms/save").hasAuthority("ROLE_ADMIN")
                .requestMatchers("/events/save").hasAuthority("ROLE_ADMIN")

                /* 🔐 LOGIN REQUIRED (USER / ADMIN) */
                .requestMatchers(
                        "/user/**",
                        "/api/user/**",
                        "/member/**",
                        "/matrimony/**",
                        "/testimonial/my-testimonials",
                        "/member/add-testimonial",
                        "/member/save-testimonial",
                        "/member/edit-testimonial/**",
                        "/member/update-testimonial/**",
                        "/member/testimonial/delete/**",
                        "/api/auth/upload-profile-image",
                        "/api/auth/upload-aadhar-image",
                        "/api/upload-image",
                        "/api/phonepe/check-status/**",
                        "/api/payment/**",
                        "/bookings/save",
                        "/bookings/payment/response",
                        "/bookings/invoice/pdf/**",
                        "/my-bookings"
                ).authenticated()

                /* 🌍 PUBLIC — static resources & JSP views (internal forwards only) */
                .requestMatchers(
                        "/",
                        "/home",
                        "/index",
                        "/index.html",
                        "/login",
                        "/register",
                        "/css/**",
                        "/js/**",
                        "/images/**",
                        "/logo/**",
                        "/favicon.ico",
                        "/events/**",
                        "/WEB-INF/views/**"
                ).permitAll()

                /* 🌍 PUBLIC — auth endpoints (login, register, forgot-password, me) */
                .requestMatchers(
                        "/api/auth/login",
                        "/api/auth/register",
                        "/api/auth/forgot-password",
                        "/api/auth/me"
                ).permitAll()

                /* 🌍 PUBLIC — content pages */
                .requestMatchers(
                        "/testimonials",
                        "/calendar",
                        "/festivals",
                        "/gotra",
                        "/guidance",
                        "/shubhkamna",
                        "/smajHistory",
                        "/smajUddeshLakshya",
                        "/officials/",
                        "/matrimony/list",
                        "/matrimony/search"
                ).permitAll()

                /* 🌍 PUBLIC — events (read-only) */
                .requestMatchers(
                        "/events/",
                        "/events/form",
                        "/events/list",
                        "/events/{id}"
                ).permitAll()

                /* 🌍 PUBLIC — rooms (read-only) */
                .requestMatchers(
                        "/rooms/filter",
                        "/rooms/get/{id}",
                        "/rooms/view"
                ).permitAll()

                /* 🌍 PUBLIC — bookings (guest/public actions) */
                .requestMatchers(
                        "/bookings/add",
                        "/bookings/cancel/**",
                        "/bookings/view/**",
                        "/bookings/receipt/**",
                        "/bookings/verify-booking/**"
                ).permitAll()

                /* 🌍 PUBLIC — misc */
                .requestMatchers(
                        "/error",
                        "/logout",
                        "/api/phonepe/webhook"
                ).permitAll()

                /* 🔒 DEFAULT: require authentication for everything else (secure by default) */
                .anyRequest().authenticated()
            )

            /* ---------- EXCEPTION HANDLING ---------- */
            .exceptionHandling(ex -> ex
                .accessDeniedHandler(accessDeniedHandler)
                .authenticationEntryPoint((request, response, authException) -> {

                    String uri = request.getRequestURI();
                    String method = request.getMethod();
                    String query = request.getQueryString();
                    String accept = request.getHeader("Accept");
                    String xhr = request.getHeader("X-Requested-With");
                    String referer = request.getHeader("Referer");

                    boolean isApiCall =
                            (accept != null && accept.contains("application/json")) ||
                            ("XMLHttpRequest".equalsIgnoreCase(xhr));

                    log.warn("⛔ AUTH FAILED — URI: {} | Method: {} | Query: {} | Accept: {} | X-Requested-With: {} | Referer: {} | API: {} | Reason: {}",
                            uri, method, (query != null ? query : "none"),
                            (accept != null ? accept : "none"),
                            (xhr != null ? xhr : "none"),
                            (referer != null ? referer : "none"),
                            isApiCall, authException.getMessage());

                    if (isApiCall) {
                        // 🔹 AJAX / API → JSON
                        response.setCharacterEncoding("UTF-8");
                        response.setContentType("application/json; charset=UTF-8");
                        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                        response.getWriter().write("{\"message\":\"कृपया लॉगिन करें।\"}");
                        log.info("✅ AUTH FAILED — returned 401 JSON for API call: {}", uri);
                    } else {
                        // 🔹 BROWSER → REDIRECT WITH FLASH MESSAGE
                    	 response.sendRedirect("/?error=login_required");
                    	 log.info("✅ AUTH FAILED — redirected to /?error=login_required for browser: {}", uri);
                    }
                })

            )

            /* ---------- AUTH PROVIDER ---------- */
            .authenticationProvider(authenticationProvider())

            /* ---------- JWT FILTER ---------- */
            .addFilterBefore(jwtFilter, UsernamePasswordAuthenticationFilter.class)

            /* ---------- LOGOUT ---------- */
            .logout(logout -> logout.disable())

            /* ---------- H2 / FRAMES ---------- */
            .headers(headers -> headers.frameOptions().sameOrigin());

        SecurityFilterChain chain = http.build();
        log.info("✅ SecurityFilterChain built successfully");
        return chain;
    }

    /* ---------- AUTH PROVIDER ---------- */
    @Bean
    public DaoAuthenticationProvider authenticationProvider() {
        DaoAuthenticationProvider provider = new DaoAuthenticationProvider();
        provider.setUserDetailsService(userDetailsService);
        provider.setPasswordEncoder(passwordEncoder());
        return provider;
    }

    /* ---------- PASSWORD ---------- */
    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    /* ---------- AUTH MANAGER ---------- */
    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration config) throws Exception {
        return config.getAuthenticationManager();
    }

    /* ---------- CORS ---------- */
    @Bean
    public CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration configuration = new CorsConfiguration();

        configuration.setAllowedOriginPatterns(List.of(
                "http://localhost:8080"
        ));
        configuration.setAllowedMethods(List.of("GET", "POST", "PUT", "DELETE", "OPTIONS"));
        configuration.setAllowedHeaders(List.of("Authorization", "Cache-Control", "Content-Type"));
        configuration.setAllowCredentials(true);
        configuration.setExposedHeaders(List.of("Set-Cookie"));

        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", configuration);
        return source;
    }
}
//@Configuration
//public class SecurityConfig {
//
//    private final CustomUserDetailsService userDetailsService;
//    private final JwtAuthenticationFilter jwtFilter;
//    private final CustomAccessDeniedHandler accessDeniedHandler;
//
//    public SecurityConfig(CustomUserDetailsService userDetailsService,
//                          JwtAuthenticationFilter jwtFilter,
//                          CustomAccessDeniedHandler accessDeniedHandler) {
//        this.userDetailsService = userDetailsService;
//        this.jwtFilter = jwtFilter;
//        this.accessDeniedHandler = accessDeniedHandler;
//    }
//
//    @Bean
//    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
//
//        http
//            /* ---------- CORS ---------- */
//            .cors(cors->cors.disable())
//
//            /* ---------- CSRF (DISABLED FOR NGROK TESTING) ---------- */
//            .csrf(csrf -> csrf.disable())
//
//            /* ---------- SESSION ---------- */
//            .sessionManagement(session ->
//                session.sessionCreationPolicy(SessionCreationPolicy.STATELESS)
//            )
//
//            /* ---------- AUTHORIZATION ---------- */
//            .authorizeHttpRequests(auth -> auth
//
//                /* 🔐 ADMIN ONLY */
//                
//                .anyRequest().permitAll()
//            )
//
//            /* ---------- EXCEPTION HANDLING ---------- */
//            .exceptionHandling(ex -> ex
//                .accessDeniedHandler(accessDeniedHandler)
//                .authenticationEntryPoint((request, response, authException) -> {
//
//                    String accept = request.getHeader("Accept");
//                    String xhr = request.getHeader("X-Requested-With");
//
//                    boolean isApiCall =
//                            (accept != null && accept.contains("application/json")) ||
//                            ("XMLHttpRequest".equalsIgnoreCase(xhr));
//
//                    if (isApiCall) {
//                        response.setCharacterEncoding("UTF-8");
//                        response.setContentType("application/json; charset=UTF-8");
//                        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
//                        response.getWriter().write("{\"message\":\"कृपया लॉगिन करें।\"}");
//                    } else {
//                        response.sendRedirect("/login");
//                    }
//                })
//            )
//
//            /* ---------- AUTH PROVIDER ---------- */
//            .authenticationProvider(authenticationProvider())
//
//            /* ---------- JWT FILTER (KEEP ENABLED) ---------- */
//            .addFilterBefore(jwtFilter, UsernamePasswordAuthenticationFilter.class)
//
//            /* ---------- LOGOUT ---------- */
//            .logout(logout -> logout.disable())
//
//            /* ---------- FRAMES ---------- */
//            .headers(headers -> headers.frameOptions().sameOrigin());
//
//        return http.build();
//    }
//
//    /* ---------- AUTH PROVIDER ---------- */
//    @Bean
//    public DaoAuthenticationProvider authenticationProvider() {
//        DaoAuthenticationProvider provider = new DaoAuthenticationProvider();
//        provider.setUserDetailsService(userDetailsService);
//        provider.setPasswordEncoder(passwordEncoder());
//        return provider;
//    }
//
//    @Bean
//    public PasswordEncoder passwordEncoder() {
//        return new BCryptPasswordEncoder();
//    }
//
//    @Bean
//    public AuthenticationManager authenticationManager(AuthenticationConfiguration config)
//            throws Exception {
//        return config.getAuthenticationManager();
//    }
//
//    /* ---------- CORS (NGROK SAFE) ---------- */
//    @Bean
//    public CorsConfigurationSource corsConfigurationSource() {
//
//        CorsConfiguration configuration = new CorsConfiguration();
//
//        configuration.setAllowedOriginPatterns(List.of(
//                "http://localhost:*",
//                "https://*.ngrok.io",
//                "https://*.ngrok-free.app"
//        ));
//
//        configuration.setAllowedMethods(List.of(
//                "GET", "POST", "PUT", "DELETE", "OPTIONS"
//        ));
//
//        configuration.setAllowedHeaders(List.of(
//                "*"
//        ));
//
//        configuration.setAllowCredentials(true);
//
//        configuration.setExposedHeaders(List.of(
//                "Authorization", "Set-Cookie"
//        ));
//
//        UrlBasedCorsConfigurationSource source =
//                new UrlBasedCorsConfigurationSource();
//
//        source.registerCorsConfiguration("/**", configuration);
//        return source;
//    }
//}
