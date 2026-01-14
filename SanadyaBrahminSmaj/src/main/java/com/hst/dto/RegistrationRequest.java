package com.hst.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Past;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import java.time.LocalDate;

public class RegistrationRequest {

    @NotBlank(message = "मोबाइल नंबर आवश्यक है।")
    @Pattern(regexp = "^[0-9]{10}$", message = "कृपया एक वैध 10 अंकों का मोबाइल नंबर दर्ज करें।")
    private String mobile;

    @NotBlank(message = "पासवर्ड आवश्यक है।")
    @Size(min = 6, message = "पासवर्ड कम से कम 6 वर्णों का होना चाहिए।")
    private String password;

    @NotBlank(message = "पूरा नाम आवश्यक है।")
    private String fullName;

    @NotBlank(message = "पिता का नाम आवश्यक है।")
    private String fatherName;

    @NotBlank(message = "गोत्र आवश्यक है।")
    private String gotra;

    @NotNull(message = "जन्म तिथि आवश्यक है।")
    @Past(message = "जन्म तिथि भविष्य की तारीख नहीं हो सकती।")
    private LocalDate dateOfBirth;

    @NotBlank(message = "लिंग आवश्यक है।")
    private String gender;

    @NotBlank(message = "पता आवश्यक है।")
    private String address;

    @Email(message = "कृपया एक वैध ईमेल पता दर्ज करें।")
    @NotBlank(message = "ईमेल आवश्यक है।")
    private String email;

    @NotBlank(message = "शिक्षा आवश्यक है।")
    private String education;

    @NotBlank(message = "व्यवसाय आवश्यक है।")
    private String occupation;

    @NotBlank(message = "गृह जिला आवश्यक है।")
    private String homeDistrict;

    @Pattern(regexp = "^[0-9]{12}$", message = "कृपया एक वैध 12 अंकों का आधार नंबर दर्ज करें।")
    private String aadharNumber;

    @NotBlank(message = "रक्त समूह आवश्यक है।")
    private String bloodGroup;

    @NotBlank(message = "वैवाहिक स्थिति आवश्यक है।")
    private String maritalStatus;

    private String organizationAffiliation;
    private String contribution;

    @NotNull(message = "नियम और शर्तें स्वीकार करना आवश्यक है।")
    private boolean agreeToTerms;

    // Getters and Setters
    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
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

    public boolean isAgreeToTerms() {
        return agreeToTerms;
    }

    public void setAgreeToTerms(boolean agreeToTerms) {
        this.agreeToTerms = agreeToTerms;
    }
}
