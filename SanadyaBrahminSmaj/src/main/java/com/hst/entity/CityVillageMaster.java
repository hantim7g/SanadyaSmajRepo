package com.hst.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "city_village_master")
public class CityVillageMaster {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name;

    private String district;

    private String state = "राजस्थान";

    @Column(name = "is_city")
    private boolean city = true;

    private boolean active = true;

    // Constructors
    public CityVillageMaster() {}

    public CityVillageMaster(String name, String district, boolean city) {
        this.name = name;
        this.district = district;
        this.city = city;
    }

    // Getters & Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDistrict() { return district; }
    public void setDistrict(String district) { this.district = district; }

    public String getState() { return state; }
    public void setState(String state) { this.state = state; }

    public boolean isCity() { return city; }
    public void setCity(boolean city) { this.city = city; }

    public boolean isActive() { return active; }
    public void setActive(boolean active) { this.active = active; }
}
