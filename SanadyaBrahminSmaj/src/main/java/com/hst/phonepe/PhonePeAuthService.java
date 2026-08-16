package com.hst.phonepe;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.URL;

import javax.net.ssl.HttpsURLConnection;

@Service
public class PhonePeAuthService {

    @Value("${phonepe.baseUrl}")
    private String baseUrl;

    @Value("${phonepe.oauth.client-id}")
    private String clientId;

    @Value("${phonepe.oauth.client-secret}")
    private String clientSecret;

    public String generateToken() {
        try {
            String requestUrl = baseUrl + "/v1/oauth/token";

            URL url = new URL(requestUrl);
            HttpsURLConnection connection = (HttpsURLConnection) url.openConnection();
            connection.setRequestMethod("POST");
            connection.setDoOutput(true);
            connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");

            String formData = "client_id=" + clientId
                    + "&client_version=1"
                    + "&client_secret=" + clientSecret
                    + "&grant_type=client_credentials";

            try (OutputStream outputStream = connection.getOutputStream()) {
                outputStream.write(formData.getBytes());
                outputStream.flush();
            }

            int responseCode = connection.getResponseCode();
            System.out.println("Response Code : " + responseCode);

            StringBuilder response = new StringBuilder();
            try (BufferedReader bufferedReader = new BufferedReader(
                    new InputStreamReader(connection.getInputStream()))) {
                String line;
                while ((line = bufferedReader.readLine()) != null) {
                    response.append(line);
                }
            }

            String responseString = response.toString();
            System.out.println("TOKEN RESPONSE : " + responseString);

            ObjectMapper objectMapper = new ObjectMapper();
            JsonNode jsonNode = objectMapper.readTree(responseString);
            return jsonNode.get("access_token").asText();

        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}