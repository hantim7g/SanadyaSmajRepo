package com.hst.repository;

import com.hst.entity.Testimonial;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface TestimonialRepository extends JpaRepository<Testimonial, Long> {
    
    // Find approved and active testimonials for display
    @Query("SELECT t FROM Testimonial t WHERE t.status = 'स्वीकृत' AND t.isActive = true ORDER BY t.displayOrder ASC, t.approvedDate DESC")
    List<Testimonial> findApprovedActiveTestimonials();
    
    // Find testimonials by status for admin
    List<Testimonial> findByStatusOrderByCreatedDateDesc(String status);
    
    // Find user's testimonials
    @Query("SELECT t FROM Testimonial t WHERE t.user.id = :userId ORDER BY t.createdDate DESC")
    List<Testimonial> findByUserId(@Param("userId") Long userId);
    
    // Check if user already has a pending/approved testimonial
    @Query("SELECT COUNT(t) FROM Testimonial t WHERE t.user.id = :userId AND t.status IN ('प्रक्रिया में', 'स्वीकृत')")
    long countActiveTestimonialsByUserId(@Param("userId") Long userId);
}
