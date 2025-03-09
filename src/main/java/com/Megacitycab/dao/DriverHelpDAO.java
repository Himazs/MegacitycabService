package com.Megacitycab.dao;

import com.Megacitycab.model.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class DriverHelpDAO {
    private static final String URL = "jdbc:mysql://localhost:3306/megacitycab?useSSL=false";
    private static final String USER = "root";
    private static final String PASSWORD = "Himas123@#"; // Replace with your DB password

    // Get database connection
    private Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL Driver not found", e);
        }
    }

    // Insert a new help request into the database
    public void saveHelpRequest(DriverHelp help) throws SQLException {
        String sql = "INSERT INTO driverhelp (issue, description) VALUES (?, ?)";
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, help.getIssue());
            pstmt.setString(2, help.getDescription());
            pstmt.executeUpdate();
        }
    }
}