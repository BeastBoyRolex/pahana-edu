package com.icbt.service;

import com.icbt.model.Bill;
import com.icbt.model.BillItem;
import com.icbt.model.Item;
import com.icbt.util.DBConnection;
import org.junit.jupiter.api.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

@TestMethodOrder(MethodOrderer.OrderAnnotation.class)
public class BillServiceTest {

    private BillService billService;
    private ItemService itemService;
    private Connection conn;

    private String accountNumber;
    private int itemId;
    private String insertedBillId;

    @BeforeEach
    void setUp() throws Exception {
        billService = new BillService();
        itemService = new ItemService();
        conn = DBConnection.getConnection();

        // Ensure a customer exists
        accountNumber = "2";
        try (PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO customers (account_number, name, address, telephone, units_consumed) VALUES (?, ?, ?, ?, ?)")) {
            ps.setString(1, accountNumber);
            ps.setString(2, "JUnit Customer");
            ps.setString(3, "Test Address");
            ps.setString(4, "+94 71 0000000");
            ps.setInt(5, 0);
            ps.executeUpdate();
        }

        // Seed an item
        itemId = (int) (System.currentTimeMillis() / 1000);
        try (PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO items (item_id, title, author, publisher, price, quantity) VALUES (?, ?, ?, ?, ?, ?)")) {
            ps.setString(1, String.valueOf(itemId));
            ps.setString(2, "JUnit Bill Item");
            ps.setString(3, "Tester");
            ps.setString(4, "TestPub");
            ps.setDouble(5, 500.00);
            ps.setInt(6, 10);
            ps.executeUpdate();
        }
    }

    @AfterEach
    void tearDown() throws Exception {
        // Delete inserted bill items and bills if created
        if (insertedBillId != null) {
            try (PreparedStatement ps = conn.prepareStatement("DELETE FROM BillItem WHERE bill_id = ?")) {
                ps.setString(1, insertedBillId);
                ps.executeUpdate();
            }
            try (PreparedStatement ps = conn.prepareStatement("DELETE FROM Bill WHERE bill_id = ?")) {
                ps.setString(1, insertedBillId);
                ps.executeUpdate();
            }
        }

        try (PreparedStatement ps = conn.prepareStatement("DELETE FROM items WHERE item_id = ?")) {
            ps.setString(1, String.valueOf(itemId));
            ps.executeUpdate();
        }
        try (PreparedStatement ps = conn.prepareStatement("DELETE FROM customers WHERE account_number = ?")) {
            ps.setString(1, accountNumber);
            ps.executeUpdate();
        }
    }

    @Test
    @Order(1)
    void testGenerateBillAndItems() throws Exception {
        List<BillItem> items = new ArrayList<>();
        BillItem it = new BillItem();
        it.setItemId(String.valueOf(itemId));
        it.setQuantity(2);
        it.setUnitPrice(500.00);
        items.add(it);

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date billDate = sdf.parse("2025-01-01");
        Date dueDate = sdf.parse("2025-01-31");

        Bill bill = billService.generateBill(accountNumber, items, billDate, dueDate);
        assertNotNull(bill.getBillId());
        insertedBillId = bill.getBillId();

        // Verify Bill table
        try (PreparedStatement ps = conn.prepareStatement("SELECT total_amount, status FROM Bill WHERE bill_id = ?")) {
            ps.setString(1, insertedBillId);
            try (ResultSet rs = ps.executeQuery()) {
                assertTrue(rs.next());
                assertEquals(1000.00, rs.getDouble(1), 0.001);
                assertEquals("PENDING", rs.getString(2));
            }
        }

        // Verify BillItem table
        try (PreparedStatement ps = conn.prepareStatement("SELECT count(*) FROM BillItem WHERE bill_id = ?")) {
            ps.setString(1, insertedBillId);
            try (ResultSet rs = ps.executeQuery()) {
                assertTrue(rs.next());
                assertEquals(1, rs.getInt(1));
            }
        }

        // Verify stock deducted
        Item refreshed = itemService.getItemById(String.valueOf(itemId));
        assertEquals(8, refreshed.getQuantity());
    }
}


