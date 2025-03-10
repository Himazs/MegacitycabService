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
            max-width: 600px; /* Reduced from 1000px */
            background-color: #ffffff;
            padding: 15px; /* Reduced from 30px */
            border-radius: 8px; /* Slightly smaller radius */
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); /* Smaller shadow */
            border: 1px solid #e0e0e0;
            margin-top: 10px; /* Reduced from 20px */
        }
        .header {
            text-align: center;
            padding-bottom: 10px; /* Reduced from 20px */
            border-bottom: 1px solid #f5f5f5; /* Thinner border */
        }
        .header h1 {
            color: #1a73e8;
            font-size: 20px; /* Reduced from 28px */
            margin: 0;
        }
        .input-form {
            text-align: center;
            margin-bottom: 10px; /* Reduced from 20px */
        }
        .input-form label {
            font-weight: 600;
            color: #444;
            margin-right: 5px; /* Reduced from 10px */
            font-size: 14px; /* Smaller font */
        }
        .input-form input {
            padding: 5px; /* Reduced from 8px */
            border: 1px solid #e0e0e0;
            border-radius: 3px; /* Slightly smaller radius */
            font-size: 14px; /* Reduced from 16px */
        }
        .input-form button {
            padding: 5px 10px; /* Reduced from 8px 15px */
            border: none;
            border-radius: 3px;
            background-color: #4CAF50;
            color: white;
            cursor: pointer;
            transition: background-color 0.3s ease;
            font-weight: bold;
            font-size: 14px; /* Reduced from default */
        }
        .input-form button:hover {
            background-color: #45a049;
        }
        .booking-card {
            background-color: #f9f9f9;
            border: 1px solid #e0e0e0;
            border-radius: 5px; /* Reduced from 8px */
            padding: 10px; /* Reduced from 15px */
            margin-bottom: 10px; /* Reduced from 20px */
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1); /* Smaller shadow */
        }
        .booking-field {
            display: flex;
            flex-direction: column;
            margin-bottom: 5px; /* Reduced from 10px */
        }
        .booking-field label {
            font-weight: 600;
            color: #444;
            margin-bottom: 3px; /* Reduced from 5px */
            font-size: 12px; /* Reduced font size */
        }
        .booking-field span {
            padding: 3px; /* Reduced from 5px */
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 3px;
            word-wrap: break-word;
            font-size: 12px; /* Reduced font size */
        }
        .cancel-button {
            padding: 5px 10px; /* Reduced from 8px 15px */
            border: none;
            border-radius: 3px;
            background-color: #f44336;
            color: white;
            cursor: pointer;
            transition: background-color 0.3s ease;
            font-size: 12px; /* Reduced from 14px */
            font-weight: bold;
            width: 100%;
            max-width: 150px; /* Reduced from 200px */
            margin-top: 5px; /* Reduced from 10px */
        }
        .cancel-button:hover {
            background-color: #da190b;
        }
        .no-data {
            text-align: center;
            color: #666;
            font-weight: 500;
            margin-top: 10px; /* Reduced from 20px */
            font-size: 14px; /* Reduced font size */
        }
        .error-message {
            text-align: center;
            color: #d32f2f;
            font-weight: 500;
            margin-top: 10px; /* Reduced from 20px */
            font-size: 14px; /* Reduced font size */
        }
        @media screen and (max-width: 600px) {
            .container {
                width: 90%;
                margin: 5px; /* Reduced from 10px */
                padding: 10px; /* Reduced from 15px */
            }
            .booking-card {
                padding: 8px; /* Reduced from 10px */
            }
            .booking-field label, .booking-field span {
                font-size: 10px; /* Further reduced for mobile */
            }
            .cancel-button {
                padding: 4px 8px; /* Reduced from 6px 12px */
                font-size: 10px; /* Reduced from 12px */
            }
            .header h1 {
                font-size: 18px; /* Reduced from 24px */
            }
            .input-form {
                margin-bottom: 10px; /* Reduced from 15px */
            }
            .input-form input, .input-form button {
                font-size: 12px; /* Reduced from 14px */
                padding: 4px; /* Reduced from 6px */
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
        String userId = request.getParameter("userId");

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
                userId = userId.trim();

                Class.forName("com.mysql.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/megacitycab?useSSL=false";
                conn = DriverManager.getConnection(url, "root", "Himas123@#");

                String sql = "SELECT id, name, phone, pickup_location, drop_location, car_type, booking_timestamp, status, driver_id, driver_name " +
                             "FROM cab_bookings WHERE userId = ? ORDER BY booking_timestamp DESC";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, userId);
                rs = pstmt.executeQuery();

                boolean hasBookings = false;
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
                <div class="booking-card">
                    <div class="booking-field">
                        <label>Booking ID:</label>
                        <span><%= bookingId %></span>
                    </div>
                    <div class="booking-field">
                        <label>Customer Name:</label>
                        <span><%= customerName != null ? customerName : "N/A" %></span>
                    </div>
                    <div class="booking-field">
                        <label>Phone:</label>
                        <span><%= phoneNumber != null ? phoneNumber : "N/A" %></span>
                    </div>
                    <div class="booking-field">
                        <label>Car Type:</label>
                        <span><%= carType != null ? carType : "N/A" %></span>
                    </div>
                    <div class="booking-field">
                        <label>Pickup Location:</label>
                        <span><%= pickupLocation != null ? pickupLocation : "N/A" %></span>
                    </div>
                    <div class="booking-field">
                        <label>Drop Location:</label>
                        <span><%= dropLocation != null ? dropLocation : "N/A" %></span>
                    </div>
                    <div class="booking-field">
                        <label>Booking Date:</label>
                        <span><%= formattedDate %></span>
                    </div>
                    <div class="booking-field">
                        <label>Status:</label>
                        <span><%= status != null ? status : "N/A" %></span>
                    </div>
                    <div class="booking-field">
                        <label>Driver ID:</label>
                        <span><%= driverId != null ? driverId : "N/A" %></span>
                    </div>
                    <div class="booking-field">
                        <label>Driver Name:</label>
                        <span><%= driverName != null ? driverName : "N/A" %></span>
                    </div>
                    <form action="CancelBooking.jsp" method="post">
                        <input type="hidden" name="bookingId" value="<%= bookingId %>">
                        <input type="hidden" name="userId" value="<%= userId %>">
                    </form>
                </div>
                <%
                }
                if (!hasBookings) {
                %>
                <div class="no-data">
                    No bookings available for User ID <%= userId %> at this time.
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
                    out.println("<div class='error-message'>Error closing connection: " + e.getMessage() + "</div>");
                }
            }
        }
        %>
    </div>
</body>
</html>