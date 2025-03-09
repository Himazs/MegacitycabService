<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Management</title>
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
            max-width: 1000px;
            background-color: #ffffff;
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
            color: #1a73e8;
            font-size: 28px;
            margin: 0;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            font-size: 16px;
            color: #333;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #f0f0f0;
        }
        th {
            background-color: #ffd407;
            color: #000;
            font-weight: 600;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        .message {
            text-align: center;
            color: #2e7d32;
            font-weight: 500;
            margin-top: 20px;
        }
        .error-message {
            text-align: center;
            color: #d32f2f;
            font-weight: 500;
            margin-top: 20px;
        }
        .no-data {
            text-align: center;
            color: #666;
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
            background-color: #1a73e8;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            margin-left: 10px;
        }
        .search-form button:hover {
            background-color: #0d62c9;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>MegaCityCab - User Management</h1>
        </div>

        <div class="search-form">
            <form method="post" action="">
                <input type="text" name="userId" placeholder="Enter User ID" required />
                <button type="submit">Search</button>
            </form>
        </div>

        <%
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String userId = request.getParameter("userId");

        if (userId != null && !userId.trim().isEmpty()) {
            try {
                // Use direct JDBC connection
                Class.forName("com.mysql.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/megacitycab?useSSL=false";
                conn = DriverManager.getConnection(url, "root", "Himas123@#");

                String sql = "SELECT * FROM users WHERE user_id = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, Integer.parseInt(userId));
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    // Move cursor back to the beginning
                    rs.beforeFirst();
        %>
        <table>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Address</th>
                <th>Phone Number</th>
                <th>Role</th>
                <th>Created At</th>
                <th>NIC</th>
            </tr>
            <%
                    SimpleDateFormat sdf = new SimpleDateFormat("dd MMMM yyyy, HH:mm:ss");
                    while (rs.next()) {
                        int id = rs.getInt("user_id");
                        String name = rs.getString("name");
                        String email = rs.getString("email");
                        String address = rs.getString("address");
                        String phoneNumber = rs.getString("phone_number");
                        String role = rs.getString("role");
                        Timestamp createdAt = rs.getTimestamp("created_at");
                        String nic = rs.getString("nic");
            %>
            <tr>
                <td><%= id %></td>
                <td><%= name %></td>
                <td><%= email %></td>
                <td><%= address %></td>
                <td><%= phoneNumber %></td>
                <td><%= role %></td>
                <td><%= createdAt != null ? sdf.format(createdAt) : "" %></td>
                <td><%= nic %></td>
            </tr>
            <%
                    }
                } else {
            %>
            <div class="no-data">
                No user found with ID: <%= userId %>
            </div>
            <%
                }
            } catch (NumberFormatException e) {
            %>
            <div class="error-message">
                Invalid user ID format. Please enter a valid number.
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
            // This handles the case where the form was submitted but userId was empty
        %>
            <div class="error-message">
                Please enter a valid User ID.
            </div>
        <%
        }
        %>
    </div>
</body>
</html>