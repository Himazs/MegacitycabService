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
            max-width: 500px;
            background-color: #ffffff;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            border: 1px solid #e0e0e0;
            text-align: center;
            margin-top: 20px;
        }
        .input-box {
            width: 80%;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
        .btn {
            background-color: #1a73e8;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }
        .btn:hover {
            background-color: #1558b0;
        }
        .btn-delete {
            background-color: red;
            color: white;
            padding: 8px 12px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
        }
        .btn-delete:hover {
            background-color: darkred;
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
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #f4f4f4;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Cancel Booking</h2>

        <%
        // Try to get userId from session (assuming user is logged in and userId is stored in session)
        String userId = (String) session.getAttribute("userId");

        // If userId is not in session, show the form to input userId
        if (userId == null || userId.trim().isEmpty()) {
            // Fallback: Check if userId was submitted via GET request
            userId = request.getParameter("userId");
            if (userId == null || userId.trim().isEmpty()) {
        %>
                <!-- User ID Input Form -->
                <form method="GET">
                    <input type="text" name="userId" class="input-box" placeholder="Enter User ID" required>
                    <button type="submit" class="btn">Show My Bookings</button>
                </form>
        <%
                return; // Exit early to prevent further rendering
            }
        }

        // If userId is available (from session or GET parameter), display bookings
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/megacitycab?useSSL=false";
            conn = DriverManager.getConnection(url, "root", "Himas123@#");

            String query = "SELECT id, pickup_location, drop_location, status FROM cab_bookings WHERE userId = ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, userId);
            rs = pstmt.executeQuery();

            if (!rs.isBeforeFirst()) {
                out.println("<p class='error'>No bookings found for User ID: " + userId + "</p>");
            } else {
        %>
                <h3>Your Bookings</h3>
                <table>
                    <tr>
                        <th>Booking ID</th>
                        <th>Pickup</th>
                        <th>Dropoff</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
        <%
                    while (rs.next()) {
                        int bookingId = rs.getInt("id");
                        String pickup = rs.getString("pickup_location");
                        String dropoff = rs.getString("drop_location");
                        String status = rs.getString("status");
        %>
                    <tr>
                        <td><%= bookingId %></td>
                        <td><%= pickup %></td>
                        <td><%= dropoff %></td>
                        <td><%= status %></td>
                        <td>
                            <form method="POST" action="CancelBooking.jsp">
                                <input type="hidden" name="userId" value="<%= userId %>">
                                <input type="hidden" name="bookingId" value="<%= bookingId %>">
                                <button type="submit" class="btn-delete">Delete</button>
                            </form>
                        </td>
                    </tr>
        <%
                    }
        %>
                </table>
        <%
            }
        } catch (Exception e) {
            out.println("<p class='error'>Error: " + e.getMessage() + "</p>");
        } finally {
            try { if (rs != null) rs.close(); if (pstmt != null) pstmt.close(); if (conn != null) conn.close(); }
            catch (SQLException e) { e.printStackTrace(); }
        }

        // Handle POST request to cancel a booking
        String bookingIdToDelete = request.getParameter("bookingId");
        if (bookingIdToDelete != null) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/megacitycab?useSSL=false";
                conn = DriverManager.getConnection(url, "root", "Himas123@#");

                String checkQuery = "SELECT userId FROM cab_bookings WHERE id = ?";
                pstmt = conn.prepareStatement(checkQuery);
                pstmt.setInt(1, Integer.parseInt(bookingIdToDelete));
                rs = pstmt.executeQuery();

                if (rs.next() && rs.getString("userId").equals(userId)) {
                    String deleteQuery = "DELETE FROM cab_bookings WHERE id = ?";
                    pstmt = conn.prepareStatement(deleteQuery);
                    pstmt.setInt(1, Integer.parseInt(bookingIdToDelete));
                    int rowsAffected = pstmt.executeUpdate();

                    if (rowsAffected > 0) {
                        out.println("<p class='success'>Booking ID " + bookingIdToDelete + " has been canceled successfully.</p>");
                    } else {
                        out.println("<p class='error'>Failed to cancel Booking ID " + bookingIdToDelete + ".</p>");
                    }
                } else {
                    out.println("<p class='error'>Unauthorized action or booking not found.</p>");
                }
                rs.close();
            } catch (Exception e) {
                out.println("<p class='error'>Error: " + e.getMessage() + "</p>");
            } finally {
                try { if (pstmt != null) pstmt.close(); if (conn != null) conn.close(); }
                catch (SQLException e) { e.printStackTrace(); }
            }
        }
        %>
    </div>
</body>
</html>