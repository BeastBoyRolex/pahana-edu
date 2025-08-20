-- Database Schema for Pahana Edu Bookshop Billing System
-- This file contains the SQL statements to create the necessary tables

-- Create Bill table
CREATE TABLE IF NOT EXISTS Bill (
    bill_id VARCHAR(50) PRIMARY KEY,
    account_number VARCHAR(50) NOT NULL,
    bill_date DATE NOT NULL,
    due_date DATE NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) DEFAULT 'PENDING',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create BillItem table
CREATE TABLE IF NOT EXISTS BillItem (
    bill_item_id VARCHAR(100) PRIMARY KEY,
    bill_id VARCHAR(50) NOT NULL,
    item_id VARCHAR(50) NOT NULL,
    description VARCHAR(255),
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (bill_id) REFERENCES Bill(bill_id) ON DELETE CASCADE
);

-- Create Customer table (if not exists)
CREATE TABLE IF NOT EXISTS Customer (
    account_number VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(20),
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Item table (if not exists)
CREATE TABLE IF NOT EXISTS items (
    item_id VARCHAR(50) PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(100),
    publisher VARCHAR(100),
    price DECIMAL(10,2) NOT NULL,
    quantity INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create User table (if not exists)
CREATE TABLE IF NOT EXISTS users (
    user_id VARCHAR(50) PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role VARCHAR(20) DEFAULT 'USER',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert sample data for testing

-- Sample customers
INSERT INTO Customer (account_number, name, email, phone, address) VALUES
('CUST001', 'John Doe', 'john.doe@email.com', '+94 71 1234567', '123 Main St, Colombo'),
('CUST002', 'Jane Smith', 'jane.smith@email.com', '+94 72 2345678', '456 Oak Ave, Kandy'),
('CUST003', 'Bob Johnson', 'bob.johnson@email.com', '+94 73 3456789', '789 Pine Rd, Galle');

-- Sample items
INSERT INTO items (item_id, title, author, publisher, price, quantity) VALUES
('ITEM001', 'Java Programming', 'James Gosling', 'Oracle Press', 1500.00, 50),
('ITEM002', 'Python for Beginners', 'Guido van Rossum', 'Python Foundation', 1200.00, 75),
('ITEM003', 'Web Development', 'Tim Berners-Lee', 'W3C Publishing', 1800.00, 30),
('ITEM004', 'Database Design', 'E.F. Codd', 'IBM Press', 2000.00, 25),
('ITEM005', 'Software Engineering', 'Fred Brooks', 'Addison-Wesley', 2500.00, 20);

-- Sample user
INSERT INTO users (user_id, username, password, role) VALUES
('USER001', 'admin', 'admin123', 'ADMIN');

-- Create indexes for better performance
CREATE INDEX idx_bill_account_number ON Bill(account_number);
CREATE INDEX idx_bill_date ON Bill(bill_date);
CREATE INDEX idx_bill_status ON Bill(status);
CREATE INDEX idx_billitem_bill_id ON BillItem(bill_id);
CREATE INDEX idx_billitem_item_id ON BillItem(item_id);
CREATE INDEX idx_customer_account ON Customer(account_number);
CREATE INDEX idx_items_title ON items(title);
