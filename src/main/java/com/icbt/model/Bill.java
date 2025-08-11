package com.icbt.model;

import java.util.Date;
import java.util.List;

public class Bill {
    private int billId;
    private String accountNumber;
    private Date billDate;
    private Date dueDate;
    private double totalAmount;
    private String status;
    private List<BillItem> items;

    // Constructors
    public Bill() {}

    public Bill(String accountNumber, Date billDate, Date dueDate, double totalAmount, String status) {
        this.accountNumber = accountNumber;
        this.billDate = billDate;
        this.dueDate = dueDate;
        this.totalAmount = totalAmount;
        this.status = status;
    }

    // Getters and Setters
    public int getBillId() { return billId; }
    public void setBillId(int billId) { this.billId = billId; }

    public String getAccountNumber() { return accountNumber; }
    public void setAccountNumber(String accountNumber) { this.accountNumber = accountNumber; }

    public Date getBillDate() { return billDate; }
    public void setBillDate(Date billDate) { this.billDate = billDate; }

    public Date getDueDate() { return dueDate; }
    public void setDueDate(Date dueDate) { this.dueDate = dueDate; }

    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public List<BillItem> getItems() { return items; }
    public void setItems(List<BillItem> items) { this.items = items; }
}