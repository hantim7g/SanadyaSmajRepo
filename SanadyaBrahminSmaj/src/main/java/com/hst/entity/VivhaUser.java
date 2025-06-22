package com.hst.entity;


import jakarta.persistence.*;

@Entity
public class VivhaUser {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;
    private String gender;
    private String dob;
    private String birthTime;
    private String loginMobile;
    public String getLoginMobile() {
		return loginMobile;
	}
	public void setLoginMobile(String loginMobile) {
		this.loginMobile = loginMobile;
	}
	private String mobile;
    private String email;
    private String qualification;
    private String occupation;
    private String income;
    private String fatherName;
    private String fatherOccupation;
    private String fatherIncome;
    private String permanentAddress;
    private String gotra;

    private String profileImagePath;

    // --- Getters and Setters ---
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public String getDob() { return dob; }
    public void setDob(String dob) { this.dob = dob; }

    public String getBirthTime() { return birthTime; }
    public void setBirthTime(String birthTime) { this.birthTime = birthTime; }

    public String getMobile() { return mobile; }
    public void setMobile(String mobile) { this.mobile = mobile; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getQualification() { return qualification; }
    public void setQualification(String qualification) { this.qualification = qualification; }

    public String getOccupation() { return occupation; }
    public void setOccupation(String occupation) { this.occupation = occupation; }

    public String getIncome() { return income; }
    public void setIncome(String income) { this.income = income; }

    public String getFatherName() { return fatherName; }
    public void setFatherName(String fatherName) { this.fatherName = fatherName; }

    public String getFatherOccupation() { return fatherOccupation; }
    public void setFatherOccupation(String fatherOccupation) { this.fatherOccupation = fatherOccupation; }

    public String getFatherIncome() { return fatherIncome; }
    public void setFatherIncome(String fatherIncome) { this.fatherIncome = fatherIncome; }

    public String getPermanentAddress() { return permanentAddress; }
    public void setPermanentAddress(String permanentAddress) { this.permanentAddress = permanentAddress; }

    public String getGotra() { return gotra; }
    public void setGotra(String gotra) { this.gotra = gotra; }

    public String getProfileImagePath() { return profileImagePath; }
    public void setProfileImagePath(String profileImagePath) { this.profileImagePath = profileImagePath; }
}
