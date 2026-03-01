package com.hst.phonepe;

import com.hst.entity.Payment;
import com.hst.repository.PaymentRepository;
import com.phonepe.sdk.pg.payments.v2.StandardCheckoutClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import com.phonepe.sdk.pg.common.models.response.OrderStatusResponse;
import java.util.List;

@Service
public class PaymentSyncScheduler {

    @Autowired
    private PaymentRepository paymentRepository;

    @Autowired
    private StandardCheckoutClient phonePeClient;

    /**
     * Runs every 30 minutes (1800000 ms)
     * You can also use cron: @Scheduled(cron = "0 0/30 * * * *")
     */
    @Scheduled(fixedDelay = 1800000)
    public void syncPendingPayments() {
        System.out.println("PaymentSyncScheduler: Checking for pending payments...");

        // 1. Fetch all payments with status 'PENDING'
        List<Payment> pendingPayments = paymentRepository.findByStatus("PENDING");

        for (Payment payment : pendingPayments) {
            try {
                // 2. Query PhonePe for the actual status
                OrderStatusResponse response = phonePeClient.getOrderStatus(payment.getTransactionId());
                
                String phonePeState = response.getState(); // COMPLETED, FAILED, or PENDING

                // 3. Update database if the status has changed
                if ("COMPLETED".equalsIgnoreCase(phonePeState)) {
                    updatePaymentStatus(payment, "SUCCESS", "सफल");
                } else if ("FAILED".equalsIgnoreCase(phonePeState)) {
                    updatePaymentStatus(payment, "FAILED", "विफल");
                }
                
                // If still PENDING, we leave it for the next run
                
            } catch (Exception e) {
                System.err.println("Error syncing payment " + payment.getTransactionId() + ": " + e.getMessage());
            }
        }
    }

    private void updatePaymentStatus(Payment payment, String status, String validated) {
        payment.setStatus(status);
        payment.setValidated(validated);
        payment.setLstUpDt(new java.sql.Date(System.currentTimeMillis()));
        paymentRepository.save(payment);
        System.out.println("Updated Transaction " + payment.getTransactionId() + " to " + status);
    }
}