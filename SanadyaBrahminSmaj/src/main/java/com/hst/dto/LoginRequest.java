package com.hst.dto;

public class LoginRequest {
    private String mobile;
    private String email;
    private String identifier;
    private String password;

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
	public String getIdentifier() {
		return identifier;
	}
	public void setIdentifier(String identifier) {
		this.identifier = identifier;
	}

	/**
	 * Returns the login identifier: prefers the explicit {@code identifier}
	 * field, then {@code mobile}, then {@code email}.
	 */
	public String resolveIdentifier() {
		if (identifier != null && !identifier.isBlank()) {
			return identifier.trim();
		}
		if (mobile != null && !mobile.isBlank()) {
			return mobile.trim();
		}
		if (email != null && !email.isBlank()) {
			return email.trim();
		}
		return null;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
}
