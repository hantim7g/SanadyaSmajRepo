package com.hst.repository;

import com.hst.entity.Payment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface PaymentRepository extends JpaRepository<Payment, Long> {

    // 🔍 Find all payments for a user by their user ID
    List<Payment> findByUserId(Long userId);

    @Query("""
    	    SELECT p FROM Payment p
    	    WHERE p.user.id = :userId AND p.status = 'Success' AND p.paymentMode = 'Annual Fee'
    	    ORDER BY p.paymentDate DESC
    	    LIMIT 1
    	""")
    	Payment findLastAnnualFeePaymentByUserId(@Param("userId") Long userId);
    Payment findTopByUserIdAndDescriptionOrderByPaymentDateDesc(Long userId, String description);

}
