<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>MegaCityCab - Feedback Management</title>
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
            margin-top: 20px;
        }

        .box {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
            border: 1px solid #e0e0e0;
        }

        h2 {
            text-align: center;
            color: #1a73e8;
            margin: 0 0 20px 0;
            font-size: 28px;
        }

        .user-title {
            font-size: 18px;
            margin-bottom: 15px;
            color: #555;
            text-align: center;
            font-weight: bold;
        }

        .feedback-card {
            background-color: #f9f9f9;
            padding: 15px;
            margin-bottom: 15px;
            border-radius: 8px;
            border: 1px solid #e0e0e0;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
        }

        .feedback-field {
            margin-bottom: 10px;
            font-size: 16px;
            color: #333;
        }

        .feedback-field label {
            font-weight: bold;
            display: inline-block;
            width: 150px;
        }

        .delete-button {
            background-color: #d32f2f;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 6px;
            font-size: 14px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .delete-button:hover {
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

        .no-data {
            text-align: center;
            color: #666;
            font-weight: 500;
            font-size: 18px;
            padding: 20px;
        }

        .error-message {
            text-align: center;
            color: #d32f2f;
            font-weight: 500;
            font-size: 18px;
            padding: 20px;
        }
    </style>
</head>
<body>
    <%
        String userId = request.getParameter("userid");
        String action = request.getParameter("action");
        String feedbackId = request.getParameter("feedbackId");
        boolean hasUserId = (userId != null && !userId.trim().isEmpty());

        // Handle delete action
        if ("delete".equals(action) && feedbackId != null) {
            Connection conn = null;
            PreparedStatement pstmt = null;
            try {
                // Try modern driver first
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                } catch (ClassNotFoundException e) {
                    // Fallback to older driver
                    Class.forName("com.mysql.jdbc.Driver");
                }
                String url = "jdbc:mysql://localhost:3306/megacitycab?useSSL=false&serverTimezone=UTC";
                conn = DriverManager.getConnection(url, "root", "Himas123@#");
                
                String deleteSql = "DELETE FROM userfeedback WHERE id = ?";
                pstmt = conn.prepareStatement(deleteSql);
                pstmt.setInt(1, Integer.parseInt(feedbackId));
                pstmt.executeUpdate();
                out.println("<div class='error-message'>Feedback deleted successfully.</div>");
            } catch (Exception e) {
                out.println("<div class='error-message'>Error deleting feedback: " + e.getMessage() + "</div>");
            } finally {
                try {
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    out.println("<div class='error-message'>Error closing connection: " + e.getMessage() + "</div>");
                }
            }
        }
    %>

    <% if (!hasUserId) { %>
    <div class="modal-overlay" id="userIdModal">
        <div class="modal-content">
            <div class="modal-title">Enter User ID</div>
            <form action="feedbackmanage.jsp" method="get">
                <input type="text" name="userid" class="modal-input" placeholder="Enter User ID" required autofocus>
                <button type="submit" class="modal-button">View Feedback</button>
            </form>
        </div>
    </div>
    <% } else { %>
    <div class="container">
        <div class="box">
            <h2>MegaCityCab - Feedback Management</h2>
            <div class="user-title">Showing feedback for User ID: <%= userId %></div>

            <%
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
                    // Try modern driver first
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                    } catch (ClassNotFoundException e) {
                        // Fallback to older driver
                        Class.forName("com.mysql.jdbc.Driver");
                    }
                    String url = "jdbc:mysql://localhost:3306/megacitycab?useSSL=false&serverTimezone=UTC";
                    conn = DriverManager.getConnection(url, "root", "Himas123@#");

                    String sql = "SELECT * FROM userfeedback WHERE userid = ? ORDER BY submission_date DESC";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, userId);
                    rs = pstmt.executeQuery();

                    boolean hasFeedback = false;
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

                    while (rs.next()) {
                        hasFeedback = true;
                        int id = rs.getInt("id");
                        String bookingId = rs.getString("booking_id");
                        String email = rs.getString("email");
                        int rating = rs.getInt("rating");
                        String feedbackText = rs.getString("feedback_text");
                        Timestamp submissionDate = rs.getTimestamp("submission_date");
                        String userIdDb = rs.getString("userid");
            %>
            <div class="feedback-card">
                <div class="feedback-field">
                    <label>ID:</label> <%= id %>
                </div>
                <div class="feedback-field">
                    <label>Booking ID:</label> <%= bookingId != null ? bookingId : "N/A" %>
                </div>
                <div class="feedback-field">
                    <label>Email:</label> <%= email != null ? email : "N/A" %>
                </div>
                <div class="feedback-field">
                    <label>Rating:</label> <%= rating %>
                </div>
                <div class="feedback-field">
                    <label>Feedback:</label> <%= feedbackText != null ? feedbackText : "N/A" %>
                </div>
                <div class="feedback-field">
                    <label>Submission Date:</label> <%= submissionDate != null ? sdf.format(submissionDate) : "N/A" %>
                </div>
                <div class="feedback-field">
                    <label>User ID:</label> <%= userIdDb != null ? userIdDb : "N/A" %>
                </div>
                <div class="feedback-field">
                    <form action="feedbackmanage.jsp" method="post" onsubmit="return confirm('Are you sure you want to delete this feedback?');">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="feedbackId" value="<%= id %>">
                        <input type="hidden" name="userid" value="<%= userId %>">
                        <button type="submit" class="delete-button">Delete Feedback</button>
                    </form>
                </div>
            </div>
            <%
                    }
                    if (!hasFeedback) {
            %>
            <div class="no-data">No feedback records available for User ID: <%= userId %></div>
            <%
                    }
                } catch (Exception e) {
                    out.println("<div class='error-message'>Error: " + e.getMessage() + "</div>");
                } finally {
                    try {
                        if (rs != null) rs.close();
                        if (pstmt != null) pstmt.close();
                        if (conn != null) conn.close();
                    } catch (SQLException e) {
                        out.println("<div class='error-message'>Error closing connection: " + e.getMessage() + "</div>");
                    }
                }
            %>
        </div>
    </div>
    <% } %>
</body>
</html>