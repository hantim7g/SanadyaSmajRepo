package com.hst.entity.BookingSys;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;

@Entity
@Table(name = "bookings")
public class Booking {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String bookingCode;

    @ManyToOne(optional = false)
    private Room room;

    /* ================= GUEST ================= */
    @NotBlank(message = "अतिथि का नाम अनिवार्य है")
    private String guestName;

    @NotBlank(message = "मोबाइल नंबर अनिवार्य है")
    @Pattern(regexp = "^(\\+91|0)?[6-9][0-9]{9}$",
    message = "मान्य मोबाइल नंबर दर्ज करें")
    private String phone;

    @Email(message = "मान्य ईमेल दर्ज करें")
    private String email;

   
    private String loginUserMobile;

    private Boolean isWalkIn = false;

    /* ================= DATES ================= */
    @NotNull(message = "चेक-इन तिथि अनिवार्य है")
    private LocalDate checkInDate;

    @NotNull(message = "चेक-आउट तिथि अनिवार्य है")
    private LocalDate checkOutDate;

    private LocalDateTime actualCheckIn;
    private LocalDateTime actualCheckOut;

    /* ================= GUEST COUNT ================= */

    private Integer adults;

    private Integer children;

    /* ================= STATUS ================= */
    @Enumerated(EnumType.STRING)
    private BookingStatus status;

    /* ================= PRICING ================= */
  
    private BigDecimal roomPrice;

    private BigDecimal discountAmount = BigDecimal.ZERO;
    private BigDecimal taxAmount = BigDecimal.ZERO;

 
    private BigDecimal totalAmount;

    private BigDecimal paidAmount = BigDecimal.ZERO;
    private BigDecimal balanceAmount;

    private Boolean payAtHotel = true;

    /* ================= ADDRESS ================= */
    @NotBlank(message = "पता अनिवार्य है")
    private String address;

    @NotBlank(message = "शहर अनिवार्य है")
    private String city;

    @NotBlank(message = "राज्य अनिवार्य है")
    private String state;

    @NotBlank(message = "पिन कोड अनिवार्य है")
    @Pattern(regexp = "^[0-9]{6}$", message = "मान्य पिन कोड दर्ज करें")
    private String pinCode;

    @NotBlank(message = "राष्ट्रीयता अनिवार्य है")
    private String nationality = "भारतीय";

    /* ================= EMERGENCY ================= */
    @NotBlank(message = "आपातकालीन संपर्क नाम अनिवार्य है")
    private String emergencyContactName;

    @NotBlank(message = "आपातकालीन मोबाइल अनिवार्य है")
    @Pattern(regexp = "^(\\+91|0)?[6-9][0-9]{9}$",
    message = "मान्य मोबाइल नंबर दर्ज करें")
    private String emergencyContactPhone;

    /* ================= ID PROOF ================= */
    @NotBlank(message = "ID प्रूफ प्रकार अनिवार्य है")
    private String idProofType;

    @NotBlank(message = "ID प्रूफ नंबर अनिवार्य है")
    private String idProofNumber;


    private String idProofFileUrl;

    /* ================= OTHER ================= */
    @Size(max = 500, message = "टिप्पणी 500 अक्षरों से अधिक नहीं हो सकती")
    private String remarks;

    private String bookingSource = "WEBSITE";
    
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    @PrePersist
    public void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
    }

    @PreUpdate
    public void onUpdate() {
        updatedAt = LocalDateTime.now();
    }

	public synchronized Long getId() {
		return id;
	}

	public synchronized void setId(Long id) {
		this.id = id;
	}

	public synchronized String getBookingCode() {
		return bookingCode;
	}

	public synchronized void setBookingCode(String bookingCode) {
		this.bookingCode = bookingCode;
	}

	public synchronized Room getRoom() {
		return room;
	}

	public synchronized void setRoom(Room room) {
		this.room = room;
	}

	public synchronized String getGuestName() {
		return guestName;
	}

	public synchronized void setGuestName(String guestName) {
		this.guestName = guestName;
	}

	public synchronized String getPhone() {
		return phone;
	}

	public synchronized void setPhone(String phone) {
		this.phone = phone;
	}

	public synchronized String getEmail() {
		return email;
	}

	public synchronized void setEmail(String email) {
		this.email = email;
	}

	public synchronized String getLoginUserMobile() {
		return loginUserMobile;
	}

	public synchronized void setLoginUserMobile(String loginUserMobile) {
		this.loginUserMobile = loginUserMobile;
	}

	public synchronized Boolean getIsWalkIn() {
		return isWalkIn;
	}

	public synchronized void setIsWalkIn(Boolean isWalkIn) {
		this.isWalkIn = isWalkIn;
	}

	public synchronized LocalDate getCheckInDate() {
		return checkInDate;
	}

	public synchronized void setCheckInDate(LocalDate checkInDate) {
		this.checkInDate = checkInDate;
	}

	public synchronized LocalDate getCheckOutDate() {
		return checkOutDate;
	}

	public synchronized void setCheckOutDate(LocalDate checkOutDate) {
		this.checkOutDate = checkOutDate;
	}

	public synchronized LocalDateTime getActualCheckIn() {
		return actualCheckIn;
	}

	public synchronized void setActualCheckIn(LocalDateTime actualCheckIn) {
		this.actualCheckIn = actualCheckIn;
	}

	public synchronized LocalDateTime getActualCheckOut() {
		return actualCheckOut;
	}

	public synchronized void setActualCheckOut(LocalDateTime actualCheckOut) {
		this.actualCheckOut = actualCheckOut;
	}

	public synchronized Integer getAdults() {
		return adults;
	}

	public synchronized void setAdults(Integer adults) {
		this.adults = adults;
	}

	public synchronized Integer getChildren() {
		return children;
	}

	public synchronized void setChildren(Integer children) {
		this.children = children;
	}

	public synchronized BookingStatus getStatus() {
		return status;
	}

	public synchronized void setStatus(BookingStatus status) {
		this.status = status;
	}

	public synchronized BigDecimal getRoomPrice() {
		return roomPrice;
	}

	public synchronized void setRoomPrice(BigDecimal roomPrice) {
		this.roomPrice = roomPrice;
	}

	public synchronized BigDecimal getDiscountAmount() {
		return discountAmount;
	}

	public synchronized void setDiscountAmount(BigDecimal discountAmount) {
		this.discountAmount = discountAmount;
	}

	public synchronized BigDecimal getTaxAmount() {
		return taxAmount;
	}

	public synchronized void setTaxAmount(BigDecimal taxAmount) {
		this.taxAmount = taxAmount;
	}

	public synchronized BigDecimal getTotalAmount() {
		return totalAmount;
	}

	public synchronized void setTotalAmount(BigDecimal totalAmount) {
		this.totalAmount = totalAmount;
	}

	public synchronized BigDecimal getPaidAmount() {
		return paidAmount;
	}

	public synchronized void setPaidAmount(BigDecimal paidAmount) {
		this.paidAmount = paidAmount;
	}

	public synchronized BigDecimal getBalanceAmount() {
		return balanceAmount;
	}

	public synchronized void setBalanceAmount(BigDecimal balanceAmount) {
		this.balanceAmount = balanceAmount;
	}

	public synchronized Boolean getPayAtHotel() {
		return payAtHotel;
	}

	public synchronized void setPayAtHotel(Boolean payAtHotel) {
		this.payAtHotel = payAtHotel;
	}

	public synchronized String getAddress() {
		return address;
	}

	public synchronized void setAddress(String address) {
		this.address = address;
	}

	public synchronized String getCity() {
		return city;
	}

	public synchronized void setCity(String city) {
		this.city = city;
	}

	public synchronized String getState() {
		return state;
	}

	public synchronized void setState(String state) {
		this.state = state;
	}

	public synchronized String getPinCode() {
		return pinCode;
	}

	public synchronized void setPinCode(String pinCode) {
		this.pinCode = pinCode;
	}

	public synchronized String getNationality() {
		return nationality;
	}

	public synchronized void setNationality(String nationality) {
		this.nationality = nationality;
	}

	public synchronized String getEmergencyContactName() {
		return emergencyContactName;
	}

	public synchronized void setEmergencyContactName(String emergencyContactName) {
		this.emergencyContactName = emergencyContactName;
	}

	public synchronized String getEmergencyContactPhone() {
		return emergencyContactPhone;
	}

	public synchronized void setEmergencyContactPhone(String emergencyContactPhone) {
		this.emergencyContactPhone = emergencyContactPhone;
	}

	public synchronized String getIdProofType() {
		return idProofType;
	}

	public synchronized void setIdProofType(String idProofType) {
		this.idProofType = idProofType;
	}

	public synchronized String getIdProofNumber() {
		return idProofNumber;
	}

	public synchronized void setIdProofNumber(String idProofNumber) {
		this.idProofNumber = idProofNumber;
	}

	public synchronized String getIdProofFileUrl() {
		return idProofFileUrl;
	}

	public synchronized void setIdProofFileUrl(String idProofFileUrl) {
		this.idProofFileUrl = idProofFileUrl;
	}

	public synchronized String getRemarks() {
		return remarks;
	}

	public synchronized void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public synchronized String getBookingSource() {
		return bookingSource;
	}

	public synchronized void setBookingSource(String bookingSource) {
		this.bookingSource = bookingSource;
	}

	public synchronized LocalDateTime getCreatedAt() {
		return createdAt;
	}

	public synchronized void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}

	public synchronized LocalDateTime getUpdatedAt() {
		return updatedAt;
	}

	public synchronized void setUpdatedAt(LocalDateTime updatedAt) {
		this.updatedAt = updatedAt;
	}

    /* ===== GETTERS / SETTERS ===== */
    // 👉 Generate via IDE (no custom logic needed)
}
