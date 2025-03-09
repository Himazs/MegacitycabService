<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Remove User</title>
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
            max-width: 600px;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            border: 1px solid #e0e0e0;
            text-align: center;
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
        .message {
            margin: 20px 0;
            padding: 15px;
            border-radius: 8px;
            font-size: 16px;
        }
        .success {
            background-color: #e8f5e9;
            color: #2e7d32;
            border: 1px solid #c8e6c9;
        }
        .error {
            background-color: #ffebee;
            color: #c62828;
            border: 1px solid #ffcdd2;
        }
        .btn {
            display: inline-block;
            background-color: #1a73e8;
            color: #fff;
            padding: 10px 20px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 500;
            margin-top: 20px;
            transition: background-color 0.3s ease;
        }
        .btn:hover {
            background-color: #1565c0;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>MegaCityCab - Remove User</h1>
        </div>

        <%
        Connection conn = null;
        PreparedStatement pstmt = null;
        boolean success = false;
        String errorMessage = "";

        try {
            // Get the user ID from the request
            String userIdStr = request.getParameter("userId");
            
            if (userIdStr != null && !userIdStr.trim().isEmpty()) {
                int userId = Integer.parseInt(userIdStr);

                // Database connection
                Class.forName("com.mysql.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/megacitycab?useSSL=false";
                conn = DriverManager.getConnection(url, "root", "Himas123@#");

                // SQL to delete the user record
                String sql = "DELETE FROM users WHERE user_id = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, userId);

                // Execute the delete
                int rowsAffected = pstmt.executeUpdate();
                
                if (rowsAffected > 0) {
                    success = true;
                } else {
                    errorMessage = "No user found with ID: " + userId;
                }
            } else {
                errorMessage = "Invalid user ID provided";
            }
        } catch (NumberFormatException e) {
            errorMessage = "Invalid user ID format";
        } catch (Exception e) {
            errorMessage = "An error occurred: " + e.getMessage();
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        %>

        <% if (success) { %>
            <div class="message success">
                User has been successfully removed from the system.
            </div>
        <% } else { %>
            <div class="message error">
                <%= errorMessage %>
            </div>
        <% } %>

        <a href="userManage.jsp" class="btn">Back to User Management</a>
    </div>
</body>
</html>