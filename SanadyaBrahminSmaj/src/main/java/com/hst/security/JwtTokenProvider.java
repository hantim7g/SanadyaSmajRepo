package com.hst.security;

import io.jsonwebtoken.*;
import io.jsonwebtoken.security.Keys;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.nio.charset.StandardCharsets;
import java.security.Key;
import java.util.*;
import java.util.stream.Collectors;

@Component
public class JwtTokenProvider {

    private static final Logger log = LoggerFactory.getLogger(JwtTokenProvider.class);

    private static final String TOKEN_COOKIE_NAME = "authToken";
    private static final String ISSUER = "hst-api";
    private static final String AUDIENCE = "hst-client";

    @Value("${jwt.secret}")
    private String jwtSecret;

    @Value("${jwt.expiration}")
    private long jwtExpiration;

    /* =========================
       Signing Key
       ========================= */
    private Key getSigningKey() {
        byte[] keyBytes;
        try {
            keyBytes = Base64.getDecoder().decode(jwtSecret);
        } catch (IllegalArgumentException ex) {
            keyBytes = jwtSecret.getBytes(StandardCharsets.UTF_8);
        }

        if (keyBytes.length < 32) {
            throw new IllegalStateException("JWT secret must be at least 256 bits (32 bytes)");
        }
        return Keys.hmacShaKeyFor(keyBytes);
    }

    /* =========================
       Token Generation
       ========================= */
    public String generateToken(String username, Collection<String> roles) {

        Map<String, Object> claims = new HashMap<>();
        claims.put("roles", roles);

        Date now = new Date();
        Date expiry = new Date(now.getTime() + jwtExpiration);

        return Jwts.builder()
                .setClaims(claims)
                .setSubject(username)
                .setIssuer(ISSUER)
                .setAudience(AUDIENCE)
                .setIssuedAt(now)
                .setExpiration(expiry)
                .signWith(getSigningKey(), SignatureAlgorithm.HS256)
                .compact();
    }

    /* =========================
       Token Parsing
       ========================= */
    public String getUsernameFromToken(String token) {
        return getAllClaims(token).getSubject();
    }

    public List<String> getRolesFromToken(String token) {
        Object rolesObj = getAllClaims(token).get("roles");

        if (rolesObj instanceof List<?>) {
            return ((List<?>) rolesObj)
                    .stream()
                    .map(Object::toString)
                    .collect(Collectors.toList());
        }

        return Collections.emptyList();
    }

    /* =========================
       Token Validation
       ========================= */
    public boolean validateToken(String token) {
        try {
            getAllClaims(token);
            return true;
        } catch (ExpiredJwtException e) {
            log.warn("JWT expired");
        } catch (JwtException | IllegalArgumentException e) {
            log.warn("Invalid JWT: {}", e.getMessage());
        }
        return false;
    }

    /* =========================
       Token Extraction
       ========================= */
    public String getJwtFromHeader(HttpServletRequest request) {
        String header = request.getHeader("Authorization");
        if (header != null && header.startsWith("Bearer ")) {
            return header.substring(7);
        }
        return null;
    }

    public String getJwtFromCookies(HttpServletRequest request) {
        if (request.getCookies() == null) {
            return null;
        }
        for (Cookie cookie : request.getCookies()) {
            if (TOKEN_COOKIE_NAME.equals(cookie.getName())) {
                return cookie.getValue();
            }
        }
        return null;
    }

    /* =========================
       Internal Claims Parser
       ========================= */
    private Claims getAllClaims(String token) {
        return Jwts.parserBuilder()
                .setSigningKey(getSigningKey())
                .requireIssuer(ISSUER)
                .requireAudience(AUDIENCE)
                .build()
                .parseClaimsJws(token)
                .getBody();
    }
}
