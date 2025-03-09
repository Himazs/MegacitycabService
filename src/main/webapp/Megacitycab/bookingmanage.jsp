<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>MegaCityCab - Booking Details</title>
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
        max-width: 1000px;
        background-color: #ffffff;
        padding: 25px;
        border-radius: 10px;
        box-shadow: 0 3px 15px rgba(0, 0, 0, 0.1);
        border: 1px solid #e0e0e0;
        overflow-x: auto;
        margin-top: 15px;
    }
    .header {
        text-align: center;
        padding-bottom: 15px;
        border-bottom: 1px solid #f5f5f5;
    }
    .header h1 {
        color: #1a73e8;
        font-size: 26px;
        margin: 0;
    }
    table {
        width: 100%;
        max-width: 100%;
        border-collapse: collapse;
        margin-top: 15px;
        font-size: 18px;
        color: #333;
        table-layout: auto;
        background-color: #ffffff;
        border-radius: 6px;
    }
    th, td {
        padding: 10px;
        text-align: left;
        border-bottom: 1px solid #f0f0f0;
        white-space: nowrap;
    }
    th {
        background-color: #ffd407;
        color: #000;
        font-weight: 600;
        cursor: pointer;
    }
    th:hover {
        background-color: #e6c400;
    }
    tr:nth-child(even) {
        background-color: #f9f9f9;
    }
    tr:hover {
        background-color: #f5f5f5;
    }
    .no-data {
        text-align: center;
        color: #666;
        font-weight: 500;
        font-size: 18px;
        margin-top: 15px;
    }
    .error-message {
        text-align: center;
        color: #d32f2f;
        font-weight: 500;
        font-size: 18px;
        margin-top: 15px;
    }
    /* Remove Button Styles */
    .remove-btn {
        background-color: #d32f2f; /* Default red color */
        color: white;
        border: none;
        padding: 6px 12px;
        border-radius: 4px;
        cursor: pointer;
        font-size: 14px;
        transition: background-color 0.3s;
    }
    .remove-btn:hover {
        background-color: #b71c1c; /* Darker red on hover */
    }
    /* Responsive Design */
    @media screen and (max-width: 900px) {
        .container {
            width: 90%;
            margin: 10px;
            padding: 15px;
        }
        table {
            width: 100%;
        }
        th, td {
            padding: 8px;
            font-size: 16px;
        }
        .header h1 {
            font-size: 22px;
        }
        .no-data, .error-message {
            font-size: 16px;
        }
        .remove-btn {
            padding: 5px 10px; /* Slightly smaller on mobile */
            font-size: 12px;
        }
    }
</style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>MegaCityCab - Booking Details</h1>
        </div>

        <%
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        // Handle deletion if a remove request is submitted
        String removeId = request.getParameter("removeId");
        if (removeId != null && !removeId.isEmpty()) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/megacitycab?useSSL=false";
                conn = DriverManager.getConnection(url, "root", "Himas123@#");
                
                String deleteSql = "DELETE FROM cab_bookings WHERE id = ?";
                pstmt = conn.prepareStatement(deleteSql);
                pstmt.setInt(1, Integer.parseInt(removeId));
                pstmt.executeUpdate();
                
                out.println("<script>alert('Booking removed successfully!'); window.location.href='bookingmanage.jsp';</script>");
            } catch (Exception e) {
                out.println("<div class='error-message'>Error deleting booking: " + e.getMessage() + "</div>");
            } finally {
                try {
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }

        // Display the table
        try {
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/megacitycab?useSSL=false";
            conn = DriverManager.getConnection(url, "root", "Himas123@#");

            String sql = "SELECT * FROM cab_bookings ORDER BY booking_timestamp DESC";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            boolean hasBookings = false;
        %>
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
                <th>Action</th> <!-- New column for Remove button -->
            </tr>
            <%
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
                String userId = rs.getString("userId");
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
                <td><%= userId != null ? userId : "N/A" %></td>
                <td><%= driverId != null ? driverId : "N/A" %></td>
                <td><%= driverName != null ? driverName : "N/A" %></td>
                <td>
                    <form method="post" action="" onsubmit="return confirm('Are you sure you want to remove this booking?');">
                        <input type="hidden" name="removeId" value="<%= id %>">
                        <button type="submit" class="remove-btn">Remove</button>
                    </form>
                </td>
            </tr>
            <%
            }
            if (!hasBookings) {
            %>
            <tr>
                <td colspan="12" class="no-data">No booking records available at this time.</td>
            </tr>
            <%
            }
            } catch (Exception e) {
            %>
            <tr>
                <td colspan="12" class="error-message">An error occurred: <%= e.getMessage() %></td>
            </tr>
            <%
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<tr><td colspan='12' class='error-message'>Error closing connection: " + e.getMessage() + "</td></tr>");
                }
            }
            %>
        </table>
    </div>
</body>
</html>