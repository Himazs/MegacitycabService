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

        .trip-card {
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            border: 1px solid #e0e0e0;
        }

        .trip-card h3 {
            margin: 0 0 10px 0;
            color: #1a73e8;
            font-size: 20px;
        }

        .trip-card p {
            margin: 5px 0;
            color: #333;
            font-size: 16px;
        }

        .trip-card p strong {
            color: #000;
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
            <div class="trip-card">
                <h3>Trip ID: <%= id %></h3>
                <p><strong>Name:</strong> <%= name != null ? name : "N/A" %></p>
                <p><strong>Phone:</strong> <%= phone != null ? phone : "N/A" %></p>
                <p><strong>Pickup Location:</strong> <%= pickupLocation != null ? pickupLocation : "N/A" %></p>
                <p><strong>Drop Location:</strong> <%= dropLocation != null ? dropLocation : "N/A" %></p>
                <p><strong>Car Type:</strong> <%= carType != null ? carType : "N/A" %></p>
                <p><strong>Booking Timestamp:</strong> <%= bookingTimestamp != null ? sdf.format(bookingTimestamp) : "N/A" %></p>
                <p><strong>Status:</strong> <%= status != null ? status : "N/A" %></p>
                <p><strong>User ID:</strong> <%= userIdDb != null ? userIdDb : "N/A" %></p>
                <p><strong>Driver ID:</strong> <%= driverId != null ? driverId : "N/A" %></p>
                <p><strong>Driver Name:</strong> <%= driverName != null ? driverName : "N/A" %></p>
            </div>
            <%
                    }
                    if (!hasBookings) {
            %>
            <div class="no-data">No trip records available for User ID: <%= userId %></div>
            <%
                    }
                } catch (Exception e) {
                    out.println("<div class='error-message'>Error: " + e.getMessage() + "</div>");
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (pstmt != null) pstmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        out.println("<div class='error-message'>Error closing connection: " + e.getMessage() + "</div>");
                    }
                }
            %>
        </div>
    </div>
    <% } %>
</body>
</html>