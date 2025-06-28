package com.hst.entity;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "users")
public class User {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@Column(unique = true)
	private String RegistrationNo;
	private String fullName;
	private String fatherName;
	private String gotra;

	private LocalDate dateOfBirth;
	private String gender;
	private String address;


	private String approved = "प्रक्रिया में";

	@Column(unique = true, nullable = false)
	private String mobile;

	private String email;

	@Column(nullable = false)
	private String password;

	private String education;
	private String occupation;
	private String homeDistrict;
	private String aadharNumber;
	private String bloodGroup;
	private String maritalStatus;
	private String organizationAffiliation;
	@Column(length = 1000)
	private String contribution;
	private String profileImagePath;
	private boolean agreeToTerms;
	@Column(nullable = false)
	private String role = "USER";
	@Column(name = "annual_fee_due")
	private Integer annualFeeDue = 1; // default: due

	@Column(name = "last_annual_fee_paid")
	private LocalDate lastAnnualFeePaid;

	@Column(name = "last_annual_fee_amount")
	private Double lastAnnualFeeAmount;
	@Column(name = "annual_fee_validated")
	private String annualFeeValidated ="प्रक्रिया में"; 

	@Column(name = "other_fee_validated")
	private String otherFeeValidated ="NA"; 
	
	
	public Double getLastAnnualFeeAmount() {
		return lastAnnualFeeAmount;
	}

	public Integer getAnnualFeeDue() {
		return annualFeeDue;
	}

	public void setAnnualFeeDue(Integer annualFeeDue) {
		this.annualFeeDue = annualFeeDue;
	}

	public LocalDate getLastAnnualFeePaid() {
		return lastAnnualFeePaid;
	}

	public void setLastAnnualFeePaid(LocalDate lastAnnualFeePaid) {
		this.lastAnnualFeePaid = lastAnnualFeePaid;
	}

	public void setLastAnnualFeeAmount(Double lastAnnualFeeAmount) {
		this.lastAnnualFeeAmount = lastAnnualFeeAmount;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getRegistrationNo() {
		return RegistrationNo;
	}

	public void setRegistrationNo(String registrationNo) {
		RegistrationNo = registrationNo;
	}

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public String getFatherName() {
		return fatherName;
	}

	public void setFatherName(String fatherName) {
		this.fatherName = fatherName;
	}

	public String getGotra() {
		return gotra;
	}

	public void setGotra(String gotra) {
		this.gotra = gotra;
	}

	public LocalDate getDateOfBirth() {
		return dateOfBirth;
	}

	public void setDateOfBirth(LocalDate dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
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

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEducation() {
		return education;
	}

	public void setEducation(String education) {
		this.education = education;
	}

	public String getOccupation() {
		return occupation;
	}

	public void setOccupation(String occupation) {
		this.occupation = occupation;
	}

	public String getHomeDistrict() {
		return homeDistrict;
	}

	public void setHomeDistrict(String homeDistrict) {
		this.homeDistrict = homeDistrict;
	}

	public String getAadharNumber() {
		return aadharNumber;
	}

	public void setAadharNumber(String aadharNumber) {
		this.aadharNumber = aadharNumber;
	}

	public String getBloodGroup() {
		return bloodGroup;
	}

	public void setBloodGroup(String bloodGroup) {
		this.bloodGroup = bloodGroup;
	}

	public String getMaritalStatus() {
		return maritalStatus;
	}

	public void setMaritalStatus(String maritalStatus) {
		this.maritalStatus = maritalStatus;
	}

	public String getOrganizationAffiliation() {
		return organizationAffiliation;
	}

	public void setOrganizationAffiliation(String organizationAffiliation) {
		this.organizationAffiliation = organizationAffiliation;
	}

	public String getContribution() {
		return contribution;
	}

	public void setContribution(String contribution) {
		this.contribution = contribution;
	}

	public String getProfileImagePath() {
		return profileImagePath;
	}

	public void setProfileImagePath(String profileImagePath) {
		this.profileImagePath = profileImagePath;
	}

	public boolean isAgreeToTerms() {
		return agreeToTerms;
	}

	public void setAgreeToTerms(boolean agreeToTerms) {
		this.agreeToTerms = agreeToTerms;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	// Optional constructor
	public User() {
	}

	public String getAnnualFeeValidated() {
		return annualFeeValidated;
	}

	public void setAnnualFeeValidated(String annualFeeValidated) {
		this.annualFeeValidated = annualFeeValidated;
	}

	public String getOtherFeeValidated() {
		return otherFeeValidated;
	}

	public void setOtherFeeValidated(String otherFeeValidated) {
		this.otherFeeValidated = otherFeeValidated;
	}

	public String getApproved() {
		return approved;
	}

	public void setApproved(String approved) {
		this.approved = approved;
	}
}
