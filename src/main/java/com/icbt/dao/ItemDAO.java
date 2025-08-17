package com.icbt.dao;

import com.icbt.model.Item;
import com.icbt.util.DBConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ItemDAO {
    private static final String INSERT_ITEM = "INSERT INTO items (item_id, title, author, publisher, price, quantity) VALUES (?, ?, ?, ?, ?, ?)";
    private static final String UPDATE_ITEM = "UPDATE items SET title=?, author=?, publisher=?, price=?, quantity=? WHERE item_id=?";
    private static final String DELETE_ITEM = "DELETE FROM items WHERE item_id=?";
    private static final String GET_ALL_ITEMS = "SELECT * FROM items";
    private static final String GET_ITEM_BY_ID = "SELECT * FROM items WHERE item_id=?";
    private static final String UPDATE_STOCK = "UPDATE items SET quantity=? WHERE item_id=?";

    public List<Item> getAllItems() {
        List<Item> items = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(GET_ALL_ITEMS)) {

            while (rs.next()) {
                items.add(extractItemFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return items;
    }

    public Item getItemById(String itemId) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(GET_ITEM_BY_ID)) {

            stmt.setString(1, itemId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return extractItemFromResultSet(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean addItem(Item item) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(INSERT_ITEM)) {

            stmt.setString(1, String.valueOf(item.getItemId()));
            stmt.setString(2, item.getTitle());
            stmt.setString(3, item.getAuthor());
            stmt.setString(4, item.getPublisher());
            stmt.setDouble(5, item.getPrice());
            stmt.setInt(6, item.getQuantity());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateItem(Item item) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(UPDATE_ITEM)) {

            stmt.setString(1, item.getTitle());
            stmt.setString(2, item.getAuthor());
            stmt.setString(3, item.getPublisher());
            stmt.setDouble(4, item.getPrice());
            stmt.setInt(5, item.getQuantity());
            stmt.setString(6, String.valueOf(item.getItemId()));

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteItem(String itemId) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(DELETE_ITEM)) {

            stmt.setString(1, itemId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateStock(String itemId, int quantityChange) {
        try (Connection conn = DBConnection.getConnection()) {
            // First get current stock
            Item currentItem = getItemById(itemId);
            if (currentItem == null) {
                return false;
            }
            
            // Calculate new stock level
            int newQuantity = currentItem.getQuantity() + quantityChange;
            
            // Ensure stock doesn't go negative
            if (newQuantity < 0) {
                newQuantity = 0;
            }
            
            // Update stock
            try (PreparedStatement stmt = conn.prepareStatement(UPDATE_STOCK)) {
                stmt.setInt(1, newQuantity);
                stmt.setString(2, itemId);
                return stmt.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private Item extractItemFromResultSet(ResultSet rs) throws SQLException {
        Item item = new Item();
        item.setItemId(Integer.parseInt(rs.getString("item_id")));
        item.setTitle(rs.getString("title"));
        item.setAuthor(rs.getString("author"));
        item.setPublisher(rs.getString("publisher"));
        item.setPrice(rs.getDouble("price"));
        item.setQuantity(rs.getInt("quantity"));
        return item;
    }
}