<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Booking Status</title>
</head>
<body>
    <%
    Connection conn = null;
    PreparedStatement pstmt = null;
    String message = null;

    try {
        // Get parameters from the request
        String bookingIdStr = request.getParameter("bookingId");
        String status = request.getParameter("status");
        String driverId = request.getParameter("driverId");
        String driverName = request.getParameter("driverName");

        // Log the parameters for debugging (remove in production)
        System.out.println("bookingIdStr: " + bookingIdStr);
        System.out.println("status: " + status);
        System.out.println("driverId: " + driverId);
        System.out.println("driverName: " + driverName);

        if (bookingIdStr == null || bookingIdStr.isEmpty()) {
            message = "No booking ID provided.";
            throw new Exception(message);
        }

        int bookingId = Integer.parseInt(bookingIdStr);

        // Load the JDBC driver
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/megacitycab?useSSL=false";
        conn = DriverManager.getConnection(url, "root", "Himas123@#");

        if ("accepted".equalsIgnoreCase(status)) {
            // Check if driverId and driverName are provided for acceptance
            if (driverId == null || driverId.trim().isEmpty() || driverName == null || driverName.trim().isEmpty()) {
                message = "Missing driver ID or driver name for accepting the booking. Please enter both Driver ID and Driver Name.";
                throw new Exception(message);
            }

            // Update booking with driver details and set status to "accepted"
            String sql = "UPDATE cab_bookings SET driver_id = ?, driver_name = ?, status = ? WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, driverId.trim());
            pstmt.setString(2, driverName.trim());
            pstmt.setString(3, "accepted");
            pstmt.setInt(4, bookingId);
        } else if ("rejected".equalsIgnoreCase(status)) {
            // Update only the status to "rejected" and clear driver details
            String sql = "UPDATE cab_bookings SET status = ?, driver_id = NULL, driver_name = NULL WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, "rejected");
            pstmt.setInt(2, bookingId);
        } else {
            message = "Invalid status. Use 'accepted' or 'rejected'.";
            throw new Exception(message);
        }

        int rowsAffected = pstmt.executeUpdate();
        if (rowsAffected > 0) {
            message = "Booking " + status + " successfully! Driver ID: " + (driverId != null ? driverId.trim() : "N/A") + ", Driver Name: " + (driverName != null ? driverName.trim() : "N/A");
        } else {
            message = "Failed to update booking. Booking ID " + bookingId + " not found.";
        }
    } catch (Exception e) {
        message = "An error occurred: " + e.getMessage();
        e.printStackTrace(); // Log the stack trace for debugging
    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
            if (message == null) {
                message = "Database connection error: " + e.getMessage();
            }
        }
    }

    // Return the message as plain text
    if (message != null) {
        out.print(message);
    }
    %>
</body>
</html>