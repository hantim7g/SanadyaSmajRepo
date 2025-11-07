package com.hst.repository;

import com.hst.entity.Testimonial;

import org.springframework.data.domain.Page;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;

import java.util.List;

public interface TestimonialRepository extends JpaRepository<Testimonial, Long> {
    
    @Query("SELECT t FROM Testimonial t WHERE t.status = 'स्वीकृत' ORDER BY t.displayOrder ASC, t.approvedDate DESC")
    List<Testimonial> findApprovedActiveTestimonials();
 // Approved only
    Page<Testimonial> findByStatusOrderByCreatedDateDesc(String status, Pageable pageable);

    // Approved + simple search on name/designation/message
    @Query("""
      SELECT t FROM Testimonial t
      WHERE t.status = :status
        AND (
             LOWER(t.user.fullName) LIKE LOWER(CONCAT('%', :q, '%'))
          OR LOWER(COALESCE(t.designation, '')) LIKE LOWER(CONCAT('%', :q, '%'))
          OR LOWER(t.message) LIKE LOWER(CONCAT('%', :q, '%'))
        )
      """)
    Page<Testimonial> searchApproved(@Param("status") String status,
                                     @Param("q") String q,
                                     Pageable pageable);
    List<Testimonial> findByStatusOrderByCreatedDateDesc(String status);
    
    @Query("SELECT t FROM Testimonial t WHERE t.user.id = :userId ORDER BY t.createdDate DESC")
    List<Testimonial> findByUserId(@Param("userId") Long userId);
    
    @Query("SELECT COUNT(t) FROM Testimonial t WHERE t.user.id = :userId AND t.status IN ('प्रक्रिया में', 'स्वीकृत')")
    long countActiveTestimonialsByUserId(@Param("userId") Long userId);

    @Query("SELECT t FROM Testimonial t WHERE t.user.id = :userId AND t.status = :status ORDER BY t.createdDate DESC")
    List<Testimonial> findByUserIdAndStatus(@Param("userId") Long userId, @Param("status") String status);
}
