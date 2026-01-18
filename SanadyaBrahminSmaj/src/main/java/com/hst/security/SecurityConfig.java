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
        return http
            .cors(cors -> {}) // enable CORS with the configuration from corsConfigurationSource()
            .csrf(csrf -> csrf.disable())
            .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS)) // 🔒 Stateless
            .authorizeHttpRequests(auth -> auth
//                .requestMatchers(
//                    "/api/auth/**",
//                    "/swagger-ui/**",
//                    "/v3/api-docs/**",
//                    "/swagger-ui.html"
//                ).permitAll() // 🔓 Public routes
//                .requestMatchers(
//                			"/",
//                        "/home",
//                        "/index",
//                        "/index.html",
//                        "/css/**",
//                        "/js/**",
//                        "/images/**",
//                        "/favicon.ico"
//                    ).permitAll()
//                .requestMatchers("/h2-console/**").hasAuthority("ADMIN") // 🔐 H2 console restricted to ADMIN
//                .requestMatchers("/matrimony/my-profiles").hasAnyAuthority("USER", "ADMIN") 
//                .requestMatchers("/admin/**").hasAuthority("ADMIN")// 🔐 Protected by role
//                .requestMatchers("/matrimony/**").authenticated() // All other matrimony routes need login
//                .requestMatchers("/testimonials").permitAll()
//                .requestMatchers("/member/add-testimonial", "/member/save-testimonial", 
//                                "/member/edit-testimonial/**", "/member/update-testimonial/**", 
//                                "/testimonial/my-testimonials", "/member/testimonial/delete/**").hasAnyAuthority("USER", "ADMIN")
                .requestMatchers( "/admin/**").hasAuthority("ADMIN")
                .anyRequest().permitAll() 
//                .anyRequest().authenticated() // Everything else requires authentication
            )
            .logout(logout -> logout.disable())
            .exceptionHandling(ex -> ex
                .accessDeniedHandler(accessDeniedHandler)
                .authenticationEntryPoint((request, response, authException) -> {
                    response.setCharacterEncoding("UTF-8");
                    response.setContentType("application/json; charset=UTF-8");
                    response.setStatus(HttpServletResponse.SC_UNAUTHORIZED); // 401
                    response.getWriter().write("{\"message\": \"कृपया लॉगिन करें।\"}");
                })
            )
            .authenticationProvider(authenticationProvider())
            .addFilterBefore(jwtFilter, UsernamePasswordAuthenticationFilter.class)
            .headers(headers -> headers.frameOptions().sameOrigin()) // allow frames for H2 console
            .build();
    }

    @Bean
    public DaoAuthenticationProvider authenticationProvider() {
        DaoAuthenticationProvider provider = new DaoAuthenticationProvider();
        provider.setUserDetailsService(userDetailsService);
        provider.setPasswordEncoder(passwordEncoder());
        return provider;
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder(); // Use bcrypt for secure password hashing
    }

    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration config) throws Exception {
        return config.getAuthenticationManager();
    }

    // CORS configuration: allow Authorization header and cookies (credentials).
    @Bean
    public CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration configuration = new CorsConfiguration();
        // TODO: replace '*' with explicit origins in production
        configuration.setAllowedOriginPatterns(List.of("http://localhost:3000")); // 🔒 Restrict to specific origin
        configuration.setAllowedMethods(List.of("GET", "POST", "PUT", "DELETE", "OPTIONS"));
        configuration.setAllowedHeaders(List.of("Authorization", "Cache-Control", "Content-Type"));
        configuration.setAllowCredentials(true);
        configuration.setExposedHeaders(List.of("Set-Cookie"));
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", configuration);
        return source;
    }
}