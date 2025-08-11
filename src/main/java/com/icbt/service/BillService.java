package com.icbt.service;

import com.icbt.dao.BillDAO;
import com.icbt.model.Bill;
import com.icbt.model.BillItem;
import com.icbt.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;
import java.util.List;

public class BillService {
    private BillDAO billDAO;

    public BillService() {
        this.billDAO = new BillDAO();
    }

    public Bill generateBill(String accountNumber, List<BillItem> items, Date billDate, Date dueDate) {
        try {
            if (accountNumber == null || accountNumber.isEmpty()) {
                throw new IllegalArgumentException("Account number cannot be empty");
            }
            if (items == null || items.isEmpty()) {
                throw new IllegalArgumentException("Bill items cannot be empty");
            }
            if (billDate == null || dueDate == null) {
                throw new IllegalArgumentException("Dates cannot be null");
            }
            if (billDate.after(dueDate)) {
                throw new IllegalArgumentException("Due date must be after bill date");
            }

            double totalAmount = calculateTotalAmount(items);
            Bill bill = new Bill(accountNumber, billDate, dueDate, totalAmount, "PENDING");
            bill.setItems(items);

            return saveBill(bill);
        } catch (Exception e) {
            throw new RuntimeException("Error generating bill: " + e.getMessage(), e);
        }
    }

    public Bill saveBill(Bill bill) {
        Connection connection = null;
        try {
            connection = DBConnection.getConnection();
            connection.setAutoCommit(false); // Start transaction

            // Save bill
            String billSql = "INSERT INTO bills (account_number, bill_date, due_date, total_amount, payment_status) " +
                    "VALUES (?, ?, ?, ?, ?)";

            PreparedStatement billStmt = connection.prepareStatement(billSql, Statement.RETURN_GENERATED_KEYS);
            billStmt.setString(1, bill.getAccountNumber());
            billStmt.setDate(2, new java.sql.Date(bill.getBillDate().getTime()));
            billStmt.setDate(3, new java.sql.Date(bill.getDueDate().getTime()));
            billStmt.setDouble(4, bill.getTotalAmount());
            billStmt.executeUpdate();

            // Get generated bill ID
            ResultSet rs = billStmt.getGeneratedKeys();
            int billId = 0;
            if (rs.next()) {
                billId = rs.getInt(1);
                bill.setBillId(billId);
            }

            // Save items
            String itemSql = "INSERT INTO bill_items (bill_id, description, quantity, unit_price, amount) " +
                    "VALUES (?, ?, ?, ?, ?)";

            PreparedStatement itemStmt = connection.prepareStatement(itemSql);
            for (BillItem item : bill.getItems()) {
                itemStmt.setInt(1, billId);
                itemStmt.setString(2, item.getDescription());
                itemStmt.setInt(3, item.getQuantity());
                itemStmt.setDouble(4, item.getUnitPrice());
                itemStmt.setDouble(5, item.getAmount());
                itemStmt.addBatch();
            }
            itemStmt.executeBatch();

            connection.commit(); // Commit transaction
            return bill;

        } catch (SQLException e) {
            if (connection != null) {
                try {
                    connection.rollback();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            throw new RuntimeException("Failed to save bill", e);
        } finally {
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    private double calculateTotalAmount(List<BillItem> items) {
        double total = 0;
        for  (BillItem item : items) {
            total += item.getAmount();
        }
        return total;
    }

    public Bill getBill(int billId) {
        try {
            if (billId <= 0) {
                throw new IllegalArgumentException("Invalid bill ID");
            }
            Bill bill = billDAO.getBillById(billId);
            if (bill == null) {
                throw new RuntimeException("Bill not found with ID: " + billId);
            }
            return bill;
        } catch (Exception e) {
            throw new RuntimeException("Error retrieving bill: " + e.getMessage(), e);
        }
    }

    public List<Bill> getCustomerBills(String accountNumber) {
        try {
            if (accountNumber == null || accountNumber.isEmpty()) {
                throw new IllegalArgumentException("Account number cannot be empty");
            }
            List<Bill> bills = billDAO.getBillsByAccountNumber(accountNumber);
            if (bills == null) {
                throw new RuntimeException("No bills found for account: " + accountNumber);
            }
            return bills;
        } catch (Exception e) {
            throw new RuntimeException("Error retrieving customer bills: " + e.getMessage(), e);
        }
    }

    public void updateBillStatus(int billId, String status) {
        try {
            if (billId <= 0) {
                throw new IllegalArgumentException("Invalid bill ID");
            }
            if (status == null || status.isEmpty()) {
                throw new IllegalArgumentException("Status cannot be empty");
            }
            if (!billDAO.updateBillStatus(billId, status)) {
                throw new RuntimeException("Failed to update bill status");
            }
        } catch (Exception e) {
            throw new RuntimeException("Error updating bill status: " + e.getMessage(), e);
        }
    }

    public void markBillAsPaid(int billId) {
        try {
            if (billId <= 0) {
                throw new IllegalArgumentException("Invalid bill ID");
            }
            if (!billDAO.updateBillStatus(billId, "PAID")) {
                throw new RuntimeException("Failed to mark bill as paid");
            }
        } catch (Exception e) {
            throw new RuntimeException("Error marking bill as paid: " + e.getMessage(), e);
        }
    }
}