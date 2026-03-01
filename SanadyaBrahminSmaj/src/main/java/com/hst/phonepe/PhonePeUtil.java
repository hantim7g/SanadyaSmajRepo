package com.hst.phonepe;

import org.apache.commons.codec.digest.DigestUtils;
import java.util.Base64;

public class PhonePeUtil {

    /**
     * Verifies the X-VERIFY header received in the callback.
     * @param base64Response The body of the POST request (Base64 encoded)
     * @param xVerify The value of the X-VERIFY header
     * @param saltKey Your Merchant Salt Key
     * @param saltIndex Your Merchant Salt Index (e.g., "1")
     * @return boolean true if valid, false otherwise
     */
    public static boolean verifyChecksum(String base64Response, String xVerify, String saltKey, String saltIndex) {
        // Step 1: Concatenate Base64 payload + saltKey
        String stringToHash = base64Response + saltKey;

        // Step 2: Generate SHA256 Hash
        String sha256 = DigestUtils.sha256Hex(stringToHash);

        // Step 3: Append "###" and Salt Index
        String calculatedChecksum = sha256 + "###" + saltIndex;

        // Step 4: Compare (Case-insensitive)
        return calculatedChecksum.equalsIgnoreCase(xVerify);
    }
}