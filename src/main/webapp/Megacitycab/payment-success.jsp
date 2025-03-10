<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Payment Successful</title>
    <style>
        body { font-family: 'Segoe UI', Arial, sans-serif; text-align: center; padding: 50px; }
        .message { color: #4CAF50; font-size: 24px; margin-bottom: 20px; }
        .details { font-size: 16px; color: #333; }
        a { color: #1a73e8; text-decoration: none; }
        a:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <div class="message">Payment Successful!</div>
    <div class="details">
        <p>Booking ID: <%= request.getParameter("bookingId") %></p>
        <p>Total Amount Paid: LKR <%= request.getParameter("totalFare") %></p>
        <p>User ID: <%= request.getParameter("userId") %></p>
        <p><a href="userDashboard.jsp">Return to Dashboard</a></p>
    </div>

    <% 
        // Retrieve booking details from the database based on bookingId
        String bookingId = request.getParameter("bookingId");
        String userId = request.getParameter("userId");
        String phoneNumber = null;

        // Database connection (example, replace with your actual DB configuration)
        String url = "jdbc:mysql://localhost:3306/megacitycab";
        String dbUser = "your_username";
        String dbPassword = "your_password";

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(url, dbUser, dbPassword);
            String sql = "SELECT phone FROM cab_bookings WHERE id = ?";
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, bookingId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                phoneNumber = rs.getString("phone");
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Send SMS (placeholder logic - integrate with an SMS API like Twilio)
        if (phoneNumber != null) {
            String message = "Payment Successful! Booking ID: " + bookingId + ", Amount Paid: LKR " + request.getParameter("totalFare");
            // Example Twilio integration (replace with actual API call)
            // TwilioRestClient client = new TwilioRestClient("your_account_sid", "your_auth_token");
            // Message message = Message.creator(
            //     new PhoneNumber(phoneNumber),
            //     new PhoneNumber("your_twilio_number"),
            //     message
            // ).create();
            out.println("<p>SMS sent to " + phoneNumber + " with payment confirmation.</p>");
        } else {
            out.println("<p>Could not retrieve phone number for SMS.</p>");
        }
    %>
</body>
</html>