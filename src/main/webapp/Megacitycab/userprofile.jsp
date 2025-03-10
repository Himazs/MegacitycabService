<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>MegaCityCab - User Profile</title>
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            margin: 0;
            background-image: url(images/back.png);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-color: #f4f7fa;
        }
        .container {
            max-width: 600px;
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            border: 1px solid #e0e0e0;
        }
        .header {
            text-align: center;
            padding-bottom: 10px;
            border-bottom: 1px solid #e8ecef;
        }
        .header h1 {
            color: #1a73e8;
            font-size: 22px;
            margin: 0;
        }
        .header p {
            color: #666;
            font-size: 14px;
            margin: 5px 0 0;
        }
        .profile-card {
            background-color: #f9f9f9;
            border: 1px solid #e0e0e0;
            border-radius: 5px;
            padding: 15px;
            margin-top: 20px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
        }
        .profile-field {
            display: flex;
            flex-direction: column;
            margin-bottom: 10px;
        }
        .profile-field label {
            font-weight: 600;
            color: #333;
            margin-bottom: 3px;
            font-size: 12px;
        }
        .profile-field input[type="text"],
        .profile-field input[type="email"] {
            padding: 5px;
            border: 1px solid #ddd;
            border-radius: 3px;
            font-size: 12px;
            width: 100%;
            max-width: 300px;
            transition: border-color 0.3s ease;
        }
        .profile-field input[type="text"]:focus,
        .profile-field input[type="email"]:focus {
            border-color: #1a73e8;
            outline: none;
        }
        .profile-field span {
            padding: 5px;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 3px;
            font-size: 12px;
            word-wrap: break-word;
        }
        .save-button {
            padding: 6px 12px;
            border: none;
            border-radius: 3px;
            background-color: #1a73e8;
            color: white;
            cursor: pointer;
            transition: background-color 0.3s ease;
            font-size: 12px;
            margin-top: 10px;
            width: 100%;
            max-width: 150px;
        }
        .save-button:hover {
            background-color: #0d62c9;
        }
        .search-form {
            margin: 10px 0;
            text-align: center;
            display: none;
        }
        .search-form.active {
            display: block;
        }
        .search-form input {
            padding: 6px;
            width: 150px;
            border: 1px solid #ddd;
            border-radius: 3px;
            font-size: 14px;
        }
        .search-form button {
            padding: 6px 12px;
            background-color: #1a73e8;
            color: white;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            font-size: 14px;
            margin-left: 5px;
        }
        .search-form button:hover {
            background-color: #0d62c9;
        }
        .message {
            text-align: center;
            color: #2e7d32;
            font-weight: 500;
            margin-top: 10px;
            font-size: 14px;
        }
        .error-message {
            text-align: center;
            color: #d32f2f;
            font-weight: 500;
            margin-top: 10px;
            font-size: 14px;
        }
        .no-data {
            text-align: center;
            color: #666;
            font-weight: 500;
            margin-top: 10px;
            font-size: 14px;
        }
        @media screen and (max-width: 600px) {
            .container {
                width: 90%;
                padding: 15px;
            }
            .profile-card {
                padding: 10px;
            }
            .profile-field label, .profile-field input, .profile-field span {
                font-size: 10px;
            }
            .save-button {
                padding: 4px 10px;
                font-size: 10px;
            }
            .search-form input {
                width: 120px;
                padding: 4px;
                font-size: 12px;
            }
            .search-form button {
                padding: 4px 10px;
                font-size: 12px;
            }
            .header h1 {
                font-size: 18px;
            }
            .header p {
                font-size: 12px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>MegaCityCab - My Profile</h1>
            <p>View and update your profile information</p>
        </div>

        <%
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String userId = request.getParameter("userId");
        boolean showSearchForm = false;

        if (userId == null || userId.trim().isEmpty()) {
            showSearchForm = true;
        } else {
            try {
                int id = Integer.parseInt(userId.trim());
                Class.forName("com.mysql.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/megacitycab?useSSL=false";
                conn = DriverManager.getConnection(url, "root", "Himas123@#");

                String sql = "SELECT * FROM users WHERE user_id = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, id);
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    // Access data directly after rs.next()
                    int userIdFromDb = rs.getInt("user_id");
                    String name = rs.getString("name");
                    String email = rs.getString("email");
                    String address = rs.getString("address");
                    String phoneNumber = rs.getString("phone_number");
                    String role = rs.getString("role");
                    Timestamp createdAt = rs.getTimestamp("created_at");
                    String nic = rs.getString("nic");
                    String message = request.getParameter("message");
        %>
        <div class="profile-card">
            <form method="post" action="UserProfile.jsp">
                <input type="hidden" name="userId" value="<%= userId %>">
                <div class="profile-field">
                    <label>User ID:</label>
                    <span><%= userIdFromDb %></span>
                </div>
                <div class="profile-field">
                    <label>Full Name:</label>
                    <span><%= name != null ? name : "N/A" %></span>
                </div>
                <div class="profile-field">
                    <label>Email Address:</label>
                    <input type="email" name="email" value="<%= email != null ? email : "" %>" required>
                </div>
                <div class="profile-field">
                    <label>Address:</label>
                    <span><%= address != null ? address : "N/A" %></span>
                </div>
                <div class="profile-field">
                    <label>Phone Number:</label>
                    <input type="text" name="phone_number" value="<%= phoneNumber != null ? phoneNumber : "" %>" required>
                </div>
                <div class="profile-field">
                    <label>Role:</label>
                    <span><%= role != null ? role : "N/A" %></span>
                </div>
                <div class="profile-field">
                    <label>Account Created:</label>
                    <span><%= createdAt != null ? new SimpleDateFormat("dd MMMM yyyy, HH:mm:ss").format(createdAt) : "" %></span>
                </div>
                <div class="profile-field">
                    <label>NIC:</label>
                    <span><%= nic != null ? nic : "N/A" %></span>
                </div>
                <button type="submit" class="save-button">Save Changes</button>
            </form>
        </div>
        <%
                    if (message != null && message.equals("success")) {
        %>
        <div class="message">
            Profile updated successfully!
        </div>
        <%
                    }
                } else {
                    showSearchForm = true;
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
                showSearchForm = true;
            } catch (Exception e) {
        %>
        <div class="error-message">
            An error occurred: <%= e.getMessage() %>
        </div>
        <%
                showSearchForm = true;
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }

        // Handle save action
        if (request.getMethod().equals("POST") && userId != null && !userId.trim().isEmpty()) {
            String newEmail = request.getParameter("email");
            String newPhoneNumber = request.getParameter("phone_number");
            try {
                int id = Integer.parseInt(userId.trim());
                Class.forName("com.mysql.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/megacitycab?useSSL=false";
                conn = DriverManager.getConnection(url, "root", "Himas123@#");

                String updateSql = "UPDATE users SET email = ?, phone_number = ? WHERE user_id = ?";
                pstmt = conn.prepareStatement(updateSql);
                pstmt.setString(1, newEmail);
                pstmt.setString(2, newPhoneNumber);
                pstmt.setInt(3, id);
                int rowsAffected = pstmt.executeUpdate();

                if (rowsAffected > 0) {
                    response.sendRedirect("UserProfile.jsp?userId=" + userId + "&message=success");
                } else {
        %>
        <div class="error-message">
            Failed to update profile details.
        </div>
        <%
                }
            } catch (Exception e) {
        %>
        <div class="error-message">
            An error occurred while saving: <%= e.getMessage() %>
        </div>
        <%
            } finally {
                try {
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }

        if (showSearchForm) {
        %>
        <div class="search-form active">
            <form method="get" action="UserProfile.jsp">
                <input type="text" name="userId" placeholder="Enter User ID" required />
                <button type="submit">View Profile</button>
            </form>
        </div>
        <div class="no-data">
            Please enter your User ID to view or edit your profile.
        </div>
        <%
        }
        %>
    </div>
</body>
</html>