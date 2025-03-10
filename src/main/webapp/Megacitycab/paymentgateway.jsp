<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.DecimalFormat, java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>MegaCityCab - Payment Gateway</title>
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
            background-size: cover;
            background-position: center;
        }
        .container {
            max-width: 400px; /* Reduced max-width for a more compact container */
            background-color: #ffffff;
            padding: 15px; /* Reduced padding */
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            border: 1px solid #e0e0e0;
            margin-top: 15px; /* Reduced margin */
        }
        .header {
            text-align: center;
            padding-bottom: 10px; /* Reduced padding */
            border-bottom: 1px solid #f5f5f5;
        }
        .header h1 {
            color: #1a73e8;
            font-size: 20px; /* Reduced font size */
            margin: 0;
        }
        .input-form {
            text-align: center;
            margin-bottom: 10px; /* Reduced margin */
        }
        .input-form label {
            font-weight: 600;
            color: #444;
            margin-right: 6px; /* Reduced margin */
            font-size: 12px; /* Reduced font size */
        }
        .input-form input {
            padding: 4px; /* Reduced padding */
            border: 1px solid #e0e0e0;
            border-radius: 3px;
            font-size: 12px; /* Reduced font size */
            width: 120px; /* Reduced width */
        }
        .input-form button {
            padding: 4px 8px; /* Reduced padding */
            border: none;
            border-radius: 3px;
            background-color: #4CAF50;
            color: white;
            cursor: pointer;
            transition: background-color 0.3s ease;
            font-weight: bold;
            font-size: 12px; /* Reduced font size */
        }
        .input-form button:hover {
            background-color: #45a049;
        }
        .booking-details {
            font-size: 12px; /* Reduced font size */
            color: #333;
            line-height: 1.3; /* Adjusted line height */
            margin-bottom: 15px; /* Reduced margin */
        }
        .detail-row {
            display: flex;
            justify-content: space-between;
            padding: 6px 0; /* Reduced padding */
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
            font-size: 14px; /* Reduced font size */
            font-weight: bold;
            text-align: right;
            margin-top: 10px; /* Reduced margin */
            padding-top: 6px; /* Reduced padding */
            border-top: 1px solid #eee;
        }
        .payment-form {
            margin-top: 15px; /* Reduced margin */
        }
        .payment-form label {
            display: block;
            font-weight: bold;
            color: #444;
            margin-bottom: 3px; /* Reduced margin */
            font-size: 12px; /* Reduced font size */
        }
        .payment-form input, .payment-form select {
            width: 100%;
            padding: 6px; /* Reduced padding */
            margin-bottom: 10px; /* Reduced margin */
            border: 1px solid #e0e0e0;
            border-radius: 3px;
            font-size: 12px; /* Reduced font size */
        }
        .payment-form button {
            width: 100%;
            padding: 8px; /* Reduced padding */
            border: none;
            border-radius: 3px;
            background-color: #4CAF50;
            color: white;
            cursor: pointer;
            transition: background-color 0.3s ease;
            font-weight: bold;
            font-size: 12px; /* Reduced font size */
        }
        .payment-form button:hover {
            background-color: #45a049;
        }
        .error-message {
            text-align: center;
            color: #d32f2f;
            font-weight: 500;
            font-size: 12px; /* Reduced font size */
            margin-top: 10px; /* Reduced margin */
        }
        @media screen and (max-width: 600px) {
            .container {
                width: 85%; /* Slightly smaller width for mobile */
                padding: 10px;
            }
            .header h1 {
                font-size: 18px;
            }
            .input-form input, .input-form button {
                font-size: 11px;
                padding: 3px;
            }
            .booking-details, .payment-form input, .payment-form select, .payment-form button {
                font-size: 11px;
            }
            .total {
                font-size: 13px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>MegaCityCab - Payment Gateway</h1>
        </div>

        <%
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String bookingId = request.getParameter("bookingId");
        String userId = request.getParameter("userId");

        // If either bookingId or userId is missing, show a form to input userId
        if ((bookingId == null || bookingId.trim().isEmpty()) && (userId == null || userId.trim().isEmpty())) {
        %>
            <div class="input-form">
                <form action="paymentgateway.jsp" method="get">
                    <label for="userId">User ID:</label>
                    <input type="text" id="userId" name="userId" required>
                    <button type="submit">Submit</button>
                </form>
            </div>
            <div class="error-message">
                Please provide a User ID to view your bookings.
            </div>
        <%
        } else {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/megacitycab?useSSL=false";
                conn = DriverManager.getConnection(url, "root", "Himas123@#");

                // If userId is provided but bookingId is not, fetch the latest booking for the user
                if (userId != null && (bookingId == null || bookingId.trim().isEmpty())) {
                    userId = userId.trim();
                    String sql = "SELECT id, name, pickup_location, drop_location, car_type, booking_timestamp, status, driver_id, driver_name, distance, userId " +
                                 "FROM cab_bookings WHERE userId = ? AND status = 'pending' ORDER BY booking_timestamp DESC LIMIT 1";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, userId);
                    rs = pstmt.executeQuery();

                    if (rs.next()) {
                        bookingId = String.valueOf(rs.getInt("id"));
                    } else {
        %>
                        <div class="error-message">
                            No pending bookings found for User ID <%= userId %>.
                        </div>
                        <div class="input-form">
                            <form action="paymentgateway.jsp" method="get">
                                <label for="userId">Try Another User ID:</label>
                                <input type="text" id="userId" name="userId" required>
                                <button type="submit">Submit</button>
                            </form>
                        </div>
        <%
                        return; // Exit the JSP to prevent further processing
                    }
                }

                // Now fetch the booking details using bookingId
                if (bookingId != null) {
                    bookingId = bookingId.trim();
                    String sql = "SELECT id, name, pickup_location, drop_location, car_type, booking_timestamp, status, driver_id, driver_name, distance, userId " +
                                 "FROM cab_bookings WHERE id = ?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setInt(1, Integer.parseInt(bookingId));
                    rs = pstmt.executeQuery();

                    if (rs.next()) {
                        int bookingIdValue = rs.getInt("id");
                        String customerName = rs.getString("name");
                        String pickupLocation = rs.getString("pickup_location");
                        String dropLocation = rs.getString("drop_location");
                        String carType = rs.getString("car_type");
                        Timestamp bookingTimestamp = rs.getTimestamp("booking_timestamp");
                        String driverName = rs.getString("driver_name");
                        Double distance = rs.getDouble("distance");
                        boolean distanceWasNull = rs.wasNull();
                        userId = rs.getString("userId");

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
                        double distanceFare = distanceWasNull ? 0 : ratePerKm * distance;
                        double totalFare = baseFare + distanceFare;

                        DecimalFormat currencyFormatter = new DecimalFormat("#,###.##");
                        String formattedBaseFare = currencyFormatter.format(baseFare);
                        String formattedDistanceFare = distanceWasNull ? "Not applicable" : currencyFormatter.format(distanceFare);
                        String formattedTotalFare = currencyFormatter.format(totalFare);

                        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
                        String formattedDate = (bookingTimestamp != null) ? sdf.format(bookingTimestamp) : sdf.format(new java.util.Date());
        %>
                        <div class="booking-details">
                            <div class="detail-row"><span class="label">Booking ID:</span><span class="value"><%= bookingIdValue %></span></div>
                            <div class="detail-row"><span class="label">Customer:</span><span class="value"><%= customerName != null ? customerName : "N/A" %></span></div>
                            <div class="detail-row"><span class="label">Car Type:</span><span class="value"><%= carType != null ? carType : "N/A" %></span></div>
                            <div class="detail-row"><span class="label">Pickup Location:</span><span class="value"><%= pickupLocation != null ? pickupLocation : "N/A" %></span></div>
                            <div class="detail-row"><span class="label">Drop Location:</span><span class="value"><%= dropLocation != null ? dropLocation : "N/A" %></span></div>
                            <div class="detail-row"><span class="label">Driver:</span><span class="value"><%= driverName != null ? driverName : "Not assigned" %></span></div>
                            <div class="detail-row"><span class="label">Distance:</span><span class="value"><%= formattedDistance %> <%= !distanceWasNull ? "km" : "" %></span></div>
                            <div class="detail-row"><span class="label">Base Fare:</span><span class="value">LKR <%= formattedBaseFare %></span></div>
                            <div class="detail-row"><span class="label">Distance Fare:</span><span class="value"><%= distanceWasNull ? "N/A" : "LKR " + formattedDistanceFare %></span></div>
                            <div class="total">Total Amount to Pay: LKR <%= formattedTotalFare %></div>
                        </div>

                        <div class="payment-form">
                            <form action="payment-success.jsp" method="post">
                                <input type="hidden" name="bookingId" value="<%= bookingIdValue %>">
                                <input type="hidden" name="totalFare" value="<%= totalFare %>">
                                <input type="hidden" name="userId" value="<%= userId != null ? userId : "" %>">
                                <label for="cardNumber">Card Number:</label>
                                <input type="text" id="cardNumber" name="cardNumber" placeholder="1234 5678 9012 3456" required>
                                <label for="expiryDate">Expiry Date:</label>
                                <input type="text" id="expiryDate" name="expiryDate" placeholder="MM/YY" required>
                                <label for="cvv">CVV:</label>
                                <input type="text" id="cvv" name="cvv" placeholder="123" required>
                                <label for="paymentMethod">Payment Method:</label>
                                <select id="paymentMethod" name="paymentMethod" required>
                                    <option value="credit_card">Credit Card</option>
                                    <option value="debit_card">Debit Card</option>
                                </select>
                                <button type="submit">Pay Now</button>
                              <p class="warning-text" style="color: red; font-size: 12px; font-weight: bold;">
    Only make your payment if the driver agrees to the ride.
</p>

                            </form>
                        </div>
        <%
                    } else {
        %>
                        <div class="error-message">
                            No booking found with ID <%= bookingId %>.
                        </div>
                        <div class="input-form">
                            <form action="paymentgateway.jsp" method="get">
                                <label for="userId">Enter Your User ID:</label>
                                <input type="text" id="userId" name="userId" required>
                                <button type="submit">Submit</button>
                            </form>
                        </div>
        <%
                    }
                }
            } catch (Exception e) {
        %>
                <div class="error-message">Error: <%= e.getMessage() %></div>
                <div class="input-form">
                    <form action="paymentgateway.jsp" method="get">
                        <label for="userId">Try Again with User ID:</label>
                        <input type="text" id="userId" name="userId" required>
                        <button type="submit">Submit</button>
                    </form>
                </div>
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