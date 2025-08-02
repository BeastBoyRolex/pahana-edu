package com.icbt.model;

import java.util.Date;

public class Bill {
    private int billId;
    private String accountNumber;
    private Date billingDate;
    private int unitsConsumed;
    private double amount;
    private String paymentStatus;

    public Bill() {
    }

    public Bill(String accountNumber, Date billingDate,
                int unitsConsumed, double amount, String paymentStatus) {
        this.accountNumber = accountNumber;
        this.billingDate = billingDate;
        this.unitsConsumed = unitsConsumed;
        this.amount = amount;
        this.paymentStatus = paymentStatus;
    }

    // Getter and Setter methods
    public int getBillId() {
        return billId;
    }

    public void setBillId(int billId) {
        this.billId = billId;
    }

    public String getAccountNumber() {
        return accountNumber;
    }

    public void setAccountNumber(String accountNumber) {
        this.accountNumber = accountNumber;
    }

    public Date getBillingDate() {
        return billingDate;
    }

    public void setBillingDate(Date billingDate) {
        this.billingDate = billingDate;
    }

    public int getUnitsConsumed() {
        return unitsConsumed;
    }

    public void setUnitsConsumed(int unitsConsumed) {
        this.unitsConsumed = unitsConsumed;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }
}
