<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <title>User Help Details</title>
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
            max-width: 1200px;
            background-color: #ffd898;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            border: 1px solid #e0e0e0;
            overflow-x: auto;
            margin-top: 20px;
        }

        .box {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            border: 1px solid #e0e0e0;
            overflow-x: auto;
        }

        h2 {
            text-align: center;
            color: #1a73e8;
            margin: 0 0 20px 0;
            font-size: 28px;
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

        .remove-btn {
            background-color: #d32f2f;
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
        }
        
        .remove-btn:hover {
            background-color: #b71c1c;
        }

        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 1000;
        }

        .modal-content {
            background-color: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
            width: 400px;
            text-align: center;
        }

        .modal-title {
            font-size: 24px;
            margin-bottom: 20px;
            color: #1a73e8;
        }

        .modal-input {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 16px;
            box-sizing: border-box;
        }

        .modal-button {
            background-color: #1a73e8;
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .modal-button:hover {
            background-color: #0d5bdd;
        }

        .user-title {
            font-size: 18px;
            margin-bottom: 15px;
            color: #555;
            text-align: center;
            font-weight: bold;
        }

        .no-data {
            text-align: center;
            font-style: italic;
            color: #888;
        }

        .error-message {
            color: red;
            text-align: center;
        }
    </style>
</head>
<body>
    <%
        String userId = request.getParameter("userid");
        boolean hasUserId = (userId != null && !userId.trim().isEmpty());
    %>

    <% if (!hasUserId) { %>
    <div class="modal-overlay" id="userIdModal">
        <div class="modal-content">
            <div class="modal-title">Enter User ID</div>
            <form action="userHelp.jsp" method="get">
                <input type="text" name="userid" class="modal-input" placeholder="Enter User ID" required autofocus>
                <button type="submit" class="modal-button">View Details</button>
            </form>
        </div>
    </div>
    <% } else { %>
    <div class="container">
        <div class="box">
            <h2>User Help Table Details</h2>
            <div class="user-title">Showing help requests for User ID: <%= userId %></div>
            
            <table>
                <tr>
                    <th>ID</th>
                    <th>Booking ID</th>
                    <th>Issue Type</th>
                    <th>Submission Timestamp</th>
                    <th>User ID</th>
                    <th>Action</th>
                </tr>
                <%
                    String url = "jdbc:mysql://localhost:3306/megacitycab";
                    String username = "root";
                    String password = "Himas123@#";
                    
                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;
                    
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection(url, username, password);
                        
                        String sql = "SELECT * FROM userhelp WHERE userid = ?";
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setString(1, userId);
                        rs = pstmt.executeQuery();
                        
                        boolean hasData = false;
                        while (rs.next()) {
                            hasData = true;
                            int id = rs.getInt("id");
                            int bookingId = rs.getInt("booking_id");
                            String issueType = rs.getString("issue_type") != null ? rs.getString("issue_type") : "";
                            Timestamp submissionTimestamp = rs.getTimestamp("submission_timestamp");
                            String userIdDb = rs.getString("userid") != null ? rs.getString("userid") : "";
                %>
                <tr>
                    <td><%= id %></td>
                    <td><%= bookingId %></td>
                    <td><%= issueType %></td>
                    <td><%= (submissionTimestamp != null) ? submissionTimestamp : "" %></td>
                    <td><%= userIdDb %></td>
                    <td>
                        <form action="removeUserHelp.jsp" method="post" onsubmit="return confirm('Are you sure you want to remove this record?');">
                            <input type="hidden" name="id" value="<%= id %>">
                            <button type="submit" class="remove-btn">Remove</button>
                        </form>
                    </td>
                </tr>
                <%
                        }
                        if (!hasData) {
                %>
                <tr>
                    <td colspan="6" class="no-data">No user help records available for User ID: <%= userId %></td>
                </tr>
                <%
                        }
                    } catch (Exception e) {
                        out.println("<tr><td colspan='6' class='error-message'>Error: " + e.getMessage() + "</td></tr>");
                    } finally {
                        try {
                            if (rs != null) rs.close();
                            if (pstmt != null) pstmt.close();
                            if (conn != null) conn.close();
                        } catch (SQLException e) {
                            out.println("<tr><td colspan='6' class='error-message'>Error closing connection: " + e.getMessage() + "</td></tr>");
                        }
                    }
                %>
            </table>

            <div style="text-align: center; margin-top: 20px;">
                <a href=http://localhost:8080/Citycab/Megacitycab/usersHelp.jsp" style="display: inline-block; padding: 10px 20px; background-color: #1a73e8; color: white; text-decoration: none; border-radius: 6px;">Enter Different User ID</a>
            </div>
        </div>
    </div>
    <% } %>
</body>
</html>
