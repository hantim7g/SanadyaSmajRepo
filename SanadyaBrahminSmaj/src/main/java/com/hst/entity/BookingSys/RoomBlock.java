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
@Table(name = "room_blocks")
public class RoomBlock {

	
	
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    private Room room;

    private LocalDate fromDate;
    private LocalDate toDate;
    private String reason; // MAINTENANCE, VIP
	public synchronized Long getId() {
		return id;
	}
	public synchronized void setId(Long id) {
		this.id = id;
	}
	public synchronized Room getRoom() {
		return room;
	}
	public synchronized void setRoom(Room room) {
		this.room = room;
	}
	public synchronized LocalDate getFromDate() {
		return fromDate;
	}
	public synchronized void setFromDate(LocalDate fromDate) {
		this.fromDate = fromDate;
	}
	public synchronized LocalDate getToDate() {
		return toDate;
	}
	public synchronized void setToDate(LocalDate toDate) {
		this.toDate = toDate;
	}
	public synchronized String getReason() {
		return reason;
	}
	public synchronized void setReason(String reason) {
		this.reason = reason;
	}
}
