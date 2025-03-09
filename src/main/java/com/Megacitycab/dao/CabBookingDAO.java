package com.Megacitycab.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.Megacitycab.model.*;

public class CabBookingDAO {
    private String jdbcURL = "jdbc:mysql://localhost:3306/megacitycab?useSSL=false";
    private String jdbcUsername = "root";
    private String jdbcPassword = "Himas123@#";
    private static final String INSERT_BOOKING_SQL = "INSERT INTO cab_bookings (name, phone, pickup_location, drop_location, car_type, userid) VALUES (?, ?, ?, ?, ?, ?)";

    static {
        // Load MySQL JDBC driver (optional, depending on your JDBC version)
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC Driver not found.", e);
        }
    }

    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
    }

    public void saveBooking(CabBooking booking) throws SQLException {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_BOOKING_SQL)) {
            preparedStatement.setString(1, booking.getName());
            preparedStatement.setString(2, booking.getPhone());
            preparedStatement.setString(3, booking.getPickupLocation());
            preparedStatement.setString(4, booking.getDropLocation());
            preparedStatement.setString(5, booking.getCarType());
            preparedStatement.setString(6, booking.getUserid());  // Add userid to the insert
            System.out.println("Executing: " + preparedStatement);
            int rowsAffected = preparedStatement.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("Booking saved successfully!");
            } else {
                System.out.println("Failed to save booking.");
            }
        } catch (SQLException e) {
            System.err.println("SQL Error: " + e.getMessage());
            throw new SQLException("Failed to save booking due to database error.", e);
        }
    }
}
