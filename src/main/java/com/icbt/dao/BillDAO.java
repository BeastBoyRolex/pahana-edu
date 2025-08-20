package com.icbt.dao;

import com.icbt.model.Bill;
import com.icbt.model.BillItem;
import com.icbt.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BillDAO {
    private static final String INSERT_BILL = "INSERT INTO Bill (account_number, bill_date, due_date, total_amount, status) VALUES (?, ?, ?, ?, ?)";
    private static final String INSERT_BILL_ITEMS = "INSERT INTO BillItem (bill_id, item_id, description, quantity, unit_price, amount) VALUES ( ?, ?, ?, ?, ?, ?)";
    private static final String GET_BILL_BY_ID = "SELECT * FROM Bill WHERE bill_id = ?";
    private static final String GET_BILL_ITEMS = "SELECT * FROM BillItem WHERE bill_id = ?";
    private static final String GET_BILLS_BY_ACCOUNT = "SELECT * FROM Bill WHERE account_number = ? ORDER BY bill_date DESC";
    private static final String GET_ALL_BILLS = "SELECT * FROM Bill ORDER BY bill_date DESC";
    private static final String UPDATE_BILL_STATUS = "UPDATE Bill SET status = ? WHERE bill_id = ?";

    public boolean generateBill(Bill bill, List<BillItem> items) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(INSERT_BILL, Statement.RETURN_GENERATED_KEYS)) {

            conn.setAutoCommit(false);

            stmt.setString(1, bill.getAccountNumber());
            stmt.setDate(2, new java.sql.Date(bill.getBillDate().getTime()));
            stmt.setDate(3, new java.sql.Date(bill.getDueDate().getTime()));
            stmt.setDouble(4, bill.getTotalAmount());
            stmt.setString(5, bill.getStatus());

            int affected = stmt.executeUpdate();
            if (affected == 0) {
                conn.rollback();
                return false;
            }

            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    String generatedBillId = String.valueOf(generatedKeys.getLong(1));
                    bill.setBillId(generatedBillId);
                }
            }

            // Fallback: try to resolve bill id from inserted row if not provided by DB
            if (bill.getBillId() == null || bill.getBillId().isEmpty()) {
                String resolvedId = resolveInsertedBillId(conn, bill);
                if (resolvedId == null) {
                    conn.rollback();
                    return false;
                }
                bill.setBillId(resolvedId);
            }

            if (items != null && !items.isEmpty()) {
                insertBillItems(conn, bill.getBillId(), items);
            }

            conn.commit();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private String resolveInsertedBillId(Connection conn, Bill bill) throws SQLException {
        String sql = "SELECT bill_id FROM Bill WHERE account_number = ? AND bill_date = ? AND due_date = ? AND total_amount = ? ORDER BY bill_id DESC";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, bill.getAccountNumber());
            ps.setDate(2, new java.sql.Date(bill.getBillDate().getTime()));
            ps.setDate(3, new java.sql.Date(bill.getDueDate().getTime()));
            ps.setDouble(4, bill.getTotalAmount());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getString(1);
                }
            }
        }
        return null;
    }

    private void insertBillItems(Connection conn, String billId, List<BillItem> items) throws SQLException {
        try (PreparedStatement stmt = conn.prepareStatement(INSERT_BILL_ITEMS)) {
            for (BillItem item : items) {
                stmt.setString(1, billId);
                stmt.setString(2, item.getItemId());
                stmt.setString(3, item.getDescription());
                stmt.setInt(4, item.getQuantity());
                stmt.setDouble(5, item.getUnitPrice());
                stmt.setDouble(6, item.getAmount());
                stmt.addBatch();
            }
            stmt.executeBatch();
        }
    }

    public Bill getBillById(String billId) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(GET_BILL_BY_ID)) {

            stmt.setString(1, billId);
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

    private List<BillItem> getBillItems(String billId) throws SQLException {
        List<BillItem> items = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(GET_BILL_ITEMS)) {

            stmt.setString(1, billId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    items.add(extractBillItemFromResultSet(rs));
                }
            }
        }
        return items;
    }

    public List<Bill> getBillsByCustomer(String accountNumber) {
        List<Bill> bills = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(GET_BILLS_BY_ACCOUNT)) {

            stmt.setString(1, accountNumber);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Bill bill = extractBillFromResultSet(rs);
                    bill.setItems(getBillItems(bill.getBillId()));
                    bills.add(bill);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bills;
    }

    public List<Bill> getAllBills() {
        List<Bill> bills = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(GET_ALL_BILLS)) {

            while (rs.next()) {
                Bill bill = extractBillFromResultSet(rs);
                bill.setItems(getBillItems(bill.getBillId()));
                bills.add(bill);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bills;
    }

    public boolean updateBillStatus(String billId, String status) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(UPDATE_BILL_STATUS)) {

            stmt.setString(1, status);
            stmt.setString(2, billId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private Bill extractBillFromResultSet(ResultSet rs) throws SQLException {
        Bill bill = new Bill();
        bill.setBillId(rs.getString("bill_id"));
        bill.setAccountNumber(rs.getString("account_number"));
        bill.setBillDate(rs.getDate("bill_date"));
        bill.setDueDate(rs.getDate("due_date"));
        bill.setTotalAmount(rs.getDouble("total_amount"));
        bill.setStatus(rs.getString("status"));
        return bill;
    }

    private BillItem extractBillItemFromResultSet(ResultSet rs) throws SQLException {
        BillItem item = new BillItem();
        item.setBillItemId(rs.getString("bill_item_id"));
        item.setBillId(rs.getString("bill_id"));
        item.setItemId(rs.getString("item_id"));
        item.setDescription(rs.getString("description"));
        item.setQuantity(rs.getInt("quantity"));
        item.setUnitPrice(rs.getDouble("unit_price"));
        item.setAmount(rs.getDouble("amount"));
        return item;
    }
}