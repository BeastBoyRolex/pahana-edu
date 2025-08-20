package com.icbt.util;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import static org.junit.jupiter.api.Assertions.*;

public class DBConnectionTest {

    private Connection connection;

    @BeforeEach
    void setUp() throws Exception {
        connection = DBConnection.getConnection();
        assertNotNull(connection, "Connection should not be null");
        assertFalse(connection.isClosed(), "Connection should be open");
    }

    @AfterEach
    void tearDown() throws Exception {
        // Do not close the shared connection permanently; just ensure it's valid
        assertNotNull(connection);
        assertFalse(connection.isClosed());
    }

    @Test
    void testSimpleQuery() throws Exception {
        try (Statement st = connection.createStatement();
             ResultSet rs = st.executeQuery("SELECT 1")) {
            assertTrue(rs.next());
            assertEquals(1, rs.getInt(1));
        }
    }
}


