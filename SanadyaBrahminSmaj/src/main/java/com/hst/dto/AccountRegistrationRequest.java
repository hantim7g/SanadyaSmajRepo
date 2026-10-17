package com.hst.dto;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;

public class AccountRegistrationRequest {

    @NotBlank(message = "पूरा नाम आवश्यक है।")
    private String fullName;

    @NotBlank(message = "मोबाइल नंबर आवश्यक है।")
    @Pattern(regexp = "^[0-9]{10}$", message = "कृपया एक वैध 10 अंकों का मोबाइल नंबर दर्ज करें।")
    private String mobile;

    @Email(message = "कृपया एक वैध ईमेल पता दर्ज करें।")
    private String email;

    @NotBlank(message = "पासवर्ड आवश्यक है।")
    @Size(min = 6, message = "पासवर्ड कम से कम 6 वर्णों का होना चाहिए।")
    private String password;

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
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
        this.email = email == null || email.isBlank() ? null : email.trim();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}