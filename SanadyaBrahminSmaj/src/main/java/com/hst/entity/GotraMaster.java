package com.hst.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "gotra_master")
public class GotraMaster {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String gotraName;
    private String samaj = "Sanadya Brahmin";
    private boolean active = true;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getGotraName() {
		return gotraName;
	}
	public void setGotraName(String gotraName) {
		this.gotraName = gotraName;
	}
	public String getSamaj() {
		return samaj;
	}
	public void setSamaj(String samaj) {
		this.samaj = samaj;
	}
	public boolean isActive() {
		return active;
	}
	public void setActive(boolean active) {
		this.active = active;
	}

    // getters setters
}

