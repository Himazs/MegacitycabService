<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.Random, java.text.DecimalFormat, java.text.SimpleDateFormat" %>

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
            padding: 20px; /* Reduced padding */
            border-radius: 10px; /* Slightly smaller radius */
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); /* Reduced shadow */
            border: 1px solid #e0e0e0;
            margin-top: 20px;
        }
        .header {
            text-align: center;
            padding-bottom: 15px; /* Reduced padding */
            border-bottom: 1px solid #f5f5f5; /* Thinner border */
        }
        .header h1 {
            color: #1a73e8;
            font-size: 24px; /* Reduced font size */
            margin: 0;
        }
        .input-form {
            text-align: center;
            margin-bottom: 15px; /* Reduced margin */
        }
        .input-form label {
            font-weight: 600;
            color: #444;
            margin-right: 8px; /* Reduced margin */
        }
        .input-form input {
            padding: 6px; /* Reduced padding */
            border: 1px solid #e0e0e0;
            border-radius: 4px;
            font-size: 14px; /* Reduced font size */
        }
        .input-form button {
            padding: 6px 12px; /* Reduced padding */
            border: none;
            border-radius: 4px; /* Smaller radius */
            background-color: #4CAF50;
            color: white;
            cursor: pointer;
            transition: background-color 0.3s ease;
            font-weight: bold;
            font-size: 14px; /* Reduced font size */
        }
        .input-form button:hover {
            background-color: #45a049;
        }
        .bill {
            max-width: 100%; /* Full width within container */
            margin: 15px auto; /* Reduced margin */
            padding: 15px; /* Reduced padding */
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1); /* Reduced shadow */
        }
        .header-bill, .footer-bill {
            text-align: center;
        }
        .header-bill h2 {
            color: #1a73e8;
            font-size: 20px; /* Reduced font size */
            margin: 0 0 8px; /* Reduced margin */
        }
        .header-bill p {
            color: #666;
            font-size: 12px; /* Reduced font size */
            margin: 0;
        }
        .details, .fare-details {
            font-size: 14px; /* Reduced font size */
            color: #333;
            line-height: 1.4; /* Tighter line spacing */
        }
        .detail-row {
            display: flex;
            justify-content: space-between;
            padding: 8px 0; /* Reduced padding */
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
            font-size: 16px; /* Reduced font size */
            font-weight: bold;
            text-align: right;
            margin-top: 15px; /* Reduced margin */
            padding-top: 8px; /* Reduced padding */
            border-top: 1px solid #eee; /* Thinner border */
        }
        .footer-bill {
            margin-top: 15px; /* Reduced margin */
            font-size: 12px; /* Reduced font size */
            color: #777;
        }
        .no-data, .error-message {
            text-align: center;
            color: #d32f2f;
            font-weight: 500;
            font-size: 14px; /* Reduced font size */
            margin-top: 15px; /* Reduced margin */
        }
        /* Responsive Design */
        @media screen and (max-width: 600px) {
            .container {
                width: 90%;
                padding: 10px; /* Further reduced padding */
            }
            .header h1 {
                font-size: 20px; /* Further reduced font size */
            }
            .input-form input, .input-form button {
                font-size: 12px; /* Further reduced font size */
                padding: 4px; /* Further reduced padding */
            }
            .bill {
                padding: 10px; /* Further reduced padding */
            }
            .header-bill h2 {
                font-size: 18px; /* Further reduced font size */
            }
            .header-bill p, .footer-bill, .details, .fare-details {
                font-size: 12px; /* Further reduced font size */
            }
            .total {
                font-size: 14px; /* Further reduced font size */
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
        String userId = request.getParameter("userId"); // Get userId from request parameter

        // If no userId is provided, show a form to input it
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
                // Validate userId
                userId = userId.trim();

                // Load the JDBC driver
                Class.forName("com.mysql.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/megacitycab?useSSL=false";
                conn = DriverManager.getConnection(url, "root", "Himas123@#");

                // Query the cab_bookings table for all bookings for the specific userId
                String sql = "SELECT id, name, pickup_location, drop_location, car_type, booking_timestamp, status, driver_id, driver_name " +
                             "FROM cab_bookings WHERE userId = ? ORDER BY booking_timestamp DESC";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, userId);
                rs = pstmt.executeQuery();

                boolean hasBookings = false;
                while (rs.next()) {
                    hasBookings = true;
                    int bookingId = rs.getInt("id");
                    String customerName = rs.getString("name");
                    String carType = rs.getString("car_type");
                    String pickupLocation = rs.getString("pickup_location");
                    String dropLocation = rs.getString("drop_location");
                    Timestamp bookingTimestamp = rs.getTimestamp("booking_timestamp");

                    // Generate random distance below 20 km
                    Random random = new Random();
                    double distance = random.nextDouble() * 20; // Random value between 0 and 19.99
                    DecimalFormat df = new DecimalFormat("#.##");
                    String formattedDistance = df.format(distance);

                    // Define currency formatter for LKR amounts
                    DecimalFormat currencyFormatter = new DecimalFormat("#,###.##");

                    // Calculate fare based on car type
                    double ratePerKm = 0;
                    if (carType != null) {
                        if (carType.equalsIgnoreCase("Economic Class Ride") || carType.equalsIgnoreCase("standard")) {
                            ratePerKm = 150;  // 150 LKR/km
                        } else if (carType.equalsIgnoreCase("Executive Class Ride") || carType.equalsIgnoreCase("executive")) {
                            ratePerKm = 500;  // 500 LKR/km
                        } else if (carType.equalsIgnoreCase("Premium Class Ride") || carType.equalsIgnoreCase("premium")) {
                            ratePerKm = 350;  // 350 LKR/km
                        } else {
                            ratePerKm = 0;    // Default to 0 if car type is unknown
                        }
                    }

                    double baseFare = 50; // Base fare
                    double distanceFare = ratePerKm * distance;
                    double totalFare = baseFare + distanceFare;

                    // Format all amounts
                    String formattedBaseFare = currencyFormatter.format(baseFare);
                    String formattedDistanceFare = currencyFormatter.format(distanceFare);
                    String formattedTotalFare = currencyFormatter.format(totalFare);

                    // Format booking timestamp
                    SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
                    String formattedDate = (bookingTimestamp != null) ? sdf.format(bookingTimestamp) : sdf.format(new java.util.Date());
        %>
        <div class="bill">
            <div class="header-bill">
                <h2>Bill for Booking #<%= bookingId %></h2>
                <p>Booking Receipt</p>
            </div>
            <div class="details">
                <div class="detail-row">
                    <span class="label">Booking ID:</span>
                    <span class="value"><%= bookingId %></span>
                </div>
                <div class="detail-row">
                    <span class="label">Date & Time:</span>
                    <span class="value"><%= formattedDate %></span>
                </div>
                <div class="detail-row">
                    <span class="label">Customer Name:</span>
                    <span class="value"><%= customerName != null ? customerName : "N/A" %></span>
                </div>
                <div class="detail-row">
                    <span class="label">Car Type:</span>
                    <span class="value"><%= carType != null ? carType : "N/A" %></span>
                </div>
                <div class="detail-row">
                    <span class="label">Pickup Location:</span>
                    <span class="value"><%= pickupLocation != null ? pickupLocation : "N/A" %></span>
                </div>
                <div class="detail-row">
                    <span class="label">Drop Location:</span>
                    <span class="value"><%= dropLocation != null ? dropLocation : "N/A" %></span>
                </div>
                <div class="detail-row">
                    <span class="label">Distance:</span>
                    <span class="value"><%= formattedDistance %> km</span>
                </div>
            </div>
            <div class="fare-details">
                <h3>Fare Details</h3>
                <div>Base Fare: LKR <%= formattedBaseFare %></div>
                <div>Distance Charge (<%= carType != null ? carType : "N/A" %> @ <%= ratePerKm %> LKR/km × <%= formattedDistance %> km): LKR <%= formattedDistanceFare %></div>
            </div>
            <div class="total">
                Total Amount: LKR <%= formattedTotalFare %>
            </div>
            <div class="footer-bill">
                <p>Thank you for choosing MegaCityCab!</p>
                <p>For any queries, please contact our customer support at support@megacitycab.com</p>
            </div>
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