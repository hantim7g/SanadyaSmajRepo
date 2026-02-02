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

@Configuration
public class SecurityConfig {

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

        http
            /* ---------- CORS ---------- */
        .cors(cors -> cors.configurationSource(request -> {
            CorsConfiguration config = new CorsConfiguration();
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

                /* 🔐 ADMIN ONLY */
                .requestMatchers("/admin/**").hasAuthority("ROLE_ADMIN")
                .requestMatchers("/rooms/admin").hasAuthority("ROLE_ADMIN")
                .requestMatchers("/rooms/admin/**").hasAuthority("ROLE_ADMIN")
                
                /* 🔐 LOGIN REQUIRED (USER / ADMIN) */
                .requestMatchers(
                        "/user/**",
                        "/member/**",
                        "/matrimony/**",
                        "/testimonial/my-testimonials",
                        "/member/add-testimonial",
                        "/member/save-testimonial",
                        "/member/edit-testimonial/**",
                        "/member/update-testimonial/**",
                        "/member/testimonial/delete/**"
                ).authenticated()

                /* 🌍 PUBLIC */
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
                        "/favicon.ico",
                        "/event/**",
                        "/testimonials",
                        "/matrimony/list",
                        "/matrimony/search"
                ).permitAll()

                /* 🌍 DEFAULT */
                .anyRequest().permitAll()
            )

            /* ---------- EXCEPTION HANDLING ---------- */
            .exceptionHandling(ex -> ex
                .accessDeniedHandler(accessDeniedHandler)
                .authenticationEntryPoint((request, response, authException) -> {

                    String accept = request.getHeader("Accept");
                    String xhr = request.getHeader("X-Requested-With");

                    boolean isApiCall =
                            (accept != null && accept.contains("application/json")) ||
                            ("XMLHttpRequest".equalsIgnoreCase(xhr));

                    if (isApiCall) {
                        // 🔹 AJAX / API → JSON
                        response.setCharacterEncoding("UTF-8");
                        response.setContentType("application/json; charset=UTF-8");
                        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                        response.getWriter().write("{\"message\":\"कृपया लॉगिन करें।\"}");
                    } else {
                        // 🔹 BROWSER → REDIRECT WITH FLASH MESSAGE
                    	 response.sendRedirect("/?error=login_required");
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

        return http.build();
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
