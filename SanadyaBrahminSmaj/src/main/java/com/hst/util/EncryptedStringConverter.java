package com.hst.util;

import jakarta.persistence.AttributeConverter;
import jakarta.persistence.Converter;
import javax.crypto.SecretKey;

/**
 * JPA AttributeConverter that transparently encrypts/decrypts the Aadhaar number
 * using AES-256-GCM before/after database read/write.
 *
 * Usage in entity:
 *   @Convert(converter = EncryptedStringConverter.class)
 *   private String aadharNumber;
 *
 * The encryption key is provided by EncryptionConfig Spring bean, which reads
 * from application.properties: aadhaar.encryption.key
 */
@Converter
public class EncryptedStringConverter implements AttributeConverter<String, String> {

    /**
     * Holds the Spring-managed SecretKey.
     * Set by {@link EncryptionConfig} via Spring's ApplicationContext.
     */
    private static volatile SecretKey secretKey;

    /**
     * Called by Spring to inject the encryption key bean into this non-Spring-managed converter.
     */
    public static void setSecretKey(SecretKey key) {
        secretKey = key;
    }

    private static SecretKey getSecretKey() {
        if (secretKey == null) {
            throw new IllegalStateException(
                "Aadhaar encryption key not initialized. Ensure EncryptionConfig is loaded."
            );
        }
        return secretKey;
    }

    @Override
    public String convertToDatabaseColumn(String attribute) {
        if (attribute == null || attribute.isBlank()) {
            return attribute;
        }
        return EncryptionUtil.encrypt(attribute, getSecretKey());
    }

    @Override
    public String convertToEntityAttribute(String dbData) {
        if (dbData == null || dbData.isBlank()) {
            return dbData;
        }
        // Detect if data is already encrypted (Base64 with IV prefix) vs legacy plaintext
        if (isLikelyEncrypted(dbData)) {
            return EncryptionUtil.decrypt(dbData, getSecretKey());
        }
        // Legacy plaintext Aadhaar — return as-is (will be encrypted on next save)
        return dbData;
    }

    /**
     * Heuristic to distinguish encrypted data from legacy plaintext.
     * Encrypted data is Base64 and typically longer than 24 chars (12-byte IV + ciphertext + tag).
     * A plain 12-digit Aadhaar number will never match valid Base64 with length > 24.
     */
    private boolean isLikelyEncrypted(String value) {
        if (value.length() <= 12) {
            return false; // definitely plaintext Aadhaar (12 digits)
        }
        try {
            byte[] decoded = java.util.Base64.getDecoder().decode(value);
            // Encrypted payload: 12 (IV) + >=16 (AES block) + 16 (GCM tag) = min 44 bytes
            return decoded.length >= 28;
        } catch (IllegalArgumentException e) {
            return false; // not valid Base64 → plaintext
        }
    }
}
