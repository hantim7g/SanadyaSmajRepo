package com.hst.phonepe;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.hst.dto.PaymentRequest;
import com.hst.entity.Payment;
import com.hst.entity.User;
import com.hst.repository.PaymentRepository;
import com.hst.service.PaymentService;
import com.phonepe.sdk.pg.common.models.response.CallbackResponse;
import com.phonepe.sdk.pg.common.models.response.OrderStatusResponse;
import com.phonepe.sdk.pg.common.tokenhandler.TokenService;
import com.phonepe.sdk.pg.payments.v2.StandardCheckoutClient;
import com.phonepe.sdk.pg.payments.v2.models.request.StandardCheckoutPayRequest;
import com.phonepe.sdk.pg.payments.v2.models.response.StandardCheckoutPayResponse;

import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.web.client.RestTemplate;
@Service
public class PPPaymentService {

    @Autowired
    private StandardCheckoutClient client;

    @Value("${phonepe.baseUrl}")
    private String phonePeBaseUrl;

    @Autowired
    private PhonePeAuthService tokenService;
    @Autowired
    private PaymentRepository paymentRepository;
    @Autowired
    private PaymentService offlinePaymentService;
//    @Autowired
//    private PPPaymentService ppPaymentService;
    
    /**
     * Step 1: Create a Pending record and get PhonePe URL
     */
    public String initiatePhonePeTransaction(User user, PaymentRequest req, String redirectUrl, String parentTransactionId) {
        String mTxnId = "MT" + System.currentTimeMillis();

        Payment payment = new Payment();
        payment.setUser(user);
        payment.setTransactionId(mTxnId);
        
        // 1. Handle Amount (Avoid nulls if req.getAmount() is a wrapper Double)
        payment.setAmount(req.getAmount()); 

        // 2. Set Mandatory Defaults
        payment.setStatus("PENDING");
        payment.setPaymentMode("ONLINE_PHONEPE");
        payment.setValidated("प्रक्रिया में");
        payment.setDescription(req.getDescription() != null ? req.getDescription() : "Online Payment");
        
        // 3. Set Current Dates (Mandatory in your entity)
        java.sql.Date now = new java.sql.Date(System.currentTimeMillis());
        payment.setPaymentDate(now);
        payment.setCrtDt(now);
        payment.setLstUpDt(now);
        
        // 4. Safe Date Parsing for feeFrom and feeTo
        payment.setFeeFrom(parseSafeDate(req.getFeeFrom()));
        payment.setFeeTo(parseSafeDate(req.getFeeTo()));
        payment.setParentTransactionId(parentTransactionId); // Link to parent if provided
        paymentRepository.save(payment);

        // Call PhonePe SDK...
        long paise = (long) (req.getAmount() * 100);
        return client.pay(StandardCheckoutPayRequest.builder()
                .merchantOrderId(mTxnId)
                .amount(paise)
                .redirectUrl(redirectUrl+"&merchantOrderId=" + mTxnId) // Optional: pass ID back to UI
                .build()).getRedirectUrl();
    }

    /**
     * Utility to safely convert String to java.sql.Date
     */
    private java.sql.Date parseSafeDate(String dateStr) {
        if (dateStr == null || dateStr.trim().isEmpty()) {
            return null; // Return null if date is not provided
        }
        try {
            return java.sql.Date.valueOf(dateStr); // Assumes YYYY-MM-DD
        } catch (IllegalArgumentException e) {
            // Log error or handle invalid format
            return null;
        }
    }

    /**
     * Step 2: Finalize logic (called by Webhook or Status Check)
     */
    @Transactional 
    public void finalizeOnlinePayment(String mTxnId) {
        Payment masterPayment = paymentRepository.findByTransactionId(mTxnId)
                .orElseThrow(() -> new RuntimeException("Transaction not found"));

        if (!"PENDING".equals(masterPayment.getStatus())) return;

        // Reconstruct a PaymentRequest from the saved Master record
        PaymentRequest req = new PaymentRequest();
        req.setAmount(masterPayment.getAmount());
        req.setDescription(masterPayment.getDescription());
        req.setFeeFrom(masterPayment.getFeeFrom() != null ? masterPayment.getFeeFrom().toString() : null);
        req.setFeeTo(masterPayment.getFeeTo() != null ? masterPayment.getFeeTo().toString() : null);

        // Check if it's the Annual Fee multi-year flow
        if ("वार्षिक शुल्क".equals(req.getDescription())) {
            // Call your existing complex logic
            // Note: imagePath is null because it's an online payment
            offlinePaymentService.saveAnnualMultiYearPayment(req, masterPayment.getUser(), null);
            
            // Update the master record status
            masterPayment.setStatus("SUCCESS");
            masterPayment.setValidated("सफल");
            paymentRepository.save(masterPayment);
        } else {
            // Standard single payment flow
            masterPayment.setStatus("SUCCESS");
            masterPayment.setValidated("सफल");
            paymentRepository.save(masterPayment);
        }
    }
    public String initiatePaymentWithEntity(User user, double amount, String redirectUrl) {
        // Generate a unique Merchant Transaction ID
        String mTxnId = "MT" + System.currentTimeMillis();

        // 1. Create and Save "Pending" Payment record in your DB using your Payment Entity
        Payment payment = new Payment();
        payment.setUser(user);
        payment.setTransactionId(mTxnId);
        payment.setAmount(amount); // Your entity uses double (INR)
        payment.setStatus("PENDING");
        payment.setPaymentMode("UPI/ONLINE");
        payment.setValidated("प्रक्रिया में");
        payment.setPaymentDate(new java.sql.Date(System.currentTimeMillis()));
        payment.setCrtDt(new java.sql.Date(System.currentTimeMillis()));
        
        // Save to your 'payment_history' table
        paymentRepository.save(payment);

        // 2. Build PhonePe Request (SDK requires amount in Paise)
        long amountInPaise = (long) (amount * 100);
        
        StandardCheckoutPayRequest payRequest = StandardCheckoutPayRequest.builder()
                .merchantOrderId(mTxnId)
                .amount(amountInPaise)
                .redirectUrl(redirectUrl + "?tid=" + mTxnId) // Optional: pass ID back to UI
                .build();

        // 3. Call SDK to get the PhonePe Gateway URL
        StandardCheckoutPayResponse response = client.pay(payRequest);
        
        return response.getRedirectUrl();
    }
    
    // 1. Initiate Payment
    public String initiatePayment(long amountInPaise, String redirectUrl) {
        String merchantOrderId = "ORD_" + System.currentTimeMillis();

        StandardCheckoutPayRequest payRequest = StandardCheckoutPayRequest.builder()
                .merchantOrderId(merchantOrderId)
                .amount(amountInPaise)
                .redirectUrl(redirectUrl)
                .build();

        StandardCheckoutPayResponse response = client.pay(payRequest);
        return response.getRedirectUrl(); // Redirect user to this URL
    }

    // 2. Check Order Status
    public String checkStatus(String merchantOrderId) {
       OrderStatusResponse response = client.getOrderStatus(merchantOrderId);
        
       return response.getState(); // Returns COMPLETED, FAILED, or PENDING
    
    // return orderStatus(merchantOrderId)	;
    }
    
    public boolean verifyPayment(String merchantOrderId) {

        try {

//            OrderStatusResponse response =
//                    client.getOrderStatus(merchantOrderId);

            String phonePeState = orderStatus(merchantOrderId);
            
            
//            if (response != null &&
//                    response.getState().equals("COMPLETED")) {
//
//                    return true;
//                }


            
            if ("COMPLETED".equalsIgnoreCase(phonePeState)) {

                return true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // 3. Webhook/Callback Validation
    // Note: Webhook validation is handled in PhonePeController directly using injected credentials.
    // This method is kept for backward compatibility but no longer uses hardcoded values.
    public CallbackResponse validateWebhook(String authHeader, String responseBody, String webhookUser, String webhookPass) {
        return client.validateCallback(webhookUser, webhookPass, authHeader, responseBody);
    }
    public Payment findPaymentByTransactionId(String mTxnId) {
		return
    paymentRepository.findByTransactionId(mTxnId)
				.orElseThrow(() -> new RuntimeException("Transaction not found"));
    }
    public String getAuthToken() {
    	
    return tokenService.generateToken();
	}
    public String  orderStatus(String transactionId) {

        String url = phonePeBaseUrl + "/checkout/v2/order/" + transactionId + "/status?details=false";

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> response = null;
        HttpHeaders headers = new HttpHeaders();
        String state = null;
        String auth=getAuthToken();

        headers.setContentType(MediaType.APPLICATION_JSON);

        headers.set("x-source", "API");
        headers.set("x-source-version", "V2");
        headers.set("x-source-platform", "BACKEND_JAVA_SDK");
        headers.set("x-source-platform-version", "2.2.2");

        headers.set(
                "Authorization",
                "O-Bearer " + auth
        );

        HttpEntity<String> entity =
                new HttpEntity<>(headers);

        try {
        	response =
                    restTemplate.exchange(
                            url,
                            HttpMethod.GET,
                            entity,
                            String.class
                    );

            System.out.println("Status Code : "
                    + response.getStatusCode());

            System.out.println("Response : ");
            System.out.println(response.getBody());
            ObjectMapper objectMapper =
                    new ObjectMapper();

            JsonNode jsonNode =
                    objectMapper.readTree(response.getBody());
             state =
                    jsonNode
                            .get("state")
                            .asText();
        } catch (Exception e) {

            e.printStackTrace();
        }
		return state.toString();
    
    }
}