package com.hst.repository;

import com.hst.entity.Payment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

import com.hst.entity.LoginUser;


public interface PaymentRepository extends JpaRepository<Payment, Long> {
	Optional<Payment> findByTransactionId(String transactionId);
	List<Payment> findByStatus(String status);
    List<Payment> findByLoginUserId(Long loginUserId);

    @Query("""
            SELECT p FROM Payment p
            WHERE p.loginUser.id = :loginUserId AND p.status = 'सफल' AND p.description LIKE 'वार्षिक%'
            ORDER BY p.paymentDate DESC
        """)
    List<Payment> findLastAnnualFeePaymentByLoginUserId(@Param("loginUserId") Long loginUserId);
    
    @Query("""
            SELECT p FROM Payment p
            WHERE p.loginUser.id = :loginUserId AND p.status = 'सफल' AND p.description != 'वार्षिक शुल्क'
            ORDER BY p.paymentDate DESC
        """)
    List<Payment> findLastOtherFeePaymentByLoginUserId(@Param("loginUserId") Long loginUserId);
    Payment findTopByLoginUserIdAndDescriptionOrderByPaymentDateDesc(Long loginUserId, String description);

    Payment findPaymentById(Long id); 
    
     List<Payment> findPaymentByTransactionIdAndLoginUser(String transactionId, LoginUser loginUser);
}
