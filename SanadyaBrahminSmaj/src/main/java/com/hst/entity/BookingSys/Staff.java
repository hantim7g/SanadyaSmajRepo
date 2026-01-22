package com.hst.entity.BookingSys;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;


@Entity
@Table(name = "staff")
public class Staff {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;
    private String role; // ADMIN, RECEPTION, HOUSEKEEPING
    private String phone;
    private Boolean active;

    private String username;
    private String password;
	public synchronized Long getId() {
		return id;
	}
	public synchronized void setId(Long id) {
		this.id = id;
	}
	public synchronized String getName() {
		return name;
	}
	public synchronized void setName(String name) {
		this.name = name;
	}
	public synchronized String getRole() {
		return role;
	}
	public synchronized void setRole(String role) {
		this.role = role;
	}
	public synchronized String getPhone() {
		return phone;
	}
	public synchronized void setPhone(String phone) {
		this.phone = phone;
	}
	public synchronized Boolean getActive() {
		return active;
	}
	public synchronized void setActive(Boolean active) {
		this.active = active;
	}
	public synchronized String getUsername() {
		return username;
	}
	public synchronized void setUsername(String username) {
		this.username = username;
	}
	public synchronized String getPassword() {
		return password;
	}
	public synchronized void setPassword(String password) {
		this.password = password;
	}
}
