package com.hst.entity;

import jakarta.persistence.*;

@Entity
public class RegistrationSequence {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "last_number")
    private Long lastNumber;

    // Constructors
    public RegistrationSequence() {}

    public RegistrationSequence(Long lastNumber) {
        this.lastNumber = lastNumber;
    }

    public Long getId() {
        return id;
    }

    public Long getLastNumber() {
        return lastNumber;
    }

    public void setLastNumber(Long lastNumber) {
        this.lastNumber = lastNumber;
    }
}
