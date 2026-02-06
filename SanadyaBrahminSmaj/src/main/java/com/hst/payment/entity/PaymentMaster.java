package com.hst.payment.entity;

import com.hst.payment.enums.PaymentProcessType;
import com.hst.payment.enums.PaymentStatus;
import com.hst.payment.enums.PaymentVendor;
import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import java.math.BigDecimal;
import java.time.LocalDateTime;



@Entity
@Table(name = "payment_master")
public class PaymentMaster {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long paymentId;

    // ===== PROCESS =====
    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private PaymentProcessType processType;

    @Column(nullable = false)
    private Long processReferenceId;

    private String processReferenceNo;

    // ===== AMOUNT =====
    @NotNull
    private BigDecimal amount;

    private String currency = "INR";

    // ===== STATUS =====
    @Enumerated(EnumType.STRING)
    private PaymentStatus paymentStatus;
 
    @Enumerated(EnumType.STRING)
    private PaymentVendor paymentVendor;

    // ===== GATEWAY =====
    private String gatewayOrderId;
    private String gatewayPaymentId;
    private String gatewaySignature;

    // ===== TIMESTAMPS =====
    private LocalDateTime paymentCreatedDate;
    private LocalDateTime paymentDoneDate;
    private LocalDateTime lastPaymentUpdate;

    // ===== AUDIT =====
    private Long createdBy;
    private LocalDateTime createdDate;
    private Long updatedBy;
    private LocalDateTime updatedDate;

    // ===== EXTRA =====
    private String remarks;

    @Column(columnDefinition = "json")
    private String gatewayResponse;

	public synchronized Long getPaymentId() {
		return paymentId;
	}

	public synchronized void setPaymentId(Long paymentId) {
		this.paymentId = paymentId;
	}

	public synchronized PaymentProcessType getProcessType() {
		return processType;
	}

	public synchronized void setProcessType(PaymentProcessType processType) {
		this.processType = processType;
	}

	public synchronized Long getProcessReferenceId() {
		return processReferenceId;
	}

	public synchronized void setProcessReferenceId(Long processReferenceId) {
		this.processReferenceId = processReferenceId;
	}

	public synchronized String getProcessReferenceNo() {
		return processReferenceNo;
	}

	public synchronized void setProcessReferenceNo(String processReferenceNo) {
		this.processReferenceNo = processReferenceNo;
	}

	public synchronized BigDecimal getAmount() {
		return amount;
	}

	public synchronized void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	public synchronized String getCurrency() {
		return currency;
	}

	public synchronized void setCurrency(String currency) {
		this.currency = currency;
	}

	public synchronized PaymentStatus getPaymentStatus() {
		return paymentStatus;
	}

	public synchronized void setPaymentStatus(PaymentStatus paymentStatus) {
		this.paymentStatus = paymentStatus;
	}

	public synchronized PaymentVendor getPaymentVendor() {
		return paymentVendor;
	}

	public synchronized void setPaymentVendor(PaymentVendor paymentVendor) {
		this.paymentVendor = paymentVendor;
	}

	public synchronized String getGatewayOrderId() {
		return gatewayOrderId;
	}

	public synchronized void setGatewayOrderId(String gatewayOrderId) {
		this.gatewayOrderId = gatewayOrderId;
	}

	public synchronized String getGatewayPaymentId() {
		return gatewayPaymentId;
	}

	public synchronized void setGatewayPaymentId(String gatewayPaymentId) {
		this.gatewayPaymentId = gatewayPaymentId;
	}

	public synchronized String getGatewaySignature() {
		return gatewaySignature;
	}

	public synchronized void setGatewaySignature(String gatewaySignature) {
		this.gatewaySignature = gatewaySignature;
	}

	public synchronized LocalDateTime getPaymentCreatedDate() {
		return paymentCreatedDate;
	}

	public synchronized void setPaymentCreatedDate(LocalDateTime paymentCreatedDate) {
		this.paymentCreatedDate = paymentCreatedDate;
	}

	public synchronized LocalDateTime getPaymentDoneDate() {
		return paymentDoneDate;
	}

	public synchronized void setPaymentDoneDate(LocalDateTime paymentDoneDate) {
		this.paymentDoneDate = paymentDoneDate;
	}

	public synchronized LocalDateTime getLastPaymentUpdate() {
		return lastPaymentUpdate;
	}

	public synchronized void setLastPaymentUpdate(LocalDateTime lastPaymentUpdate) {
		this.lastPaymentUpdate = lastPaymentUpdate;
	}

	public synchronized Long getCreatedBy() {
		return createdBy;
	}

	public synchronized void setCreatedBy(Long createdBy) {
		this.createdBy = createdBy;
	}

	public synchronized LocalDateTime getCreatedDate() {
		return createdDate;
	}

	public synchronized void setCreatedDate(LocalDateTime createdDate) {
		this.createdDate = createdDate;
	}

	public synchronized Long getUpdatedBy() {
		return updatedBy;
	}

	public synchronized void setUpdatedBy(Long updatedBy) {
		this.updatedBy = updatedBy;
	}

	public synchronized LocalDateTime getUpdatedDate() {
		return updatedDate;
	}

	public synchronized void setUpdatedDate(LocalDateTime updatedDate) {
		this.updatedDate = updatedDate;
	}

	public synchronized String getRemarks() {
		return remarks;
	}

	public synchronized void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public synchronized String getGatewayResponse() {
		return gatewayResponse;
	}

	public synchronized void setGatewayResponse(String gatewayResponse) {
		this.gatewayResponse = gatewayResponse;
	}
}
