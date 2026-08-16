package com.hst.util;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.spec.GCMParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.security.SecureRandom;
import java.util.Base64;

/**
 * AES-256-GCM encryption utility for encrypting sensitive data at rest (e.g., Aadhaar numbers).
 *
 * Each encryption call generates a fresh random 12-byte IV (nonce), which is prepended
 * to the ciphertext. This ensures that the same plaintext encrypts to different ciphertexts
 * every time (semantic security).
 *
 * Format: Base64( IV[12] + Ciphertext + AuthTag[16] )
 *
 * Requirements:
 *   - AES key must be a 256-bit (32-byte) Base64-encoded string set in application.properties
 *   - GCM tag length: 128 bits (default, strongest)
 *   - IV length: 12 bytes (96 bits, NIST-recommended for GCM)
 */
public final class EncryptionUtil {

    private static final String ALGORITHM = "AES/GCM/NoPadding";
    private static final int GCM_IV_LENGTH = 12;   // 96 bits — NIST recommended
    private static final int GCM_TAG_LENGTH = 128;  // 128-bit authentication tag
    private static final String DELIMITER = "|";    // separator for IV + ciphertext

    private EncryptionUtil() {
        // utility class — no instantiation
    }

    /**
     * Derives a 256-bit AES SecretKey from a Base64-encoded key string.
     */
    public static SecretKey getSecretKey(String base64Key) {
        byte[] keyBytes = Base64.getDecoder().decode(base64Key);
        return new SecretKeySpec(keyBytes, "AES");
    }

    /**
     * Encrypts a plaintext string using AES-256-GCM with a random IV.
     *
     * @param plaintext  the value to encrypt (e.g., "293926382492")
     * @param secretKey  the AES-256 secret key
     * @return Base64-encoded string containing: IV + ciphertext + auth tag
     */
    public static String encrypt(String plaintext, SecretKey secretKey) {
        if (plaintext == null || plaintext.isBlank()) {
            return plaintext; // don't encrypt null/blank — store as-is
        }
        try {
            // Generate a cryptographically secure random IV for each encryption
            byte[] iv = new byte[GCM_IV_LENGTH];
            new SecureRandom().nextBytes(iv);

            Cipher cipher = Cipher.getInstance(ALGORITHM);
            GCMParameterSpec gcmSpec = new GCMParameterSpec(GCM_TAG_LENGTH, iv);
            cipher.init(Cipher.ENCRYPT_MODE, secretKey, gcmSpec);

            byte[] ciphertext = cipher.doFinal(plaintext.getBytes(java.nio.charset.StandardCharsets.UTF_8));

            // Prepend IV to ciphertext: IV + ciphertext
            byte[] combined = new byte[iv.length + ciphertext.length];
            System.arraycopy(iv, 0, combined, 0, iv.length);
            System.arraycopy(ciphertext, 0, combined, iv.length, ciphertext.length);

            return Base64.getEncoder().encodeToString(combined);
        } catch (Exception e) {
            throw new RuntimeException("Aadhaar encryption failed", e);
        }
    }

    /**
     * Decrypts a Base64-encoded AES-256-GCM ciphertext.
     *
     * @param encryptedBase64  the encrypted value from DB
     * @param secretKey        the AES-256 secret key
     * @return the original plaintext string
     */
    public static String decrypt(String encryptedBase64, SecretKey secretKey) {
        if (encryptedBase64 == null || encryptedBase64.isBlank()) {
            return encryptedBase64; // nothing to decrypt
        }
        try {
            byte[] combined = Base64.getDecoder().decode(encryptedBase64);

            // Extract IV (first 12 bytes) and ciphertext (rest)
            byte[] iv = new byte[GCM_IV_LENGTH];
            byte[] ciphertext = new byte[combined.length - GCM_IV_LENGTH];
            System.arraycopy(combined, 0, iv, 0, iv.length);
            System.arraycopy(combined, iv.length, ciphertext, 0, ciphertext.length);

            Cipher cipher = Cipher.getInstance(ALGORITHM);
            GCMParameterSpec gcmSpec = new GCMParameterSpec(GCM_TAG_LENGTH, iv);
            cipher.init(Cipher.DECRYPT_MODE, secretKey, gcmSpec);

            byte[] plainBytes = cipher.doFinal(ciphertext);
            return new String(plainBytes, java.nio.charset.StandardCharsets.UTF_8);
        } catch (Exception e) {
            throw new RuntimeException("Aadhaar decryption failed — data may be corrupted or key mismatch", e);
        }
    }

    /**
     * Masks an Aadhaar number for display: "293926382492" → "XXXX-XXXX-2492"
     */
    public static String mask(String aadhaar) {
        if (aadhaar == null || aadhaar.length() < 4) {
            return aadhaar;
        }
        return "XXXX-XXXX-" + aadhaar.substring(aadhaar.length() - 4);
    }
}
