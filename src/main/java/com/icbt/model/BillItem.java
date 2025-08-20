package com.icbt.model;

public class BillItem {
    private String billItemId;
    private String billId;
    private String itemId;
    private String description;
    private int quantity;
    private double unitPrice;
    private double amount;
    
    // Constructors
    public BillItem() {}

    public BillItem(String billItemId, String billId, String itemId, String description, int quantity, double unitPrice, double amount) {
        this.billItemId = billItemId;
        this.billId = billId;
        this.itemId = itemId;
        this.description = description;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
        this.amount = amount;
    }

    // Getters and Setters
    public String getBillItemId() { return billItemId; }
    public void setBillItemId(String billItemId) { this.billItemId = billItemId; }

    public String getBillId() { return billId; }
    public void setBillId(String billId) { this.billId = billId; }

    public String getItemId() { return itemId; }
    public void setItemId(String itemId) { this.itemId = itemId; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public double getUnitPrice() { return unitPrice; }
    public void setUnitPrice(double unitPrice) { this.unitPrice = unitPrice; }

    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }
}