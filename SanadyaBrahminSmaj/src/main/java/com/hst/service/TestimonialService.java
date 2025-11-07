package com.hst.service;

import com.hst.entity.Testimonial;
import com.hst.entity.User;
import com.hst.repository.TestimonialRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;

@Service
public class TestimonialService {

    @Autowired
    private TestimonialRepository testimonialRepository;

    
    public Page<Testimonial> findApprovedPaged(String q, Pageable pageable) {
        final String approved = "स्वीकृत"; // keep consistent with your DB values
        if (q == null || q.trim().isEmpty()) {
            // If you prefer to sort here: pageable already has Sort
            return testimonialRepository.findByStatusOrderByCreatedDateDesc(approved, pageable);
        }
        return testimonialRepository.searchApproved(approved, q.trim(), pageable);
    }

    // If you still need the old method:
    public List<Testimonial> getApprovedTestimonials() {
        // optionally keep for non-paged use
        return testimonialRepository.findByStatusOrderByCreatedDateDesc("स्वीकृत", Pageable.unpaged()).getContent();
    }
   
    public List<Testimonial> getPendingTestimonials() {
        return testimonialRepository.findByStatusOrderByCreatedDateDesc("प्रक्रिया में");
    }

    public List<Testimonial> getUserTestimonials(Long userId) {
        return testimonialRepository.findByUserId(userId);
    }

    public boolean canUserAddTestimonial(Long userId) {
        return testimonialRepository.countActiveTestimonialsByUserId(userId) == 0;
    }

    public Optional<Testimonial> findById(Long id) {
        return testimonialRepository.findById(id);
    }


    @Transactional
    public Testimonial updateTestimonial(Long testimonialId, String message, String designation, User updatedBy) {
        Optional<Testimonial> testimonialOpt = testimonialRepository.findById(testimonialId);
        if (testimonialOpt.isPresent()) {
            Testimonial testimonial = testimonialOpt.get();
            
            testimonial.setMessage(message);
            testimonial.setDesignation(designation);
            testimonial.setUpdatedDate(LocalDateTime.now());
            
            if ("स्वीकृत".equals(testimonial.getStatus()) && !"ADMIN".equals(updatedBy.getRole())) {
                testimonial.setStatus("प्रक्रिया में");
                testimonial.setApprovedDate(null);
                testimonial.setApprovedBy(null);
            }
            
            return testimonialRepository.save(testimonial);
        }
        return null;
    }

    public boolean canUserEditTestimonial(Long testimonialId, User user) {
        Optional<Testimonial> testimonialOpt = testimonialRepository.findById(testimonialId);
        if (testimonialOpt.isPresent()) {
            Testimonial testimonial = testimonialOpt.get();
            return testimonial.canBeEditedBy(user);
        }
        return false;
    }

    public List<Testimonial> getUserEditableTestimonials(Long userId) {
        return testimonialRepository.findByUserIdAndStatus(userId, "प्रक्रिया में");
    }

    @Transactional
    public void approveTestimonial(Long testimonialId, String approvedBy) {
        Optional<Testimonial> testimonialOpt = testimonialRepository.findById(testimonialId);
        if (testimonialOpt.isPresent()) {
            Testimonial testimonial = testimonialOpt.get();
            testimonial.setStatus("स्वीकृत");
            testimonial.setApprovedDate(LocalDateTime.now());
            testimonial.setApprovedBy(approvedBy);
            testimonialRepository.save(testimonial);
        }
    }

 

    @Transactional
    public void toggleActive(Long testimonialId) {
        Optional<Testimonial> testimonialOpt = testimonialRepository.findById(testimonialId);
        if (testimonialOpt.isPresent()) {
            Testimonial testimonial = testimonialOpt.get();
            testimonial.setActive(!testimonial.isActive());
            testimonialRepository.save(testimonial);
        }
    }

    @Transactional
    public void deleteTestimonial(Long testimonialId, User user) {
        Optional<Testimonial> testimonialOpt = testimonialRepository.findById(testimonialId);
        if (testimonialOpt.isPresent()) {
            Testimonial testimonial = testimonialOpt.get();
            if (testimonial.canBeEditedBy(user) && "प्रक्रिया में".equals(testimonial.getStatus())) {
                testimonialRepository.delete(testimonial);
            }
        }
    }
    @Transactional
    public Testimonial saveTestimonial(Testimonial testimonial) {
        testimonial.setStatus("प्रक्रिया में");   // ensure initial status
        return testimonialRepository.save(testimonial);
    }

    @Transactional
    public void rejectTestimonial(Long testimonialId, String rejectedBy) {
        testimonialRepository.findById(testimonialId).ifPresent(t -> {
            t.setStatus("अस्वीकृत");
            t.setApprovedDate(LocalDateTime.now());
            t.setApprovedBy(rejectedBy);
            t.setActive(false);                   // ← optional, but common
        });
    }

	public List<Testimonial> findApprovedActiveTestimonials() {
		return testimonialRepository.findApprovedActiveTestimonials();
	}

}
