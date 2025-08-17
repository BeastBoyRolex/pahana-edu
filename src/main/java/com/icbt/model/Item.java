package com.icbt.model;

public class Item {
    private int itemId;
    private String title;
    private String author;
    private String publisher;
    private double price;
    private int quantity;

    // Constructors, getters and setters
    public Item() {}

    public Item(int itemId, String title, String author, String publisher, String category, double price, int quantity) {
        this.itemId = itemId;
        this.title = title;
        this.author = author;
        this.publisher = publisher;
        this.price = price;
        this.quantity = quantity;
    }

    // Getters and Setters for all properties
    public int getItemId() { return itemId; }
    public void setItemId(int itemId) { this.itemId = itemId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getAuthor() { return author; }
    public void setAuthor(String author) { this.author = author; }

    public String getPublisher() { return publisher; }
    public void setPublisher(String publisher) { this.publisher = publisher; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

}
