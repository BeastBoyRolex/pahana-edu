package com.icbt.service;

import com.icbt.model.Customer;
import com.icbt.util.DBConnection;
import org.junit.jupiter.api.*;

import java.sql.Connection;
import java.sql.PreparedStatement;

import static org.junit.jupiter.api.Assertions.*;

public class CustomerServiceTest {

    private CustomerService customerService;
    private Connection conn;
    private String accountNumber;

    @BeforeEach
    void setUp() throws Exception {
        customerService = new CustomerService();
        conn = DBConnection.getConnection();
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
        try (PreparedStatement ps = conn.prepareStatement("DELETE FROM customers WHERE account_number = ?")) {
            ps.setString(1, accountNumber);
            ps.executeUpdate();
        }
    }

    @Test
    void testGetCustomerByAccountNumber() {
        Customer c = customerService.getCustomerByAccountNumber(accountNumber);
        assertNotNull(c);
        assertEquals("JUnit Customer", c.getName());
    }
}


