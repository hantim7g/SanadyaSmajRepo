package com.hst.phonepe;



import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.phonepe.sdk.pg.Env;
import com.phonepe.sdk.pg.payments.v2.StandardCheckoutClient;
@Configuration
public class PhonePeConfig {

    @Value("${phonepe.merchantId}") private String merchantId;
    @Value("${phonepe.saltKey}") private String saltKey;
    @Value("${phonepe.saltIndex}") private Integer saltIndex;
    @Value("${phonepe.env}") private String envString;

    @Bean
    public StandardCheckoutClient standardCheckoutClient() {
        // Convert String from properties to Env enum
        Env phonePeEnv = "PRODUCTION".equalsIgnoreCase(envString) ? Env.PRODUCTION : Env.SANDBOX;

        return StandardCheckoutClient.getInstance(
            merchantId, 
            saltKey, 
            saltIndex, 
            phonePeEnv
        );
    }
}