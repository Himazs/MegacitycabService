<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>MegaCityCab - Recent Trips</title>
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
            max-width: 1200px;
            background-color: #ffd898;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            border: 1px solid #e0e0e0;
            overflow-x: auto;
            margin-top: 20px;
        }

        .box {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            border: 1px solid #e0e0e0;
            overflow-x: auto;
        }

        h2 {
            text-align: center;
            color: #1a73e8;
            margin: 0 0 20px 0;
            font-size: 28px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            font-size: 16px;
            color: #333;
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #f0f0f0;
        }

        th {
            background-color: #ffd407;
            color: #000;
            font-weight: 600;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #f5f5f5;
        }

        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 1000;
        }

        .modal-content {
            background-color: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
            width: 400px;
            text-align: center;
        }

        .modal-title {
            font-size: 24px;
            margin-bottom: 20px;
            color: #1a73e8;
        }

        .modal-input {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 16px;
            box-sizing: border-box;
        }

        .modal-button {
            background-color: #1a73e8;
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .modal-button:hover {
            background-color: #0d5bdd;
        }

        .user-title {
            font-size: 18px;
            margin-bottom: 15px;
            color: #555;
            text-align: center;
            font-weight: bold;
        }

        .no-data {
            text-align: center;
            color: #666;
            font-weight: 500;
            font-size: 18px;
            padding: 20px;
        }

        .error-message {
            text-align: center;
            color: #d32f2f;
            font-weight: 500;
            font-size: 18px;
            padding: 20px;
        }
    </style>
</head>
<body>
    <%
        String userId = request.getParameter("userid");
        boolean hasUserId = (userId != null && !userId.trim().isEmpty());
    %>

    <% if (!hasUserId) { %>
    <div class="modal-overlay" id="userIdModal">
        <div class="modal-content">
            <div class="modal-title">Enter User ID</div>
            <form action="recentTrips.jsp" method="get">
                <input type="text" name="userid" class="modal-input" placeholder="Enter User ID" required autofocus>
                <button type="submit" class="modal-button">View Trips</button>
            </form>
        </div>
    </div>
    <% } else { %>
    <div class="container">
        <div class="box">
            <h2>MegaCityCab - Recent Trips</h2>
            <div class="user-title">Showing recent trips for User ID: <%= userId %></div>
            
            <table>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Phone</th>
                    <th>Pickup Location</th>
                    <th>Drop Location</th>
                    <th>Car Type</th>
                    <th>Booking Timestamp</th>
                    <th>Status</th>
                    <th>User ID</th>
                    <th>Driver ID</th>
                    <th>Driver Name</th>
                </tr>
                <%
                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;
                    
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        String url = "jdbc:mysql://localhost:3306/megacitycab?useSSL=false";
                        conn = DriverManager.getConnection(url, "root", "Himas123@#");
                        
                        String sql = "SELECT * FROM cab_bookings WHERE userId = ? ORDER BY booking_timestamp DESC";
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setString(1, userId);
                        rs = pstmt.executeQuery();
                        
                        boolean hasBookings = false;
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                        
                        while (rs.next()) {
                            hasBookings = true;
                            int id = rs.getInt("id");
                            String name = rs.getString("name");
                            String phone = rs.getString("phone");
                            String pickupLocation = rs.getString("pickup_location");
                            String dropLocation = rs.getString("drop_location");
                            String carType = rs.getString("car_type");
                            Timestamp bookingTimestamp = rs.getTimestamp("booking_timestamp");
                            String status = rs.getString("status");
                            String userIdDb = rs.getString("userId");
                            String driverId = rs.getString("driver_id");
                            String driverName = rs.getString("driver_name");
                %>
                <tr>
                    <td><%= id %></td>
                    <td><%= name != null ? name : "N/A" %></td>
                    <td><%= phone != null ? phone : "N/A" %></td>
                    <td><%= pickupLocation != null ? pickupLocation : "N/A" %></td>
                    <td><%= dropLocation != null ? dropLocation : "N/A" %></td>
                    <td><%= carType != null ? carType : "N/A" %></td>
                    <td><%= bookingTimestamp != null ? sdf.format(bookingTimestamp) : "N/A" %></td>
                    <td><%= status != null ? status : "N/A" %></td>
                    <td><%= userIdDb != null ? userIdDb : "N/A" %></td>
                    <td><%= driverId != null ? driverId : "N/A" %></td>
                    <td><%= driverName != null ? driverName : "N/A" %></td>
                </tr>
                <%
                        }
                        if (!hasBookings) {
                %>
                <tr>
                    <td colspan="11" class="no-data">No trip records available for User ID: <%= userId %></td>
                </tr>
                <%
                        }
                    } catch (Exception e) {
                        out.println("<tr><td colspan='11' class='error-message'>Error: " + e.getMessage() + "</td></tr>");
                    } finally {
                        try {
                            if (rs != null) rs.close();
                            if (pstmt != null) pstmt.close();
                            if (conn != null) conn.close();
                        } catch (SQLException e) {
                            out.println("<tr><td colspan='11' class='error-message'>Error closing connection: " + e.getMessage() + "</td></tr>");
                        }
                    }
                %>
            </table>
            
           
        </div>
    </div>
    <% } %>
</body>
</html>