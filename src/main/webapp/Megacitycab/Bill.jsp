<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.DecimalFormat, java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>MegaCityCab - User Bill Details</title>
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
            max-width: 450px;
            background-color: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            border: 1px solid #e0e0e0;
            margin-top: 20px;
        }
        .header {
            text-align: center;
            padding-bottom: 15px;
            border-bottom: 1px solid #f5f5f5;
        }
        .header h1 {
            color: #1a73e8;
            font-size: 24px;
            margin: 0;
        }
        .input-form {
            text-align: center;
            margin-bottom: 15px;
        }
        .input-form label {
            font-weight: 600;
            color: #444;
            margin-right: 8px;
        }
        .input-form input {
            padding: 6px;
            border: 1px solid #e0e0e0;
            border-radius: 4px;
            font-size: 14px;
        }
        .input-form button {
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            background-color: #4CAF50;
            color: white;
            cursor: pointer;
            transition: background-color 0.3s ease;
            font-weight: bold;
            font-size: 14px;
        }
        .input-form button:hover {
            background-color: #45a049;
        }
        .bill {
            max-width: 100%;
            margin: 15px auto;
            padding: 15px;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }
        .header-bill, .footer-bill {
            text-align: center;
        }
        .header-bill h2 {
            color: #1a73e8;
            font-size: 20px;
            margin: 0 0 8px;
        }
        .header-bill p {
            color: #666;
            font-size: 12px;
            margin: 0;
        }
        .details, .fare-details {
            font-size: 14px;
            color: #333;
            line-height: 1.4;
        }
        .detail-row {
            display: flex;
            justify-content: space-between;
            padding: 8px 0;
            border-bottom: 1px solid #f0f0f0;
        }
        .detail-row:last-child {
            border-bottom: none;
        }
        .label {
            font-weight: bold;
            color: #444;
            flex: 1;
        }
        .value {
            flex: 2;
            text-align: left;
            color: #666;
        }
        .total {
            font-size: 16px;
            font-weight: bold;
            text-align: right;
            margin-top: 15px;
            padding-top: 8px;
            border-top: 1px solid #eee;
        }
        .footer-bill {
            margin-top: 15px;
            font-size: 12px;
            color: #777;
        }
        .no-data, .error-message {
            text-align: center;
            color: #d32f2f;
            font-weight: 500;
            font-size: 14px;
            margin-top: 15px;
        }
        @media screen and (max-width: 600px) {
            .container {
                width: 90%;
                padding: 10px;
            }
            .header h1 {
                font-size: 20px;
            }
            .input-form input, .input-form button {
                font-size: 12px;
                padding: 4px;
            }
            .bill {
                padding: 10px;
            }
            .header-bill h2 {
                font-size: 18px;
            }
            .header-bill p, .footer-bill, .details, .fare-details {
                font-size: 12px;
            }
            .total {
                font-size: 14px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>MegaCityCab - User Bill Details</h1>
        </div>

        <%
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String userId = request.getParameter("userId");

        if (userId == null || userId.trim().isEmpty()) {
        %>
            <div class="input-form">
                <form action="Bill.jsp" method="get">
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

                Class.forName("com.mysql.cj.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/megacitycab?useSSL=false";
                conn = DriverManager.getConnection(url, "root", "Himas123@#");

                // Updated SQL query to include distance
                String sql = "SELECT id, name, pickup_location, drop_location, car_type, booking_timestamp, status, driver_id, driver_name, distance " +
                             "FROM cab_bookings WHERE userId = ? ORDER BY booking_timestamp DESC";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, userId);
                rs = pstmt.executeQuery();

                boolean hasBookings = false;

                while (rs.next()) {
                    hasBookings = true;
                    int bookingId = rs.getInt("id");
                    String customerName = rs.getString("name");
                    String pickupLocation = rs.getString("pickup_location");
                    String dropLocation = rs.getString("drop_location");
                    String carType = rs.getString("car_type");
                    Timestamp bookingTimestamp = rs.getTimestamp("booking_timestamp");
                    String driverName = rs.getString("driver_name");
                    Double distance = rs.getDouble("distance"); // Retrieve distance from database
                    boolean distanceWasNull = rs.wasNull(); // Check if distance was NULL

                    DecimalFormat df = new DecimalFormat("#.##");
                    String formattedDistance = distanceWasNull ? "Not available" : df.format(distance);

                    double ratePerKm = 0;
                    if (carType != null) {
                        if (carType.equalsIgnoreCase("Economic Class Ride") || carType.equalsIgnoreCase("standard")) {
                            ratePerKm = 150;
                        } else if (carType.equalsIgnoreCase("Executive Class Ride") || carType.equalsIgnoreCase("executive")) {
                            ratePerKm = 500;
                        } else if (carType.equalsIgnoreCase("Premium Class Ride") || carType.equalsIgnoreCase("premium")) {
                            ratePerKm = 350;
                        }
                    }

                    double baseFare = 50;
                    double distanceFare = distanceWasNull ? 0 : ratePerKm * distance; // Use 0 if distance is NULL
                    double totalFare = baseFare + distanceFare;

                    DecimalFormat currencyFormatter = new DecimalFormat("#,###.##");
                    String formattedBaseFare = currencyFormatter.format(baseFare);
                    String formattedDistanceFare = distanceWasNull ? "Not applicable" : currencyFormatter.format(distanceFare);
                    String formattedTotalFare = currencyFormatter.format(totalFare);

                    SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
                    String formattedDate = (bookingTimestamp != null) ? sdf.format(bookingTimestamp) : sdf.format(new java.util.Date());
        %>
            <div class="bill">
                <div class="header-bill">
                    <h2>Bill for Booking #<%= bookingId %></h2>
                    <p>Date: <%= formattedDate %></p>
                </div>
                <div class="details">
                    <div class="detail-row"><span class="label">Customer:</span><span class="value"><%= customerName != null ? customerName : "N/A" %></span></div>
                    <div class="detail-row"><span class="label">Car Type:</span><span class="value"><%= carType != null ? carType : "N/A" %></span></div>
                    <div class="detail-row"><span class="label">Pickup Location:</span><span class="value"><%= pickupLocation != null ? pickupLocation : "N/A" %></span></div>
                    <div class="detail-row"><span class="label">Drop Location:</span><span class="value"><%= dropLocation != null ? dropLocation : "N/A" %></span></div>
                    <div class="detail-row"><span class="label">Driver:</span><span class="value"><%= driverName != null ? driverName : "Not assigned" %></span></div>
                    <div class="detail-row"><span class="label">Distance:</span><span class="value"><%= formattedDistance %> <%= !distanceWasNull ? "km" : "" %></span></div>
                </div>
                <div class="fare-details">
                    <div class="detail-row"><span class="label">Base Fare:</span><span class="value">LKR <%= formattedBaseFare %></span></div>
                    <div class="detail-row"><span class="label">Distance Fare:</span><span class="value"><%= distanceWasNull ? "N/A" : "LKR " + formattedDistanceFare %></span></div>
                    <div class="total">Total Fare: LKR <%= formattedTotalFare %></div>
                </div>
                <div class="footer-bill">Thank you for riding with MegaCityCab!</div>
            </div>
        <%
                }
                if (!hasBookings) {
        %>
            <div class="no-data">No bookings found for this user.</div>
        <%
                }
            } catch (Exception e) {
        %>
            <div class="error-message">Error: <%= e.getMessage() %></div>
        <%
            } finally {
                try { if (rs != null) rs.close(); } catch (Exception e) {}
                try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
                try { if (conn != null) conn.close(); } catch (Exception e) {}
            }
        }
        %>
    </div>
</body>
</html>