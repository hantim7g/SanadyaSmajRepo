package com.hst.service;

import com.hst.dto.PaymentRequest;
import com.hst.entity.LoginUser;
import com.hst.entity.Payment;
import com.hst.repository.LoginUserRepository;
import com.hst.repository.PaymentRepository;

import jakarta.transaction.Transactional;

import org.springframework.stereotype.Service;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;

@Service
public class PaymentService {

    private final PaymentRepository paymentRepository;
    private final LoginUserRepository loginUserRepository;

    public PaymentService(PaymentRepository paymentRepository, LoginUserRepository loginUserRepository) {
        this.paymentRepository = paymentRepository;
        this.loginUserRepository = loginUserRepository;
    }

    // Get all payments made by the login account (by mobile number)
    public List<Payment> getPaymentsByMobile(String mobile) {
        LoginUser loginUser = loginUserRepository.findByMobile(mobile)
                .orElseThrow(() -> new RuntimeException("Login user not found with mobile: " + mobile));
        return getPaymentsByLoginUserId(loginUser.getId());
    }

    // 💾 Save a payment (for future use e.g., online payment integration)
    public Payment savePayment(Payment payment) {
        return paymentRepository.save(payment);
    }

    public List<Payment> getPaymentsByLoginUserId(Long loginUserId) {
        return paymentRepository.findByLoginUserId(loginUserId);
    }

    public Payment addPayment(Payment payment) {
        return paymentRepository.save(payment);
    }


	public Payment findPaymentById(Long Id) {
		return paymentRepository.findPaymentById(Id);
	}
	
	@Transactional
	public void saveAnnualMultiYearPayment(PaymentRequest req, LoginUser loginUser, String imagePath) {
	    List<String> years = req.getFinancialYears();
	    int totalYears = years.size();
	    
	    // Calculate split amount
	    double totalAmount = req.getAmount();
	    double perYearAmount = Math.floor((totalAmount / totalYears) * 100) / 100.0;
	    double lastYearAmount = totalAmount - (perYearAmount * (totalYears - 1));

	    for (int i = 0; i < totalYears; i++) {
	        String fy = years.get(i);
	        Payment p = new Payment();
	        
	        p.setLoginUser(loginUser);
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
	        p.setCrtBy(loginUser.getId());
	        p.setCrtDt(Date.valueOf(LocalDate.now()));

	        paymentRepository.save(p);
	    }
	}
}
