<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>MegaCityCab - Customer Feedback Details</title>
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
            overflow-x: auto;
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
            max-width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            font-size: 16px;
            color: #333;
            table-layout: auto;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #f0f0f0;
            white-space: nowrap;
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
        .no-data {
            text-align: center;
            color: #666;
            font-weight: 500;
            margin-top: 20px;
        }
        .error-message {
            text-align: center;
            color: #d32f2f;
            font-weight: 500;
            margin-top: 20px;
        }
        /* Remove Button Styles */
        .remove-btn {
            background-color: #d32f2f; /* Red color */
            color: white;
            border: none;
            padding: 6px 12px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            transition: background-color 0.3s;
        }
        .remove-btn:hover {
            background-color: #b71c1c; /* Darker red on hover */
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>MegaCityCab - Customer Feedback Details</h1>
        </div>

        <%
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        // Handle deletion request
        String removeId = request.getParameter("removeId");
        if (removeId != null && !removeId.isEmpty()) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/megacitycab?useSSL=false";
                conn = DriverManager.getConnection(url, "root", "Himas123@#");
                
                String deleteSql = "DELETE FROM userfeedback WHERE id = ?";
                pstmt = conn.prepareStatement(deleteSql);
                pstmt.setInt(1, Integer.parseInt(removeId));
                pstmt.executeUpdate();
                
                out.println("<script>alert('Feedback removed successfully!'); window.location.href='feedbackdetail.jsp';</script>");
            } catch (Exception e) {
                out.println("<div class='error-message'>Error deleting feedback: " + e.getMessage() + "</div>");
            } finally {
                try {
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }

        // Display feedback table
        try {
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/megacitycab?useSSL=false";
            conn = DriverManager.getConnection(url, "root", "Himas123@#");

            String sql = "SELECT * FROM userfeedback";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                rs.beforeFirst();
        %>
        <table>
            <tr>
                <th>ID</th>
                <th>Booking ID</th>
                <th>Email</th>
                <th>Rating</th>
                <th>Feedback Text</th>
                <th>Submission Date</th>
                <th>User ID</th>
                <th>Action</th> <!-- Added Action column -->
            </tr>
            <%
                SimpleDateFormat sdf = new SimpleDateFormat("dd MMMM yyyy, HH:mm:ss");
                while (rs.next()) {
                    int id = rs.getInt("id");
                    int bookingId = rs.getInt("booking_id");
                    String email = rs.getString("email");
                    int rating = rs.getInt("rating");
                    String feedbackText = rs.getString("feedback_text");
                    Timestamp submissionDate = rs.getTimestamp("submission_date");
                    String userId = rs.getString("userid");
            %>
            <tr>
                <td><%= id %></td>
                <td><%= bookingId %></td>
                <td><%= email %></td>
                <td><%= rating %></td>
                <td><%= feedbackText %></td>
                <td><%= submissionDate != null ? sdf.format(submissionDate) : "" %></td>
                <td><%= userId %></td>
                <td>
                    <form method="post" action="" onsubmit="return confirm('Are you sure you want to remove this feedback?');">
                        <input type="hidden" name="removeId" value="<%= id %>">
                        <button type="submit" class="remove-btn">Remove</button>
                    </form>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <div class="no-data">
                No feedback records available at this time.
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