package com.icbt.service;

import com.icbt.model.Item;
import com.icbt.util.DBConnection;
import org.junit.jupiter.api.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import static org.junit.jupiter.api.Assertions.*;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class ItemServiceTest {

    private ItemService itemService;
    private Connection conn;
    private int seededItemId;

    private Connection ensureConnection() throws SQLException {
        conn = DBConnection.getConnection();
        if (conn == null || conn.isClosed()) {
            conn = DBConnection.getConnection(); // reopen
        }
        return conn;
    }

    @BeforeEach
    void setUp() throws Exception {
        itemService = new ItemService();

        ensureConnection();

        // Seed one item to work with
        seededItemId = (int) (System.currentTimeMillis() / 1000);

        try (PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO items (item_id, title, author, publisher, price, quantity) VALUES (?, ?, ?, ?, ?, ?)")) {
            ps.setString(1, String.valueOf(seededItemId));
            ps.setString(2, "JUnit Seed Book");
            ps.setString(3, "Tester");
            ps.setString(4, "TestPub");
            ps.setDouble(5, 999.99);
            ps.setInt(6, 5);
            ps.executeUpdate();
        }
    }

    @AfterEach
    void tearDown() throws Exception {
        ensureConnection();

        // Clean up seeded data
        try (PreparedStatement ps = conn.prepareStatement("DELETE FROM items WHERE item_id = ?")) {
            ps.setString(1, String.valueOf(seededItemId));
            ps.executeUpdate();
        }
    }

    @Test
    @Order(1)
    void testGetItemByTitle() throws SQLException {
        ensureConnection();

        Item found = itemService.getItemByTitle("JUnit Seed Book");

        assertNotNull(found, "Item should not be null");
        assertEquals("JUnit Seed Book", found.getTitle());
        assertEquals(5, found.getQuantity());
    }
}
