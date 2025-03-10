<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
</body>
</html>