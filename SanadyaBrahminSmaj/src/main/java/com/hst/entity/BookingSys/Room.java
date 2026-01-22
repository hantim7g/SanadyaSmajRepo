package com.hst.entity.BookingSys;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;

@Entity
@Table(name = "rooms")
public class Room {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // ========== RELATIONS ==========
    @OneToMany(mappedBy = "room", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<RoomImage> images = new ArrayList<>();

    // ========== BASIC INFO ==========
    @NotBlank(message = "कमरे का नंबर अनिवार्य है")
    @Size(max = 20, message = "कमरे का नंबर बहुत लंबा है")
    private String roomNumber;          // 101, A-1

    @NotBlank(message = "कमरे का प्रकार चुनना अनिवार्य है")
    private String roomType;            // Single, Double, Deluxe, Suite

    @NotBlank(message = "फ्लोर की जानकारी अनिवार्य है")
    private String floor;               // 1st, 2nd

    // ========== CAPACITY ==========
    @NotNull(message = "अधिकतम वयस्क संख्या अनिवार्य है")
    @Min(value = 1, message = "कम से कम 1 वयस्क होना चाहिए")
    @Max(value = 20, message = "अधिकतम 20 वयस्क अनुमत हैं")
    private Integer maxAdults;

    @NotNull(message = "अधिकतम बच्चों की संख्या अनिवार्य है")
    @Min(value = 0, message = "बच्चों की संख्या नकारात्मक नहीं हो सकती")
    @Max(value = 10, message = "अधिकतम 10 बच्चे अनुमत हैं")
    private Integer maxChildren;

    // ========== PRICING ==========
    @NotNull(message = "आधार मूल्य अनिवार्य है")
    @DecimalMin(value = "0.0", inclusive = false, message = "मूल्य शून्य से अधिक होना चाहिए")
    @Digits(integer = 10, fraction = 2, message = "मूल्य का प्रारूप गलत है")
    private BigDecimal basePrice;       // default price

    @NotNull
    private Boolean isActive = true;    // blocked or not

    // ========== STATUS ==========
    @NotNull(message = "कमरे की स्थिति चुनना अनिवार्य है")
    @Enumerated(EnumType.STRING)
    private RoomStatus status;          // AVAILABLE, BOOKED, CLEANING, MAINTENANCE

    // ========== FEATURES ==========
    @NotNull
    private Boolean gardenView = false;

    @NotNull
    private Boolean hallRoom = false;

    // ========== AVAILABILITY RULES ==========
    @NotNull(message = "न्यूनतम प्रवास अवधि अनिवार्य है")
    @Min(value = 1, message = "न्यूनतम प्रवास 1 दिन होना चाहिए")
    @Max(value = 365, message = "न्यूनतम प्रवास 365 दिन से अधिक नहीं हो सकता")
    private Integer minStay;

    @NotNull(message = "अधिकतम प्रवास अवधि अनिवार्य है")
    @Min(value = 1, message = "अधिकतम प्रवास 1 दिन होना चाहिए")
    @Max(value = 365, message = "अधिकतम प्रवास 365 दिन से अधिक नहीं हो सकता")
    private Integer maxStay;

    @NotNull(message = "अग्रिम बुकिंग दिन अनिवार्य हैं")
    @Min(value = 0, message = "अग्रिम दिन नकारात्मक नहीं हो सकते")
    @Max(value = 365, message = "अग्रिम दिन 365 से अधिक नहीं हो सकते")
    private Integer advanceBookingDays;

    // ========== SEASONAL CONTROL ==========
    @NotNull(message = "उपलब्धता प्रारंभ तिथि अनिवार्य है")
    private LocalDate availableFrom;

    @NotNull(message = "उपलब्धता समाप्ति तिथि अनिवार्य है")
    private LocalDate availableTo;

    // ========== HOUSEKEEPING ==========
    @NotNull
    private Boolean housekeepingRequired = true;

    private LocalDateTime lastCleanedAt;

    // ========== AUDIT ==========
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    // ========== LIFECYCLE ==========
    @PrePersist
    public void onCreate() {
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }

    @PreUpdate
    public void onUpdate() {
        this.updatedAt = LocalDateTime.now();
    }

    // getters & setters remain same

	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getRoomNumber() {
		return roomNumber;
	}
	public void setRoomNumber(String roomNumber) {
		this.roomNumber = roomNumber;
	}
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
	public Integer getMaxAdults() {
		return maxAdults;
	}
	public void setMaxAdults(Integer maxAdults) {
		this.maxAdults = maxAdults;
	}
	public Integer getMaxChildren() {
		return maxChildren;
	}
	public void setMaxChildren(Integer maxChildren) {
		this.maxChildren = maxChildren;
	}
	public BigDecimal getBasePrice() {
		return basePrice;
	}
	public void setBasePrice(BigDecimal basePrice) {
		this.basePrice = basePrice;
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
	public Boolean getGardenView() {
		return gardenView;
	}
	public void setGardenView(Boolean gardenView) {
		this.gardenView = gardenView;
	}
	public Boolean getHallRoom() {
		return hallRoom;
	}
	public void setHallRoom(Boolean hallRoom) {
		this.hallRoom = hallRoom;
	}
	public Integer getMinStay() {
		return minStay;
	}
	public void setMinStay(Integer minStay) {
		this.minStay = minStay;
	}
	public Integer getMaxStay() {
		return maxStay;
	}
	public void setMaxStay(Integer maxStay) {
		this.maxStay = maxStay;
	}
	public Integer getAdvanceBookingDays() {
		return advanceBookingDays;
	}
	public void setAdvanceBookingDays(Integer advanceBookingDays) {
		this.advanceBookingDays = advanceBookingDays;
	}
	public LocalDate getAvailableFrom() {
		return availableFrom;
	}
	public void setAvailableFrom(LocalDate availableFrom) {
		this.availableFrom = availableFrom;
	}
	public LocalDate getAvailableTo() {
		return availableTo;
	}
	public void setAvailableTo(LocalDate availableTo) {
		this.availableTo = availableTo;
	}
	public Boolean getHousekeepingRequired() {
		return housekeepingRequired;
	}
	public void setHousekeepingRequired(Boolean housekeepingRequired) {
		this.housekeepingRequired = housekeepingRequired;
	}
	public LocalDateTime getLastCleanedAt() {
		return lastCleanedAt;
	}
	public void setLastCleanedAt(LocalDateTime lastCleanedAt) {
		this.lastCleanedAt = lastCleanedAt;
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
	public List<RoomImage> getImages() {
	    return images;
	}

	public void setImages(List<RoomImage> images) {
	    this.images = images;
	}
	

}
