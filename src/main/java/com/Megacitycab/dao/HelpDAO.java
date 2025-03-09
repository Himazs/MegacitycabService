package com.Megacitycab.dao;

import com.Megacitycab.model.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class HelpDAO {
    private static final String URL = "jdbc:mysql://localhost:3306/megacitycab?useSSL=false";
    private static final String USER = "root";
    private static final String PASSWORD = "Himas123@#"; // Replace with your DB password

    // Get database connection
    private Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("Database connection successful"); // Add this for debugging
            return conn;
        } catch (ClassNotFoundException e) {
            System.err.println("MySQL Driver not found: " + e.getMessage());
            throw new SQLException("MySQL Driver not found", e);
        } catch (SQLException e) {
            System.err.println("Connection failed: " + e.getMessage());
            throw e;
        }
    }

    // Insert a new help request into the database
    public void saveHelpRequest(Help help) throws SQLException {
        String sql = "INSERT INTO userhelp (booking_id, issue_type, userid) VALUES (?, ?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, help.getBookingId());
            pstmt.setString(2, help.getIssueType());
            pstmt.setString(3, help.getUserid());  // Add userid to the insert
            pstmt.executeUpdate();
        }
    }
}
