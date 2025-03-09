<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.SimpleDateFormat, java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>MegaCityCab - Booking Dashboard</title>
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
            max-width: 800px;
            background: linear-gradient(to right, #ffd407, #ffffff);
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            border: 1px solid #e0e0e0;
            position: relative;
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
        .booking-carousel {
            position: relative;
            margin-top: 20px;
            overflow: hidden;
            min-height: 300px;
        }
        .booking-row {
            display: none;
            padding: 15px;
            background-color: #fff;
            border-radius: 8px;
            margin-bottom: 10px;
        }
        .active-booking {
            display: block;
        }
        .booking-info {
            margin-bottom: 20px;
        }
        .detail-row {
            margin-bottom: 8px;
        }
        .label {
            font-weight: bold;
            display: inline-block;
            width: 150px;
        }
        .value {
            display: inline-block;
        }
        .buttons {
            display: flex;
            gap: 10px;
            justify-content: center;
            margin-top: 20px;
        }
        .accept-btn, .reject-btn {
            padding: 8px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            color: white;
            transition: background-color 0.3s ease;
            font-weight: bold;
        }
        .accept-btn {
            background-color: #4CAF50; /* Green */
        }
        .reject-btn {
            background-color: #f44336; /* Red */
        }
        .accept-btn:hover, .reject-btn:hover {
            opacity: 0.9;
        }
        .status {
            font-weight: 600;
            color: #4CAF50; /* Green for accepted */
        }
        .pending {
            color: #ff9800; /* Orange for pending */
        }
        .rejected {
            color: #f44336; /* Red for rejected */
        }
        .error-message, .no-data {
            text-align: center;
            color: #d32f2f;
            font-weight: 500;
            margin-top: 20px;
        }
        .navigation {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }
        .nav-button {
            background-color: #1a73e8;
            color: white;
            border: none;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            display: flex;
            justify-content: center;
            align-items: center;
            cursor: pointer;
            font-size: 20px;
            transition: background-color 0.3s;
        }
        .nav-button:hover {
            background-color: #0d5bbd;
        }
        .booking-counter {
            text-align: center;
            margin-top: 10px;
            color: #666;
            font-size: 14px;
        }
        /* Modal for accepting booking */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 1000;
        }
        .modal-content {
            background-color: #fff;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            width: 80%;
            max-width: 400px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }
        .modal-content h3 {
            color: #1a73e8;
            margin-bottom: 20px;
        }
        .modal-content input {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #e0e0e0;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .modal-buttons {
            display: flex;
            gap: 10px;
            justify-content: center;
        }
        .modal-accept-btn, .modal-cancel-btn {
            padding: 8px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            color: white;
            font-weight: bold;
            transition: opacity 0.3s ease;
        }
        .modal-accept-btn {
            background-color: #4CAF50; /* Green */
        }
        .modal-cancel-btn {
            background-color: #f44336; /* Red */
        }
        .modal-accept-btn:hover, .modal-cancel-btn:hover {
            opacity: 0.9;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>MegaCityCab</h1>
            <p>Booking Dashboard</p>
        </div>

        <%
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/megacitycab?useSSL=false";
            conn = DriverManager.getConnection(url, "root", "Himas123@#");

            String sql = "SELECT * FROM cab_bookings ORDER BY booking_timestamp DESC";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            boolean hasBookings = false;
            int totalBookings = 0;
        %>
        <div class="booking-carousel" id="bookingCarousel">
            <%
            while (rs.next()) {
                hasBookings = true;
                totalBookings++;
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String phone = rs.getString("phone");
                String pickupLocation = rs.getString("pickup_location");
                String dropLocation = rs.getString("drop_location");
                String carType = rs.getString("car_type");
                Timestamp bookingTimestamp = rs.getTimestamp("booking_timestamp");
                String status = rs.getString("status");
                String driverId = rs.getString("driver_id"); // Fetch driver_id
                String driverName = rs.getString("driver_name"); // Fetch driver_name
                String formattedTimestamp = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(bookingTimestamp);
                String statusClass = "";
                if ("accepted".equals(status)) {
                    statusClass = "status";
                } else if ("pending".equals(status)) {
                    statusClass = "pending";
                } else if ("rejected".equals(status)) {
                    statusClass = "rejected";
                }
                
                String activeClass = totalBookings == 1 ? "active-booking" : "";
            %>
            <div class="booking-row <%= activeClass %>" data-booking-id="<%= id %>">
                <div class="booking-info">
                    <div class="detail-row">
                        <span class="label">Booking ID:</span>
                        <span class="value"><%= id %></span>
                    </div>
                    <div class="detail-row">
                        <span class="label">Customer Name:</span>
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
                        <span class="value <%= statusClass %>"><%= status %></span>
                    </div>
                    <% if ("accepted".equals(status) && driverId != null && driverName != null) { %>
                    <div class="detail-row">
                        <span class="label">Driver ID:</span>
                        <span class="value"><%= driverId %></span>
                    </div>
                    <div class="detail-row">
                        <span class="label">Driver Name:</span>
                        <span class="value"><%= driverName %></span>
                    </div>
                    <% } %>
                </div>
                <div class="buttons">
                    <% if ("pending".equals(status)) { %>
                        <button class="accept-btn" onclick="showAcceptModal(<%= id %>)">Accept</button>
                        <button class="reject-btn" onclick="rejectBooking(<%= id %>)">Reject</button>
                    <% } %>
                </div>
            </div>
            <%
            }
            if (hasBookings) {
            %>
            <div class="navigation">
                <button class="nav-button" id="prevButton">←</button>
                <button class="nav-button" id="nextButton">→</button>
            </div>
            <div class="booking-counter" id="bookingCounter">
                Booking 1 of <%= totalBookings %>
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
    </div>

    <!-- Modal for accepting booking -->
    <div id="acceptModal" class="modal">
        <div class="modal-content">
            <h3>Accept Booking</h3>
            <form id="acceptForm" action="UpdateBookingStatus.jsp" method="post">
                <input type="hidden" name="bookingId" id="modalBookingId">
                <input type="hidden" name="status" value="accepted">
                <div>
                    <label for="driverId">Driver ID:</label>
                    <input type="text" id="driverId" name="driverId" required>
                </div>
                <div>
                    <label for="driverName">Driver Name:</label>
                    <input type="text" id="driverName" name="driverName" required>
                </div>
                <div class="modal-buttons">
                    <button type="submit" class="modal-accept-btn">Confirm Accept</button>
                    <button type="button" class="modal-cancel-btn" onclick="closeModal()">Cancel</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        // Navigation logic for booking carousel
        let currentIndex = 0;
        const bookings = document.querySelectorAll('.booking-row');
        const totalBookings = bookings.length;
        const counter = document.getElementById('bookingCounter');
        
        function showBooking(index) {
            bookings.forEach(booking => {
                booking.classList.remove('active-booking');
            });
            
            if (bookings[index]) {
                bookings[index].classList.add('active-booking');
                counter.textContent = `Booking ${index + 1} of ${totalBookings}`;
            }
        }
        
        document.getElementById('prevButton').addEventListener('click', function() {
            currentIndex = (currentIndex - 1 + totalBookings) % totalBookings;
            showBooking(currentIndex);
        });
        
        document.getElementById('nextButton').addEventListener('click', function() {
            currentIndex = (currentIndex + 1) % totalBookings;
            showBooking(currentIndex);
        });
        
        function showAcceptModal(bookingId) {
            document.getElementById('modalBookingId').value = bookingId;
            document.getElementById('acceptModal').style.display = 'block';
        }

        function closeModal() {
            document.getElementById('acceptModal').style.display = 'none';
            document.getElementById('acceptForm').reset();
        }

        function rejectBooking(bookingId) {
            if (confirm("Are you sure you want to reject this booking?")) {
                // Use AJAX to send the request to update the status
                fetch('UpdateBookingStatus.jsp?bookingId=' + encodeURIComponent(bookingId) + '&status=rejected', {
                    method: 'GET'
                })
                .then(response => response.text())
                .then(data => {
                    alert(data); // Show response from the JSP (e.g., "Booking rejected successfully")
                    location.reload(); // Refresh the page to show the updated status
                })
                .catch(error => {
                    alert("Error updating booking: " + error);
                });
            }
        }

        // Prevent form submission if fields are empty
        document.getElementById('acceptForm').addEventListener('submit', function(e) {
            const driverId = document.getElementById('driverId').value.trim();
            const driverName = document.getElementById('driverName').value.trim();
            if (!driverId || !driverName) {
                e.preventDefault();
                alert("Please enter both Driver ID and Driver Name.");
                return false;
            }
        });
    </script>
</body>
</html>