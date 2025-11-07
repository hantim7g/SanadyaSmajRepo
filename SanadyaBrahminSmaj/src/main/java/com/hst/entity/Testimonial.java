package com.hst.entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Entity
@Table(name = "testimonials")
public class Testimonial {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(length = 1000, nullable = false)
    private String message;

    @Column(length = 100)
    private String designation;

    private String status = "प्रक्रिया में"; // "प्रक्रिया में", "स्वीकृत", "अस्वीकृत"

    private LocalDateTime createdDate;
    private LocalDateTime updatedDate;
    private LocalDateTime approvedDate;
    private String approvedBy;

    private boolean isActive = true;
    private int displayOrder = 0;

    // Constructors
    public Testimonial() {
        this.createdDate = LocalDateTime.now();
    }

    // Helper methods for formatted dates
    @Transient
    public String getFormattedCreatedDate() {
        if (createdDate != null) {
            return createdDate.format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm"));
        }
        return "";
    }

    @Transient
    public String getFormattedUpdatedDate() {
        if (updatedDate != null) {
            return updatedDate.format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm"));
        }
        return "";
    }

    @Transient
    public String getFormattedApprovedDate() {
        if (approvedDate != null) {
            return approvedDate.format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm"));
        }
        return "";
    }

    @Transient
    public boolean canBeEditedBy(User currentUser) {
        if (currentUser.getRole().equals("ADMIN")) {
            return true;
        }
        return this.user.getId().equals(currentUser.getId()) && 
               "प्रक्रिया में".equals(this.status);
    }

    // Getters and Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }

    public String getDesignation() { return designation; }
    public void setDesignation(String designation) { this.designation = designation; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public LocalDateTime getCreatedDate() { return createdDate; }
    public void setCreatedDate(LocalDateTime createdDate) { this.createdDate = createdDate; }

    public LocalDateTime getUpdatedDate() { return updatedDate; }
    public void setUpdatedDate(LocalDateTime updatedDate) { this.updatedDate = updatedDate; }

    public LocalDateTime getApprovedDate() { return approvedDate; }
    public void setApprovedDate(LocalDateTime approvedDate) { this.approvedDate = approvedDate; }

    public String getApprovedBy() { return approvedBy; }
    public void setApprovedBy(String approvedBy) { this.approvedBy = approvedBy; }

    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }

    public int getDisplayOrder() { return displayOrder; }
    public void setDisplayOrder(int displayOrder) { this.displayOrder = displayOrder; }
}
