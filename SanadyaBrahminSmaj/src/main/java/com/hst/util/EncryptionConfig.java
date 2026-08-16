package com.hst.util;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import javax.crypto.SecretKey;

/**
 * Spring configuration that initializes the AES-256-GCM encryption key
 * from application.properties and makes it available to the JPA converter.
 */
@Configuration
public class EncryptionConfig {

    /**
     * Provides the AES-256 secret key for Aadhaar encryption.
     * Also injects it into {@link EncryptedStringConverter} so the non-Spring-managed
     * JPA converter can access it.
     */
    @Bean
    public SecretKey aadhaarEncryptionKey(
            @Value("${aadhaar.encryption.key}") String base64Key) {
        SecretKey key = EncryptionUtil.getSecretKey(base64Key);
        EncryptedStringConverter.setSecretKey(key);
        return key;
    }
}
