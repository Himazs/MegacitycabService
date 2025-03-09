<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>MegaCityCab - Cancel Booking</title>
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            margin: 0;
            background-image: url(images/back.png);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            flex-direction: column;
        }
        .container {
            max-width: 400px;
            background-color: #ffffff;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            border: 1px solid #e0e0e0;
            text-align: center;
            margin-top: 20px;
        }
        .message {
            font-size: 18px;
            color: #333;
            margin-bottom: 15px;
        }
        .success {
            color: #2e7d32;
        }
        .error {
            color: #d32f2f;
        }
        a {
            text-decoration: none;
            color: #1a73e8;
            font-weight: bold;
            font-size: 16px;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <%
        Connection conn = null;
        PreparedStatement pstmt = null;
        String message = "";
        String messageClass = "";

        try {
            // Get bookingId and userId from the request
            String bookingId = request.getParameter("bookingId");
            String userId = request.getParameter("userId");

            if (bookingId == null || bookingId.trim().isEmpty()) {
                message = "No booking ID provided. Cannot cancel booking.";
                messageClass = "error";
            } else {
                // Load the JDBC driver
                Class.forName("com.mysql.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/megacitycab?useSSL=false";
                conn = DriverManager.getConnection(url, "root", "Himas123@#");

                // Verify the booking belongs to the user before deletion
                String verifySql = "SELECT userId FROM cab_bookings WHERE id = ?";
                PreparedStatement verifyPstmt = conn.prepareStatement(verifySql);
                verifyPstmt.setInt(1, Integer.parseInt(bookingId));
                ResultSet rs = verifyPstmt.executeQuery();

                if (rs.next()) {
                    String dbUserId = rs.getString("userId");
                    if (dbUserId != null && dbUserId.equals(userId)) {
                        // Delete the booking
                        String deleteSql = "DELETE FROM cab_bookings WHERE id = ?";
                        pstmt = conn.prepareStatement(deleteSql);
                        pstmt.setInt(1, Integer.parseInt(bookingId));
                        int rowsAffected = pstmt.executeUpdate();

                        if (rowsAffected > 0) {
                            message = "Booking # " + bookingId + " has been successfully canceled.";
                            messageClass = "success";
                        } else {
                            message = "Failed to cancel booking # " + bookingId + ". Please try again.";
                            messageClass = "error";
                        }
                    } else {
                        message = "You are not authorized to cancel this booking.";
                        messageClass = "error";
                    }
                } else {
                    message = "Booking # " + bookingId + " not found.";
                    messageClass = "error";
                }

                rs.close();
                if (verifyPstmt != null) verifyPstmt.close();
            }
        } catch (Exception e) {
            message = "An error occurred: " + e.getMessage();
            messageClass = "error";
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        %>
        <div class="message <%= messageClass %>"><%= message %></div>
        <a href="BookingDetails.jsp?userId=<%= request.getParameter("userId") %>">Back to Booking Details</a>
    </div>
</body>
</html>