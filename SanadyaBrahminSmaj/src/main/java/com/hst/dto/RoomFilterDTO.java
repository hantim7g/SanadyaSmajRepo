package com.hst.dto;

import java.math.BigDecimal;
import java.time.LocalDate;

import com.hst.entity.BookingSys.RoomStatus;

public class RoomFilterDTO {

    // ===== BASIC FILTERS =====
    private String roomType;     // ONLY_ROOM, HALL, COMPLETE_FLOOR
    private String floor;        // Ground, 1st, 2nd

    // ===== PRICE FILTER =====
    private BigDecimal minPrice;
    private BigDecimal maxPrice;

    // ===== DATE FILTER =====
    private LocalDate fromDate;
    private LocalDate toDate;

    // ===== SYSTEM FILTERS =====
    private Boolean isActive;
    private RoomStatus status;

    // ===== GETTERS & SETTERS =====

    public String getRoomType() {
        return roomType;
    }

    public void setRoomType(String roomType) {
        this.roomType = roomType;
    }

    public String getFloor() {
        return floor;
    }

    public void setFloor(String floor) {
        this.floor = floor;
    }

    public BigDecimal getMinPrice() {
        return minPrice;
    }

    public void setMinPrice(BigDecimal minPrice) {
        this.minPrice = minPrice;
    }

    public BigDecimal getMaxPrice() {
        return maxPrice;
    }

    public void setMaxPrice(BigDecimal maxPrice) {
        this.maxPrice = maxPrice;
    }

    public LocalDate getFromDate() {
        return fromDate;
    }

    public void setFromDate(LocalDate fromDate) {
        this.fromDate = fromDate;
    }

    public LocalDate getToDate() {
        return toDate;
    }

    public void setToDate(LocalDate toDate) {
        this.toDate = toDate;
    }

    public Boolean getIsActive() {
        return isActive;
    }

    public void setIsActive(Boolean isActive) {
        this.isActive = isActive;
    }

    public RoomStatus getStatus() {
        return status;
    }

    public void setStatus(RoomStatus status) {
        this.status = status;
    }
}
