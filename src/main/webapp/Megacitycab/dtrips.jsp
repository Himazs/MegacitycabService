<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.SimpleDateFormat, java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>MegaCityCab - Booking Profile</title>
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            margin: 0;
            background-image: url(images/back.png);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .container {
            max-width: 450px;
            background: linear-gradient(to right, #ffd407, #ffffff);
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            border: 1px solid #e0e0e0;
        }
        .header {
            text-align: center;
            padding-bottom: 20px;
            border-bottom: 2px solid #f5f5f5;
        }
        .header h1 {
            color: #1a73e8;
            font-size: 28px;
            margin: 0;
        }
        .header p {
            color: #666;
            font-size: 14px;
            margin: 5px 0 0;
        }
        .profile-details {
            margin-top: 20px;
            font-size: 16px;
            color: #333;
        }
        .detail-row {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #f0f0f0;
        }
        .detail-row:last-child {
            border-bottom: none;
        }
        .label {
            font-weight: 600;
            color: #444;
            flex: 1;
        }
        .value {
            flex: 2;
            text-align: left;
            color: #666;
        }
        .status {
            font-weight: 600;
            color: #4CAF50; /* Green for accepted, adjust for other statuses */
        }
        .error-message, .no-data {
            text-align: center;
            color: #d32f2f;
            font-weight: 500;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>MegaCityCab</h1>
            <p>Booking Profile Dashboard</p>
        </div>

        <%
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/megacitycab?useSSL=false";
            conn = DriverManager.getConnection(url, "root", "Himas123@#");

            String sql = "SELECT * FROM cab_bookings ORDER BY RAND() LIMIT 1";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String phone = rs.getString("phone");
                String pickupLocation = rs.getString("pickup_location");
                String dropLocation = rs.getString("drop_location");
                String carType = rs.getString("car_type");
                Timestamp bookingTimestamp = rs.getTimestamp("booking_timestamp");
                String status = rs.getString("status");
                String formattedTimestamp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(bookingTimestamp);
        %>
        <div class="profile-details">
            <div class="detail-row">
                <span class="label">Booking ID:</span>
                <span class="value"><%= id %></span>
            </div>
            <div class="detail-row">
                <span class="label">Name:</span>
                <span class="value"><%= name %></span>
            </div>
            <div class="detail-row">
                <span class="label">Phone:</span>
                <span class="value"><%= phone %></span>
            </div>
            <div class="detail-row">
                <span class="label">Pickup Location:</span>
                <span class="value"><%= pickupLocation %></span>
            </div>
            <div class="detail-row">
                <span class="label">Drop-off Location:</span>
                <span class="value"><%= dropLocation %></span>
            </div>
            <div class="detail-row">
                <span class="label">Car Type:</span>
                <span class="value"><%= carType %></span>
            </div>
            <div class="detail-row">
                <span class="label">Booking Time:</span>
                <span class="value"><%= formattedTimestamp %></span>
            </div>
            <div class="detail-row">
                <span class="label">Status:</span>
                <span class="value <%= status.equals("accepted") ? "status" : "" %>"><%= status %></span>
            </div>
        </div>
        <%
            } else {
        %>
        <div class="no-data">
            No booking records available at this time.
        </div>
        <%
            }
        } catch (Exception e) {
        %>
        <div class="error-message">
            An error occurred: <%= e.getMessage() %>
        </div>
        <%
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        %>
    </div>
</body>
</html>