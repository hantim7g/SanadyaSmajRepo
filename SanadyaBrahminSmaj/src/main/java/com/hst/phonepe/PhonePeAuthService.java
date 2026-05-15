package com.hst.phonepe;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import javax.net.ssl.HttpsURLConnection;

import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.URL;

@Service
public class PhonePeAuthService {

    public static String generateToken() {

        try {

            String requestUrl =
                    "https://api-preprod.phonepe.com/apis/pg-sandbox/v1/oauth/token";

            URL url =
                    new URL(requestUrl);

            HttpsURLConnection connection =
                    (HttpsURLConnection) url.openConnection();

            connection.setRequestMethod("POST");

            connection.setDoOutput(true);

            connection.setRequestProperty(
                    "Content-Type",
                    "application/x-www-form-urlencoded"
            );

            String formData =
                    "client_id=M23FGNCRWGL87_2603012008"
                            + "&client_version=1"
                            + "&client_secret=NDVlNzdjNTctOTBjYy00OGU0LWE3NWEtM2Y1YTkzNWY4OGIz"
                            + "&grant_type=client_credentials";

            OutputStream outputStream =
                    connection.getOutputStream();

            outputStream.write(
                    formData.getBytes()
            );

            outputStream.flush();
            outputStream.close();

            int responseCode =
                    connection.getResponseCode();

            System.out.println(
                    "Response Code : "
                            + responseCode
            );

            BufferedReader bufferedReader =
                    new BufferedReader(
                            new InputStreamReader(
                                    connection.getInputStream()
                            )
                    );

            StringBuilder response =
                    new StringBuilder();

            String line;

            while ((line = bufferedReader.readLine()) != null) {

                response.append(line);
            }

            bufferedReader.close();

            String responseString =
                    response.toString();

            System.out.println(
                    "TOKEN RESPONSE : "
                            + responseString
            );

            ObjectMapper objectMapper =
                    new ObjectMapper();

            JsonNode jsonNode =
                    objectMapper.readTree(
                            responseString
                    );

            return jsonNode
                    .get("access_token")
                    .asText();

        } catch (Exception e) {

            e.printStackTrace();

            return null;
        }
    }
}