package com.hst.dto;

public class UserRoleUpdateRequest {
    private Long userId;
    private String role;
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}

    // getters & setters
}
