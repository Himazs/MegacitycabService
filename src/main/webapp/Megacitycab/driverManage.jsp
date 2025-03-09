<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Driver Management</title>
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
            overflow-x: auto; /* Enable horizontal scrolling if table overflows */
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
            max-width: 100%; /* Ensure table doesn't exceed container */
            border-collapse: collapse;
            margin-top: 20px;
            font-size: 16px;
            color: #333;
            table-layout: auto; /* Allow table columns to adjust naturally */
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #f0f0f0;
            white-space: nowrap; /* Prevent text wrapping to keep table compact */
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
            color: #fff;
            border: none;
            padding: 8px 15px;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }
        .remove-btn:hover {
            background-color: #b71c1c;
            transform: scale(1.05);
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
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>MegaCityCab - Driver Management</h1>
        </div>

        <%
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // Use direct JDBC connection
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/megacitycab?useSSL=false";
            conn = DriverManager.getConnection(url, "root", "Himas123@#");

            String sql = "SELECT * FROM drivers";
            pstmt = conn.prepareStatement(sql);
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
                <th>Created At</th>
                <th>NIC</th>
                <th>Action</th>
            </tr>
            <%
                SimpleDateFormat sdf = new SimpleDateFormat("dd MMMM yyyy, HH:mm:ss");
                while (rs.next()) {
                    int driverId = rs.getInt("driver_id");
                    String name = rs.getString("name");
                    String email = rs.getString("email");
                    String address = rs.getString("address");
                    String phoneNumber = rs.getString("phone_number");
                    Timestamp createdAt = rs.getTimestamp("created_at");
                    String nic = rs.getString("nic");
            %>
            <tr>
                <td><%= driverId %></td>
                <td><%= name %></td>
                <td><%= email %></td>
                <td><%= address %></td>
                <td><%= phoneNumber %></td>
                <td><%= createdAt != null ? sdf.format(createdAt) : "" %></td>
                <td><%= nic %></td>
                <td>
                    <form action="removeDriver.jsp" method="post" style="display:inline;">
                        <input type="hidden" name="driverId" value="<%= driverId %>">
                        <button type="submit" class="remove-btn">Remove</button>
                    </form>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <div class="no-data">
                No driver records available at this time.
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
        </table>
    </div>
</body>
</html>