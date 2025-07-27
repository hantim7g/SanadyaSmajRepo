package com.hst.service;

import com.hst.entity.Testimonial;
import com.hst.entity.User;
import com.hst.repository.TestimonialRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Date;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class TestimonialService {

    @Autowired
    private TestimonialRepository testimonialRepository;

    public List<Testimonial> getApprovedTestimonials() {
        return testimonialRepository.findApprovedActiveTestimonials();
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

    @Transactional
    public Testimonial saveTestimonial(Testimonial testimonial) {
        return testimonialRepository.save(testimonial);
    }

    @Transactional
    public void approveTestimonial(Long testimonialId, String approvedBy) {
        Optional<Testimonial> testimonialOpt = testimonialRepository.findById(testimonialId);
        if (testimonialOpt.isPresent()) {
            Testimonial testimonial = testimonialOpt.get();
            testimonial.setStatus("स्वीकृत");
            testimonial.setApprovedDate(Date.valueOf(LocalDate.now()));
            testimonial.setApprovedBy(approvedBy);
            testimonialRepository.save(testimonial);
        }
    }

    @Transactional
    public void rejectTestimonial(Long testimonialId, String rejectedBy) {
        Optional<Testimonial> testimonialOpt = testimonialRepository.findById(testimonialId);
        if (testimonialOpt.isPresent()) {
            Testimonial testimonial = testimonialOpt.get();
            testimonial.setStatus("अस्वीकृत");
            testimonial.setApprovedDate(Date.valueOf(LocalDate.now()));
            testimonial.setApprovedBy(rejectedBy);
            testimonialRepository.save(testimonial);
        }
    }

    public Optional<Testimonial> findById(Long id) {
        return testimonialRepository.findById(id);
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
}
