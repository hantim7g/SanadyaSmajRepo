package com.hst.service;

import com.hst.entity.Payment;
import com.hst.entity.User;
import com.hst.repository.PaymentRepository;
import com.hst.repository.UserRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PaymentService {

    private final PaymentRepository paymentRepository;
    private final UserRepository userRepository;

    public PaymentService(PaymentRepository paymentRepository, UserRepository userRepository) {
        this.paymentRepository = paymentRepository;
        this.userRepository = userRepository;
    }

    // 🔍 Get all payments made by the user (by mobile number)
    public List<Payment> getPaymentsByMobile(String mobile) {
        User user = userRepository.findByMobile(mobile)
                .orElseThrow(() -> new RuntimeException("User not found with mobile: " + mobile));
        return paymentRepository.findByUserId(user.getId());
    }

    // 💾 Save a payment (for future use e.g., online payment integration)
    public Payment savePayment(Payment payment) {
        return paymentRepository.save(payment);
    }

    // 🔍 Optional: Find by user ID directly
    public List<Payment> getPaymentsByUserId(Long userId) {
        return paymentRepository.findByUserId(userId);
    }

    public Payment addPayment(Payment payment) {
        return paymentRepository.save(payment);
    }
}
