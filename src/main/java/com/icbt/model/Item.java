package com.icbt.model;

public class Item {
    private int itemId;
    private String itemCode;
    private String title;
    private String author;
    private String publisher;
    private String category;
    private double price;
    private int quantity;
    private String description;

    // Constructors, getters and setters
    public Item() {}

    public Item(String itemCode, String title, String author, String publisher,
                String category, double price, int quantity, String description) {
        this.itemCode = itemCode;
        this.title = title;
        this.author = author;
        this.publisher = publisher;
        this.category = category;
        this.price = price;
        this.quantity = quantity;
        this.description = description;
    }

    // Getters and Setters for all properties
    public int getItemId() { return itemId; }
    public void setItemId(int itemId) { this.itemId = itemId; }

    public String getItemCode() { return itemCode; }
    public void setItemCode(String itemCode) { this.itemCode = itemCode; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getAuthor() { return author; }
    public void setAuthor(String author) { this.author = author; }

    public String getPublisher() { return publisher; }
    public void setPublisher(String publisher) { this.publisher = publisher; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
}
