package com.hst.entity;

import jakarta.persistence.*;

import java.sql.Date;
import java.time.LocalDateTime;

@Entity
@Table(name = "payment_history")
public class Payment {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	// 🔗 Foreign key to User
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "user_id", nullable = false)
	private User user;

	@Column(nullable = false, unique = true)
	private String transactionId;

	@Column(nullable = false)
	private double amount;

	@Column(nullable = false)
	private Date paymentDate;

	@Column(nullable = false)
	private String paymentMode; // e.g., UPI, Card, Cash

	@Column(nullable = false)
	private String status; // e.g., Success, Failed, Pending

	private Date feeFrom;
	private Date feeTo;
	private String description;
	private  String validated="प्रक्रिया में";

	@Column(name = "receipt_image_path")
	private String receiptImagePath;

	private Date crtDt;
	private Long crtBy;
	private Date lstUpDt;
	private Long lstUpBy;
	
	private String reason;
	
	
	public String getReceiptImagePath() {
		return receiptImagePath;
	}

	public void setReceiptImagePath(String receiptImagePath) {
		this.receiptImagePath = receiptImagePath;
	}

	public String getValidated() {
		return validated;
	}

	public void setValidated(String validated) {
		this.validated = validated;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getTransactionId() {
		return transactionId;
	}

	public void setTransactionId(String transactionId) {
		this.transactionId = transactionId;
	}

	public double getAmount() {
		return amount;
	}

	public void setAmount(double amount) {
		this.amount = amount;
	}

	public Date getPaymentDate() {
		return paymentDate;
	}

	public void setPaymentDate(Date paymentDate) {
		this.paymentDate = paymentDate;
	}

	public String getPaymentMode() {
		return paymentMode;
	}

	public void setPaymentMode(String paymentMode) {
		this.paymentMode = paymentMode;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public Date getCrtDt() {
		return crtDt;
	}

	public void setCrtDt(Date crtDt) {
		this.crtDt = crtDt;
	}

	public Long getCrtBy() {
		return crtBy;
	}

	public void setCrtBy(Long crtBy) {
		this.crtBy = crtBy;
	}

	public Date getLstUpDt() {
		return lstUpDt;
	}

	public void setLstUpDt(Date lstUpDt) {
		this.lstUpDt = lstUpDt;
	}

	public Long getLstUpBy() {
		return lstUpBy;
	}

	public void setLstUpBy(Long lstUpBy) {
		this.lstUpBy = lstUpBy;
	}

	public Date getFeeFrom() {
		return feeFrom;
	}

	public void setFeeFrom(Date feeFrom) {
		this.feeFrom = feeFrom;
	}

	public Date getFeeTo() {
		return feeTo;
	}

	public void setFeeTo(Date feeTo) {
		this.feeTo = feeTo;
	}


}
