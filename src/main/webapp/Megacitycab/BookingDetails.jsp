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
            background-image: url(images/back.png); /* Optional: Keep the background image if desired */
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            flex-direction: column;
        }
        .container {
            max-width: 1000px; /* Match the width in your image */
            background-color: #ffffff; /* White background for the container */
            padding: 30px;
            border-radius: 12px; /* Rounded corners like in your image */
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1); /* Subtle shadow for depth */
            border: 1px solid #e0e0e0; /* Light border for definition */
            overflow-x: auto; /* Enable horizontal scrolling if table overflows */
            margin-top: 20px; /* Space from the top */
        }
        .header {
            text-align: center;
            padding-bottom: 20px;
            border-bottom: 2px solid #f5f5f5; /* Light gray bottom border for header */
        }
        .header h1 {
            color: #1a73e8;
            font-size: 28px;
            margin: 0;
        }
        .input-form {
            text-align: center;
            margin-bottom: 20px;
        }
        .input-form label {
            font-weight: 600;
            color: #444;
            margin-right: 10px;
        }
        .input-form input {
            padding: 8px;
            border: 1px solid #e0e0e0;
            border-radius: 4px;
            font-size: 16px;
        }
        .input-form button {
            padding: 8px 15px;
            border: none;
            border-radius: 5px;
            background-color: #4CAF50; /* Green */
            color: white;
            cursor: pointer;
            transition: background-color 0.3s ease;
            font-weight: bold;
        }
        .input-form button:hover {
            background-color: #45a049;
        }
        table {
            width: 100%;
            max-width: 100%; /* Ensure table doesn't exceed container */
            border-collapse: collapse;
            margin-top: 20px;
            font-size: 16px;
            color: #333;
            table-layout: auto; /* Allow table columns to adjust naturally */
            background-color: #ffffff; /* White background for the table */
            border-radius: 8px; /* Optional: Rounded corners for the table */
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #f0f0f0; /* Light gray border for rows */
            white-space: nowrap; /* Prevent text wrapping to keep table compact */
        }
        th {
            background-color: #ffd407; /* Yellow header as in your image */
            color: #000;
            font-weight: 600;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9; /* Light gray for even rows */
        }
        tr:hover {
            background-color: #f5f5f5; /* Lighter gray on hover */
        }
        .cancel-button {
            padding: 5px 10px;
            border: none;
            border-radius: 4px;
            background-color: #f44336; /* Red for cancellation */
            color: white;
            cursor: pointer;
            transition: background-color 0.3s ease;
            font-size: 14px;
            font-weight: bold;
        }
        .cancel-button:hover {
            background-color: #da190b; /* Darker red on hover */
        }
        .no-data {
            text-align: center;
            color: #666;
            font-weight: 500;
            margin-top: 20px;
        }
        .error-message {
            text-align: center;
            color: #d32f2f;
            font-weight: 500;
            margin-top: 20px;
        }
        /* Responsive Design */
        @media screen and (max-width: 600px) {
            .container {
                width: 90%;
                margin: 10px;
                padding: 15px;
            }
            table {
                width: 100%;
            }
            th, td {
                padding: 10px;
                font-size: 14px;
            }
            .header h1 {
                font-size: 24px;
            }
            .input-form {
                margin-bottom: 15px;
            }
            .input-form input, .input-form button {
                font-size: 14px;
                padding: 6px;
            }
            .cancel-button {
                padding: 4px 8px;
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
        String userId = request.getParameter("userId"); // Use userId as the parameter

        // If no userId is provided, show a form to input it
        if (userId == null || userId.trim().isEmpty()) {
        %>
        <div class="input-form">
            <form action="BookingDetails.jsp" method="get">
                <label for="userId">User ID:</label>
                <input type="text" id="userId" name="userId" required>
                <button type="submit">Submit</button>
            </form>
        </div>
        <div class="error-message">
            No user ID provided. Please specify a user ID.
        </div>
        <%
        } else {
            try {
                // Validate userId
                userId = userId.trim();

                // Load the JDBC driver
                Class.forName("com.mysql.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/megacitycab?useSSL=false";
                conn = DriverManager.getConnection(url, "root", "Himas123@#");

                // Query the cab_bookings table for the specific userId
                String sql = "SELECT id, name, phone, pickup_location, drop_location, car_type, booking_timestamp, status, driver_id, driver_name " +
                             "FROM cab_bookings WHERE userId = ? ORDER BY booking_timestamp DESC";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, userId);
                rs = pstmt.executeQuery();

                boolean hasBookings = false;
            %>
            <table>
                <tr>
                    <th>Booking ID</th>
                    <th>Customer Name</th>
                    <th>Phone</th>
                    <th>Car Type</th>
                    <th>Pickup Location</th>
                    <th>Drop Location</th>
                    <th>Booking Date</th>
                    <th>Status</th>
                    <th>Driver ID</th>
                    <th>Driver Name</th>
                    <th>Action</th> <!-- Added column for Cancel button -->
                </tr>
                <%
                SimpleDateFormat sdf = new SimpleDateFormat("dd MMMM yyyy, HH:mm:ss");
                while (rs.next()) {
                    hasBookings = true;
                    int bookingId = rs.getInt("id");
                    String customerName = rs.getString("name");
                    String phoneNumber = rs.getString("phone");
                    String carType = rs.getString("car_type");
                    String pickupLocation = rs.getString("pickup_location");
                    String dropLocation = rs.getString("drop_location");
                    Timestamp bookingTimestamp = rs.getTimestamp("booking_timestamp");
                    String status = rs.getString("status");
                    String driverId = rs.getString("driver_id");
                    String driverName = rs.getString("driver_name");
                    String formattedDate = (bookingTimestamp != null) ? sdf.format(bookingTimestamp) : "N/A";
                %>
                <tr>
                    <td><%= bookingId %></td>
                    <td><%= customerName != null ? customerName : "N/A" %></td>
                    <td><%= phoneNumber != null ? phoneNumber : "N/A" %></td>
                    <td><%= carType != null ? carType : "N/A" %></td>
                    <td><%= pickupLocation != null ? pickupLocation : "N/A" %></td>
                    <td><%= dropLocation != null ? dropLocation : "N/A" %></td>
                    <td><%= formattedDate %></td>
                    <td><%= status != null ? status : "N/A" %></td>
                    <td><%= driverId != null ? driverId : "N/A" %></td>
                    <td><%= driverName != null ? driverName : "N/A" %></td>
                    <td>
                        <form action="CancelBooking.jsp" method="post">
                            <input type="hidden" name="bookingId" value="<%= bookingId %>">
                            <input type="hidden" name="userId" value="<%= userId %>">
                            <button type="submit" class="cancel-button">Cancel Booking</button>
                        </form>
                    </td>
                </tr>
                <%
                }
                if (!hasBookings) {
                %>
                <tr>
                    <td colspan="11" class="no-data">No bookings available for User ID <%= userId %> at this time.</td>
                </tr>
                <%
                }
                %>
            </table>
            <%
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
                    out.println("<div class='error-message'>Error closing connection: " + e.getMessage() + "</div>");
                }
            }
        }
        %>
    </div>
</body>
</html>