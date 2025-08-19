package com.icbt.service;

import com.icbt.dao.ItemDAO;
import com.icbt.model.Item;
import com.icbt.util.DBConnection;
import org.junit.jupiter.api.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import static org.junit.jupiter.api.Assertions.*;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class ItemServiceTest {

    private ItemService itemService;
    private Connection conn;
    private int seededItemId;

    @BeforeEach
    void setUp() throws Exception {
        itemService = new ItemService();
        conn = DBConnection.getConnection();

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
        // Clean up seeded data
        try (PreparedStatement ps = conn.prepareStatement("DELETE FROM items WHERE item_id = ?")) {
            ps.setString(1, String.valueOf(seededItemId));
            ps.executeUpdate();
        }
    }

    @Test
    @Order(1)
    void testGetItemByTitle() {
        Item found = itemService.getItemByTitle("JUnit Seed Book");
        assertNotNull(found);
        assertEquals("JUnit Seed Book", found.getTitle());
        assertEquals(5, found.getQuantity());
    }

    @Test
    @Order(2)
    void testUpdateStock() {
        boolean ok = itemService.updateStock(String.valueOf(seededItemId), -2);
        assertTrue(ok);

        Item refreshed = itemService.getItemById(String.valueOf(seededItemId));
        assertNotNull(refreshed);
        assertEquals(3, refreshed.getQuantity());
    }
}


