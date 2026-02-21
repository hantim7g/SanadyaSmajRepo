package com.hst.dto;

import java.util.List;

public class PaymentRequest {

	private String transactionId;
	private double amount;
	private String paymentMode;
	private String status;
	private String description;
	private String paymentDate;
	private String feeFrom;
	private String feeTo;
	private String reason;

	private List<String> financialYears;

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

	public String getPaymentDate() {
		return paymentDate;
	}

	public void setPaymentDate(String paymentDate) {
		this.paymentDate = paymentDate;
	}

	public String getFeeFrom() {
		return feeFrom;
	}

	public void setFeeFrom(String feeFrom) {
		this.feeFrom = feeFrom;
	}

	public String getFeeTo() {
		return feeTo;
	}

	public void setFeeTo(String feeTo) {
		this.feeTo = feeTo;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public List<String> getFinancialYears() {
		return financialYears;
	}

	public void setFinancialYears(List<String> financialYears) {
		this.financialYears = financialYears;
	}
}