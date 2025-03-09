<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Car Profile</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-image: url(images/back.png);
        }
        .container {
            width: 80%;
            margin: 0 auto;
        }
        .search-form {
            margin-bottom: 20px;
            padding: 15px;
            background-color: #f5f5f5;
            border-radius: 5px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 8px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        .no-records {
            color: red;
            font-style: italic;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Car Profile</h1>
        
        <div class="search-form">
            <form method="post" action="Carprofile.jsp">
                <label for="driverId">Enter Driver ID:</label>
                <input type="text" name="driverId" id="driverId" required>
                <input type="submit" value="Search">
            </form>
        </div>
        
        <% 
        String driverId = request.getParameter("driverId");
        if(driverId != null && !driverId.trim().isEmpty()) {
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            
            try {
                // Update these connection details as per your database configuration
                String jdbcURL = "jdbc:mysql://localhost:3306/megacitycab?useSSL=false";
                String dbUser = "root";
                String dbPassword = "Himas123@#";
                
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
                
                String sql = "SELECT * FROM megacitycab.car_new WHERE driver_id = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, driverId);
                
                rs = pstmt.executeQuery();
                
                if(rs.next()) {
        %>
                <h2>Car Details for Driver ID: <%= driverId %></h2>
                <table>
                    <tr>
                        <th>ID</th>
                        <th>Make</th>
                        <th>Model</th>
                        <th>Year</th>
                        <th>License Plate</th>
                        <th>Color</th>
                        <th>Seats</th>
                        <th>Created At</th>
                    </tr>
                    <% do { %>
                    <tr>
                        <td><%= rs.getInt("id") %></td>
                        <td><%= rs.getString("make") != null ? rs.getString("make") : "N/A" %></td>
                        <td><%= rs.getString("model") != null ? rs.getString("model") : "N/A" %></td>
                        <td><%= rs.getInt("year") != 0 ? rs.getInt("year") : "N/A" %></td>
                        <td><%= rs.getString("license_plate") != null ? rs.getString("license_plate") : "N/A" %></td>
                        <td><%= rs.getString("color") != null ? rs.getString("color") : "N/A" %></td>
                        <td><%= rs.getInt("seats") != 0 ? rs.getInt("seats") : "N/A" %></td>
                        <td><%= rs.getTimestamp("created_at") != null ? rs.getTimestamp("created_at") : "N/A" %></td>
                    </tr>
                    <% } while(rs.next()); %>
                </table>
        <%
                } else {
        %>
                <p class="no-records">No cars found for Driver ID: <%= driverId %></p>
        <%
                }
            } catch(Exception e) {
                out.println("<p class='no-records'>Error: " + e.getMessage() + "</p>");
            } finally {
                try { if(rs != null) rs.close(); } catch(Exception e) {}
                try { if(pstmt != null) pstmt.close(); } catch(Exception e) {}
                try { if(conn != null) conn.close(); } catch(Exception e) {}
            }
        }
        %>
    </div>
</body>
</html>