package com.icbt.model;

public class BillItem {
    private int itemId;
    private int billId;
    private String description;
    private int quantity;
    private double unitPrice;
    private double amount;

    // Constructors
    public BillItem() {}

    public BillItem(int billId, String description, int quantity, double unitPrice, double amount) {
        this.billId = billId;
        this.description = description;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
        this.amount = amount;
    }

    // Getters and Setters
    public int getItemId() { return itemId; }
    public void setItemId(int itemId) { this.itemId = itemId; }

    public int getBillId() { return billId; }
    public void setBillId(int billId) { this.billId = billId; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public double getUnitPrice() { return unitPrice; }
    public void setUnitPrice(double unitPrice) { this.unitPrice = unitPrice; }

    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }
}