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
@Table(name = "bookings")
public class Booking {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String bookingCode; // HTL2026-0001

    @ManyToOne
    private Room room;

    // Primary guest
    private String guestName;
    private String phone;
    private String email;
    private String LoginUser;
    // Walk-in or online
    private Boolean isWalkIn;

    // Dates
    private LocalDate checkInDate;
    private LocalDate checkOutDate;
    private LocalDateTime actualCheckIn;
    private LocalDateTime actualCheckOut;

    private Integer adults;
    private Integer children;

    // Booking status
    @Enumerated(EnumType.STRING)
    private BookingStatus status;

    // Pricing
    private BigDecimal roomPrice;
    private BigDecimal discountAmount;
    private BigDecimal taxAmount;
    private BigDecimal totalAmount;

    // Payment
    private BigDecimal paidAmount;
    private BigDecimal balanceAmount;
    private Boolean payAtHotel;

    // GST / compliance
    private String gstNumber;
    private String idProofType;
    private String idProofNumber;
    private String idProofFileUrl;

    // Early / Late
    private Boolean earlyCheckIn;
    private Boolean lateCheckOut;

    // Cancellation
    private BigDecimal cancellationCharge;
    private Boolean isNoShow;

    // Source
    private String bookingSource; // WEBSITE, WALKIN, ADMIN

    // Audit
    private String createdBy; // admin/reception username
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getBookingCode() {
		return bookingCode;
	}
	public void setBookingCode(String bookingCode) {
		this.bookingCode = bookingCode;
	}
	public Room getRoom() {
		return room;
	}
	public void setRoom(Room room) {
		this.room = room;
	}
	public String getGuestName() {
		return guestName;
	}
	public void setGuestName(String guestName) {
		this.guestName = guestName;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public Boolean getIsWalkIn() {
		return isWalkIn;
	}
	public void setIsWalkIn(Boolean isWalkIn) {
		this.isWalkIn = isWalkIn;
	}
	public LocalDate getCheckInDate() {
		return checkInDate;
	}
	public void setCheckInDate(LocalDate checkInDate) {
		this.checkInDate = checkInDate;
	}
	public LocalDate getCheckOutDate() {
		return checkOutDate;
	}
	public void setCheckOutDate(LocalDate checkOutDate) {
		this.checkOutDate = checkOutDate;
	}
	public LocalDateTime getActualCheckIn() {
		return actualCheckIn;
	}
	public void setActualCheckIn(LocalDateTime actualCheckIn) {
		this.actualCheckIn = actualCheckIn;
	}
	public LocalDateTime getActualCheckOut() {
		return actualCheckOut;
	}
	public void setActualCheckOut(LocalDateTime actualCheckOut) {
		this.actualCheckOut = actualCheckOut;
	}
	public Integer getAdults() {
		return adults;
	}
	public void setAdults(Integer adults) {
		this.adults = adults;
	}
	public Integer getChildren() {
		return children;
	}
	public void setChildren(Integer children) {
		this.children = children;
	}
	public BookingStatus getStatus() {
		return status;
	}
	public void setStatus(BookingStatus status) {
		this.status = status;
	}
	public BigDecimal getRoomPrice() {
		return roomPrice;
	}
	public void setRoomPrice(BigDecimal roomPrice) {
		this.roomPrice = roomPrice;
	}
	public BigDecimal getDiscountAmount() {
		return discountAmount;
	}
	public void setDiscountAmount(BigDecimal discountAmount) {
		this.discountAmount = discountAmount;
	}
	public BigDecimal getTaxAmount() {
		return taxAmount;
	}
	public void setTaxAmount(BigDecimal taxAmount) {
		this.taxAmount = taxAmount;
	}
	public BigDecimal getTotalAmount() {
		return totalAmount;
	}
	public void setTotalAmount(BigDecimal totalAmount) {
		this.totalAmount = totalAmount;
	}
	public BigDecimal getPaidAmount() {
		return paidAmount;
	}
	public void setPaidAmount(BigDecimal paidAmount) {
		this.paidAmount = paidAmount;
	}
	public BigDecimal getBalanceAmount() {
		return balanceAmount;
	}
	public void setBalanceAmount(BigDecimal balanceAmount) {
		this.balanceAmount = balanceAmount;
	}
	public Boolean getPayAtHotel() {
		return payAtHotel;
	}
	public void setPayAtHotel(Boolean payAtHotel) {
		this.payAtHotel = payAtHotel;
	}
	public String getGstNumber() {
		return gstNumber;
	}
	public void setGstNumber(String gstNumber) {
		this.gstNumber = gstNumber;
	}
	public String getIdProofType() {
		return idProofType;
	}
	public void setIdProofType(String idProofType) {
		this.idProofType = idProofType;
	}
	public String getIdProofNumber() {
		return idProofNumber;
	}
	public void setIdProofNumber(String idProofNumber) {
		this.idProofNumber = idProofNumber;
	}
	public String getIdProofFileUrl() {
		return idProofFileUrl;
	}
	public void setIdProofFileUrl(String idProofFileUrl) {
		this.idProofFileUrl = idProofFileUrl;
	}
	public Boolean getEarlyCheckIn() {
		return earlyCheckIn;
	}
	public void setEarlyCheckIn(Boolean earlyCheckIn) {
		this.earlyCheckIn = earlyCheckIn;
	}
	public Boolean getLateCheckOut() {
		return lateCheckOut;
	}
	public void setLateCheckOut(Boolean lateCheckOut) {
		this.lateCheckOut = lateCheckOut;
	}
	public BigDecimal getCancellationCharge() {
		return cancellationCharge;
	}
	public void setCancellationCharge(BigDecimal cancellationCharge) {
		this.cancellationCharge = cancellationCharge;
	}
	public Boolean getIsNoShow() {
		return isNoShow;
	}
	public void setIsNoShow(Boolean isNoShow) {
		this.isNoShow = isNoShow;
	}
	public String getBookingSource() {
		return bookingSource;
	}
	public void setBookingSource(String bookingSource) {
		this.bookingSource = bookingSource;
	}
	public String getCreatedBy() {
		return createdBy;
	}
	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}
	public LocalDateTime getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}
	public LocalDateTime getUpdatedAt() {
		return updatedAt;
	}
	public void setUpdatedAt(LocalDateTime updatedAt) {
		this.updatedAt = updatedAt;
	}
}
