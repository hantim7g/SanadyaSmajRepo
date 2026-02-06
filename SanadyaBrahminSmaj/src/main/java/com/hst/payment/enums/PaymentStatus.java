package com.hst.payment.enums;
public enum PaymentStatus {
    CREATED,        // Entry created in DB
    INITIATED,      // Order created at gateway
    SUCCESS,
    FAILED,
    CANCELLED,
    REFUNDED,
    PARTIALLY_REFUNDED
}
