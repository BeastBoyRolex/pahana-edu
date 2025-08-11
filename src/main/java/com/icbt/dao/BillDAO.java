package com.icbt.dao;

import com.icbt.model.Bill;
import com.icbt.model.BillItem;
import com.icbt.util.DBConnection;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BillDAO {
    private static final String INSERT_BILL = "INSERT INTO Bill (account_number, bill_date, due_date, total_amount, status) VALUES (?, ?, ?, ?, ?)";
    private static final String INSERT_BILL_ITEMS = "INSERT INTO BillItem (bill_id, description, quantity, unit_price, amount) VALUES (?, ?, ?, ?, ?)";
    private static final String GET_BILL_BY_ID = "SELECT * FROM Bill WHERE bill_id = ?";
    private static final String GET_BILL_ITEMS = "SELECT * FROM BillItem WHERE bill_id = ?";
    private static final String GET_BILLS_BY_ACCOUNT = "SELECT * FROM Bill WHERE account_number = ? ORDER BY bill_date DESC";
    private static final String UPDATE_BILL_STATUS = "UPDATE Bill SET status = ? WHERE bill_id = ?";

    public boolean createBill(Bill bill) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(INSERT_BILL, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, bill.getAccountNumber());
            stmt.setDate(2, new java.sql.Date(bill.getBillDate().getTime()));
            stmt.setDate(3, new java.sql.Date(bill.getDueDate().getTime()));
            stmt.setDouble(4, bill.getTotalAmount());
            stmt.setString(5, bill.getStatus());

            if (stmt.executeUpdate() > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        int billId = generatedKeys.getInt(1);
                        bill.setBillId(billId);

                        if (bill.getItems() != null && !bill.getItems().isEmpty()) {
                            insertBillItems(billId, bill.getItems());
                        }
                        return true;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private void insertBillItems(int billId, List<BillItem> items) throws SQLException {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(INSERT_BILL_ITEMS)) {

            for (BillItem item : items) {
                stmt.setInt(1, billId);
                stmt.setString(2, item.getDescription());
                stmt.setInt(3, item.getQuantity());
                stmt.setDouble(4, item.getUnitPrice());
                stmt.setDouble(5, item.getAmount());
                stmt.addBatch();
            }
            stmt.executeBatch();
        }
    }

    public Bill getBillById(int billId) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(GET_BILL_BY_ID)) {

            stmt.setInt(1, billId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Bill bill = extractBillFromResultSet(rs);
                    bill.setItems(getBillItems(billId));
                    return bill;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private List<BillItem> getBillItems(int billId) throws SQLException {
        List<BillItem> items = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(GET_BILL_ITEMS)) {

            stmt.setInt(1, billId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    items.add(extractBillItemFromResultSet(rs));
                }
            }
        }
        return items;
    }

    public List<Bill> getBillsByAccountNumber(String accountNumber) {
        List<Bill> bills = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(GET_BILLS_BY_ACCOUNT)) {

            stmt.setString(1, accountNumber);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    bills.add(extractBillFromResultSet(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bills;
    }

    public boolean updateBillStatus(int billId, String status) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(UPDATE_BILL_STATUS)) {

            stmt.setString(1, status);
            stmt.setInt(2, billId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private Bill extractBillFromResultSet(ResultSet rs) throws SQLException {
        Bill bill = new Bill();
        bill.setBillId(rs.getInt("bill_id"));
        bill.setAccountNumber(rs.getString("account_number"));
        bill.setBillDate(rs.getDate("bill_date"));
        bill.setDueDate(rs.getDate("due_date"));
        bill.setTotalAmount(rs.getDouble("total_amount"));
        bill.setStatus(rs.getString("status"));
        return bill;
    }

    private BillItem extractBillItemFromResultSet(ResultSet rs) throws SQLException {
        BillItem item = new BillItem();
        item.setItemId(rs.getInt("item_id"));
        item.setBillId(rs.getInt("bill_id"));
        item.setDescription(rs.getString("description"));
        item.setQuantity(rs.getInt("quantity"));
        item.setUnitPrice(rs.getDouble("unit_price"));
        item.setAmount(rs.getDouble("amount"));
        return item;
    }
}