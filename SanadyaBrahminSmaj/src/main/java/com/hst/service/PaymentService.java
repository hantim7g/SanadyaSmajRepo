package com.hst.service;

import com.hst.dto.PaymentRequest;
import com.hst.entity.Payment;
import com.hst.entity.User;
import com.hst.repository.PaymentRepository;
import com.hst.repository.UserRepository;

import jakarta.transaction.Transactional;

import org.springframework.stereotype.Service;

import java.sql.Date;
import java.time.LocalDate;
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


	public Payment findPaymentById(Long Id) {
		return paymentRepository.findPaymentById(Id);
	}
	
	@Transactional
	public void saveAnnualMultiYearPayment(PaymentRequest req, User user, String imagePath) {
	    List<String> years = req.getFinancialYears();
	    int totalYears = years.size();
	    
	    // Calculate split amount
	    double totalAmount = req.getAmount();
	    double perYearAmount = Math.floor((totalAmount / totalYears) * 100) / 100.0;
	    double lastYearAmount = totalAmount - (perYearAmount * (totalYears - 1));

	    for (int i = 0; i < totalYears; i++) {
	        String fy = years.get(i);
	        Payment p = new Payment();
	        
	        p.setUser(user);
	        p.setTransactionId(req.getTransactionId() + "-" + fy); // Unique constraint fix
	        p.setAmount((i == totalYears - 1) ? lastYearAmount : perYearAmount);
	        p.setPaymentMode(req.getPaymentMode());
	        p.setStatus(req.getStatus());
	        p.setDescription(req.getDescription() + " (" + fy + ")");
	        p.setReason(req.getReason());
	        p.setPaymentDate(Date.valueOf(req.getPaymentDate()));
	        
	        // Calculate FY Dates (April 1st to March 31st)
	        int startYear = Integer.parseInt(fy.split("-")[0]);
	        // If "2024-25", startYear is 2024
	        p.setFeeFrom(Date.valueOf(LocalDate.of(startYear, 4, 1)));
	        p.setFeeTo(Date.valueOf(LocalDate.of(startYear + 1, 3, 31)));

	        p.setReceiptImagePath(imagePath);
	        p.setCrtBy(user.getId());
	        p.setCrtDt(Date.valueOf(LocalDate.now()));

	        paymentRepository.save(p);
	    }
	}
}
