package com.hst.entity;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "festivals")
public class Festival {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private LocalDate festivalDate;

    @Column(nullable = false)
    private String festivalName;

    @Column(columnDefinition = "TEXT")
    private String description;

    private boolean active = true;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public LocalDate getFestivalDate() { return festivalDate; }
    public void setFestivalDate(LocalDate festivalDate) { this.festivalDate = festivalDate; }

    public String getFestivalName() { return festivalName; }
    public void setFestivalName(String festivalName) { this.festivalName = festivalName; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public boolean isActive() { return active; }
    public void setActive(boolean active) { this.active = active; }
}
