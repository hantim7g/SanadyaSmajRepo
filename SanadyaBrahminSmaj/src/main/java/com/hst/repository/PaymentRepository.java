package com.hst.repository;

import com.hst.entity.Payment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

import com.hst.entity.User;


public interface PaymentRepository extends JpaRepository<Payment, Long> {
	Optional<Payment> findByTransactionId(String transactionId);
	List<Payment> findByStatus(String status);
    // 🔍 Find all payments for a user by their user ID
    List<Payment> findByUserId(Long userId);

    @Query("""
    	    SELECT p FROM Payment p
    	    WHERE p.user.id = :userId AND p.status = 'सफल' AND p.description LIKE 'वार्षिक%'
    	    ORDER BY p.paymentDate DESC
    	""")
    	List<Payment> findLastAnnualFeePaymentByUserId(@Param("userId") Long userId);
    
    @Query("""
    	    SELECT p FROM Payment p
    	    WHERE p.user.id = :userId AND p.status = 'सफल' AND p.description != 'वार्षिक शुल्क'
    	    ORDER BY p.paymentDate DESC
    	""")
    	List<Payment> findLastOtherFeePaymentByUserId(@Param("userId") Long userId);
    Payment findTopByUserIdAndDescriptionOrderByPaymentDateDesc(Long userId, String description);

    Payment findPaymentById(Long id); 
    
     List<Payment> findPaymentByTransactionIdAndUser(String transactionId, User user);
}
