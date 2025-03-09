<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.SimpleDateFormat, java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>MegaCityCab - Driver Profile</title>
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
            max-width: 500px;
            background: linear-gradient(to right, #ff9100, #ffffff); 
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            border: 1px solid #e0e0e0;
        }
        .header {
            text-align: center;
            padding-bottom: 20px;
            border-bottom: 2px solid #f5f5f5;
        }
        .header h1 {
            color: #bc0000;
            font-size: 28px;
            margin: 0;
        }
        .header p {
            color: #000000;
            font-size: 14px;
            margin: 5px 0 0;
        }
        .profile-details {
            margin-top: 20px;
            font-size: 16px;
            color: #ffffff;
        }
        .detail-row {
            display: flex;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #f0f0f0;
        }
        .detail-row:last-child {
            border-bottom: none;
        }
        .label {
            font-weight: 600;
            color: #ffffff;
            flex: 1;
        }
        .value {
            flex: 2;
            text-align: left;
            color: #000000;
        }
        .error-message, .no-data {
            text-align: center;
            color: #d32f2f;
            font-weight: 500;
            margin-top: 20px;
        }
        .search-form {
            margin: 20px 0;
            text-align: center;
        }
        .search-form input {
            padding: 10px;
            width: 200px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
        }
        .search-form button {
            padding: 10px 20px;
            background-color: #bc0000;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin-left: 10px;
        }
        .search-form button:hover {
            background-color: #a10000;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <div style="display: flex; align-items: center; justify-content: center;">
                <img src="images/dr.png" alt="Driver Icon" style="width: 100px; height: 100px; margin-right: 10px;"><br>
            </div>
            <h1>MegaCityCab</h1>
            <p>Driver Profile Dashboard</p>
        </div>
        
        <div class="search-form">
            <form method="post" action="">
                <input type="text" name="driverId" placeholder="Enter Driver ID" required />
                <button type="submit">Search</button>
            </form>
        </div>
        
        <%
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String driverId = request.getParameter("driverId");
        
        if (driverId != null && !driverId.trim().isEmpty()) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/megacitycab?useSSL=false";
                conn = DriverManager.getConnection(url, "root", "Himas123@#");

                String sql = "SELECT * FROM drivers WHERE driver_id = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, Integer.parseInt(driverId));
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    int id = rs.getInt("driver_id");
                    String name = rs.getString("name");
                    String email = rs.getString("email");
                    String address = rs.getString("address");
                    String phone = rs.getString("phone_number");
                    String nic = rs.getString("nic");
        %>
        <div class="profile-details">
            <div class="detail-row">
                <span class="label">Driver ID:</span>
                <span class="value"><%= id %></span>
            </div>
            <div class="detail-row">
                <span class="label">Name:</span>
                <span class="value"><%= name %></span>
            </div>
            <div class="detail-row">
                <span class="label">Email:</span>
                <span class="value"><%= email %></span>
            </div>
            <div class="detail-row">
                <span class="label">Address:</span>
                <span class="value"><%= address %></span>
            </div>
            <div class="detail-row">
                <span class="label">Phone Number:</span>
                <span class="value"><%= phone %></span>
            </div>
            <div class="detail-row">
                <span class="label">NIC:</span>
                <span class="value"><%= nic %></span>
            </div>
        </div>
        <%
                } else {
        %>
        <div class="no-data">
            No driver found with ID: <%= driverId %>
        </div>
        <%
                }
            } catch (NumberFormatException e) {
        %>
        <div class="error-message">
            Invalid driver ID format. Please enter a valid number.
        </div>
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
                }
            }
        } else if (request.getMethod().equals("POST")) {
            // This handles the case where the form was submitted but driverId was empty
        %>
        <div class="error-message">
            Please enter a valid Driver ID.
        </div>
        <%
        }
        %>
    </div>
</body>
</html>