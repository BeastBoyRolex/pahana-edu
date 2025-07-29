package com.icbt.dao;

import com.icbt.model.Bill;
import com.icbt.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BillingDAO {
    public boolean addBill(Bill bill) {
        String sql = "INSERT INTO billing (account_number, billing_date, units_consumed, amount, payment_status) " +
                "VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, bill.getAccountNumber());
            stmt.setDate(2, new java.sql.Date(bill.getBillingDate().getTime()));
            stmt.setInt(3, bill.getUnitsConsumed());
            stmt.setDouble(4, bill.getAmount());
            stmt.setString(5, bill.getPaymentStatus());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Bill getBill(int billId) {
        String sql = "SELECT * FROM billing WHERE bill_id = ?";
        Bill bill = null;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, billId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                bill = new Bill(
                        rs.getString("account_number"),
                        rs.getDate("billing_date"),
                        rs.getInt("units_consumed"),
                        rs.getDouble("amount"),
                        rs.getString("payment_status")
                );
                bill.setBillId(rs.getInt("bill_id"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bill;
    }

    public List<Bill> getBillsByAccount(String accountNumber) {
        List<Bill> bills = new ArrayList<>();
        String sql = "SELECT * FROM billing WHERE account_number = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, accountNumber);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Bill bill = new Bill(
                        rs.getString("account_number"),
                        rs.getDate("billing_date"),
                        rs.getInt("units_consumed"),
                        rs.getDouble("amount"),
                        rs.getString("payment_status")
                );
                bill.setBillId(rs.getInt("bill_id"));
                bills.add(bill);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bills;
    }
}
