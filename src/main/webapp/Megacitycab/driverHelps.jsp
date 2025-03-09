<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <title>Driver Help Details</title>
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
    </style>
</head>
<body>
    <div class="container">
        <div class="box">
            <h2>Driver Help Table Details</h2>
            <table>
                <tr>
                    <th>ID</th>
                    <th>Issue</th>
                    <th>Description</th>
                    <th>Submission Timestamp</th>
                    <th>Action</th>
                </tr>
                <%
                    String url = "jdbc:mysql://localhost:3306/megacitycab";
                    String username = "root";
                    String password = "Himas123@#";
                    
                    Connection conn = null;
                    Statement stmt = null;
                    ResultSet rs = null;
                    
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection(url, username, password);
                        stmt = conn.createStatement();
                        String sql = "SELECT * FROM driverhelp";
                        rs = stmt.executeQuery(sql);
                        
                        while (rs.next()) {
                            int id = rs.getInt("id");
                            String issue = rs.getString("issue") != null ? rs.getString("issue") : "";
                            String description = rs.getString("description") != null ? rs.getString("description") : "";
                            Timestamp submissionTimestamp = rs.getTimestamp("submission_timestamp");
                %>
                <tr>
                    <td><%= id %></td>
                    <td><%= issue %></td>
                    <td><%= description %></td>
                    <td><%= (submissionTimestamp != null) ? submissionTimestamp : "" %></td>
                    <td>
                        <form action="removeDriverHelp.jsp" method="post" onsubmit="return confirm('Are you sure you want to remove this record?');">
                            <input type="hidden" name="id" value="<%= id %>">
                            <button type="submit" class="remove-btn">Remove</button>
                        </form>
                    </td>
                </tr>
                <%
                        }
                    } catch (Exception e) {
                        out.println("<tr><td colspan='5' class='error-message'>Error: " + e.getMessage() + "</td></tr>");
                    } finally {
                        try {
                            if (rs != null) rs.close();
                            if (stmt != null) stmt.close();
                            if (conn != null) conn.close();
                        } catch (SQLException e) {
                            out.println("<tr><td colspan='5' class='error-message'>Error closing connection: " + e.getMessage() + "</td></tr>");
                        }
                    }
                %>
            </table>
        </div>
    </div>
</body>
</html>
