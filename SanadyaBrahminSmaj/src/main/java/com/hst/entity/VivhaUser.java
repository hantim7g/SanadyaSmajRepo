package com.hst.entity;
import java.time.LocalDate;
import java.time.Period;


import jakarta.persistence.*;
@Entity
@Table(name = "vivha_user")
public class VivhaUser {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String loginMobile;

    
    @Transient
    private boolean contactVisible;

  

    public boolean isContactVisible() {
        return contactVisible;
    }
    public void setContactVisible(boolean contactVisible) {
        this.contactVisible = contactVisible;
    }

    // Personal
    private String name;
    private String gender;
    @Column(name = "dob")
    private LocalDate dob;

    private String birthTime;
    private String mobile;
    private String email;

    // Physical / Marital
    private String height;
    private String weight;
    private String maritalStatus;

    // Education / Job
    private String qualification;
    private String occupation;
    private String income;

    // Astrology
    private String gotra;
    private String rashi;
    private String manglik;

    // Family
    private String fatherName;
    private String fatherOccupation;
    private String motherName;
    private String permanentAddress;

    // Expectations
    private String expectedEducation;
    private String expectedIncome;

    @Column(length = 2000)
    private String expectations;

    // Admin
    private boolean approved = false;
    private boolean active = true;
    private boolean featured = false;

    private String profileImagePath;
    private String customGotra;

    // ===== Mother =====
    private String motherCustomGotra;

    // ===== Dadi (Father's Mother) =====
    private String dadiCustomGotra;

    // ===== Nani (Mother's Mother) =====
    private String naniCustomGotra;
 // Address
    private String houseAddress;     // मकान / गली
    private String city;             // शहर / कस्बा
    private String district;         // जिला
    private String state;            // राज्य
    private String pincode;          // पिन कोड

 // माता

 private String motherGotra;

 // दादी (पिता की माता)
 private String dadiName;
 private String dadiGotra;

 // नानी (माता की माता)
 private String naniName;
 private String naniGotra;


	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getLoginMobile() {
		return loginMobile;
	}

	public void setLoginMobile(String loginMobile) {
		this.loginMobile = loginMobile;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	
	public String getBirthTime() {
		return birthTime;
	}

	public void setBirthTime(String birthTime) {
		this.birthTime = birthTime;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getHeight() {
		return height;
	}

	public void setHeight(String height) {
		this.height = height;
	}

	public String getWeight() {
		return weight;
	}

	public void setWeight(String weight) {
		this.weight = weight;
	}

	public String getMaritalStatus() {
		return maritalStatus;
	}

	public void setMaritalStatus(String maritalStatus) {
		this.maritalStatus = maritalStatus;
	}

	public String getQualification() {
		return qualification;
	}

	public void setQualification(String qualification) {
		this.qualification = qualification;
	}

	public String getOccupation() {
		return occupation;
	}

	public void setOccupation(String occupation) {
		this.occupation = occupation;
	}

	public String getIncome() {
		return income;
	}

	public void setIncome(String income) {
		this.income = income;
	}

	public String getGotra() {
		return gotra;
	}

	public void setGotra(String gotra) {
		this.gotra = gotra;
	}

	public String getRashi() {
		return rashi;
	}

	public void setRashi(String rashi) {
		this.rashi = rashi;
	}

	public String getManglik() {
		return manglik;
	}

	public void setManglik(String manglik) {
		this.manglik = manglik;
	}

	public String getFatherName() {
		return fatherName;
	}

	public void setFatherName(String fatherName) {
		this.fatherName = fatherName;
	}

	public String getFatherOccupation() {
		return fatherOccupation;
	}

	public void setFatherOccupation(String fatherOccupation) {
		this.fatherOccupation = fatherOccupation;
	}

	public String getMotherName() {
		return motherName;
	}

	public void setMotherName(String motherName) {
		this.motherName = motherName;
	}

	public String getPermanentAddress() {
		return permanentAddress;
	}

	public void setPermanentAddress(String permanentAddress) {
		this.permanentAddress = permanentAddress;
	}

	public String getExpectedEducation() {
		return expectedEducation;
	}

	public void setExpectedEducation(String expectedEducation) {
		this.expectedEducation = expectedEducation;
	}

	public String getExpectedIncome() {
		return expectedIncome;
	}

	public void setExpectedIncome(String expectedIncome) {
		this.expectedIncome = expectedIncome;
	}

	public String getExpectations() {
		return expectations;
	}

	public void setExpectations(String expectations) {
		this.expectations = expectations;
	}

	public boolean isApproved() {
		return approved;
	}

	public void setApproved(boolean approved) {
		this.approved = approved;
	}

	public boolean isActive() {
		return active;
	}

	public void setActive(boolean active) {
		this.active = active;
	}

	public boolean isFeatured() {
		return featured;
	}

	public void setFeatured(boolean featured) {
		this.featured = featured;
	}

	public String getProfileImagePath() {
		return profileImagePath;
	}

	public void setProfileImagePath(String profileImagePath) {
		this.profileImagePath = profileImagePath;
	}

	public String getMotherGotra() {
		return motherGotra;
	}

	public void setMotherGotra(String motherGotra) {
		this.motherGotra = motherGotra;
	}

	public String getDadiName() {
		return dadiName;
	}

	public void setDadiName(String dadiName) {
		this.dadiName = dadiName;
	}

	public String getDadiGotra() {
		return dadiGotra;
	}

	public void setDadiGotra(String dadiGotra) {
		this.dadiGotra = dadiGotra;
	}

	public String getNaniName() {
		return naniName;
	}

	public void setNaniName(String naniName) {
		this.naniName = naniName;
	}

	public String getNaniGotra() {
		return naniGotra;
	}

	public void setNaniGotra(String naniGotra) {
		this.naniGotra = naniGotra;
	}

	public String getCustomGotra() {
		return customGotra;
	}

	public void setCustomGotra(String customGotra) {
		this.customGotra = customGotra;
	}

	public String getMotherCustomGotra() {
		return motherCustomGotra;
	}

	public void setMotherCustomGotra(String motherCustomGotra) {
		this.motherCustomGotra = motherCustomGotra;
	}

	public String getDadiCustomGotra() {
		return dadiCustomGotra;
	}

	public void setDadiCustomGotra(String dadiCustomGotra) {
		this.dadiCustomGotra = dadiCustomGotra;
	}

	public String getNaniCustomGotra() {
		return naniCustomGotra;
	}

	public void setNaniCustomGotra(String naniCustomGotra) {
		this.naniCustomGotra = naniCustomGotra;
	}

	public String getHouseAddress() {
		return houseAddress;
	}

	public void setHouseAddress(String houseAddress) {
		this.houseAddress = houseAddress;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getDistrict() {
		return district;
	}

	public void setDistrict(String district) {
		this.district = district;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getPincode() {
		return pincode;
	}

	public void setPincode(String pincode) {
		this.pincode = pincode;
	}

	@Transient
	public Integer getAge() {
	    if (dob == null) return null;
	    return Period.between(dob, LocalDate.now()).getYears();
	}
	public LocalDate getDob() {
		return dob;
	}
	public void setDob(LocalDate dob) {
		this.dob = dob;
	}

}

