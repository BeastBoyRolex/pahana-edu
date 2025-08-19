package com.icbt.service;

import com.icbt.model.Customer;
import com.icbt.util.DBConnection;
import org.junit.jupiter.api.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import static org.junit.jupiter.api.Assertions.*;

public class CustomerServiceTest {

    private CustomerService customerService;
    private Connection conn;
    private String accountNumber;

    @BeforeEach
    void setUp() throws Exception {
        customerService = new CustomerService();

        // Ensure connection is alive
        conn = DBConnection.getConnection();
        if (conn == null || conn.isClosed()) {
            conn = DBConnection.getConnection(); // reopen if closed
        }

        accountNumber = "1";

        try (PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO customers (account_number, name, address, telephone, units_consumed) VALUES (?, ?, ?, ?, ?)")) {
            ps.setString(1, accountNumber);
            ps.setString(2, "JUnit Customer");
            ps.setString(3, "Test Address");
            ps.setString(4, "+94 71 0000000");
            ps.setInt(5, 0);
            ps.executeUpdate();
        }
    }

    @AfterEach
    void tearDown() throws Exception {
        // Ensure connection is still valid
        if (conn == null || conn.isClosed()) {
            conn = DBConnection.getConnection();
        }

        try (PreparedStatement ps = conn.prepareStatement("DELETE FROM customers WHERE account_number = ?")) {
            ps.setString(1, accountNumber);
            ps.executeUpdate();
        }
    }

    @Test
    void testGetCustomerByAccountNumber() throws SQLException {
        // Ensure connection is valid before test
        if (conn == null || conn.isClosed()) {
            conn = DBConnection.getConnection();
        }

        Customer c = customerService.getCustomerByAccountNumber(accountNumber);

        assertNotNull(c, "Customer should not be null");
        assertEquals("JUnit Customer", c.getName(), "Customer name should match inserted value");
        assertEquals("Test Address", c.getAddress());
        assertEquals("+94 71 0000000", c.getTelephone());
        assertEquals(0, c.getUnitsConsumed());
    }
}
