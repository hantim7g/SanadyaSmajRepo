package com.hst.dto;

import org.springframework.web.multipart.MultipartFile;

import java.time.LocalDate;

public class User {
    private String RegistrationNo;
    public String getRegistrationNo() {
		return RegistrationNo;
	}
	public void setRegistrationNo(String registrationNo) {
		RegistrationNo = registrationNo;
	}

	private String fullName;
    private String fatherName;
    private String gotra;
    private LocalDate dateOfBirth;
    private String gender;
    private String address;
    private String mobile;
    private String email;
    private String password;
    private String education;
    private String occupation;
    private String homeDistrict;
    private String aadharNumber;
    private String bloodGroup;
    private String maritalStatus;
    private String organizationAffiliation;
    private String contribution;
    private MultipartFile profileImage;
    private boolean agreeToTerms;
    private boolean approved = false;
    // ----- Getters and Setters -----

    public boolean isApproved() {
		return approved;
	}
	public void setApproved(boolean approved) {
		this.approved = approved;
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

    public MultipartFile getProfileImage() {
        return profileImage;
    }
    public void setProfileImage(MultipartFile profileImage) {
        this.profileImage = profileImage;
    }

    public boolean isAgreeToTerms() {
        return agreeToTerms;
    }
    public void setAgreeToTerms(boolean agreeToTerms) {
        this.agreeToTerms = agreeToTerms;
    }

    // ----- Optional: Default Constructor -----
    public User() {}
}
