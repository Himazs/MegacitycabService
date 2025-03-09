<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    String message = null;
    String messageType = "success"; // Can be "success" or "error"

    try {
        // Load the MySQL JDBC driver
        Class.forName("com.mysql.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/megacitycab?useSSL=false";
        conn = DriverManager.getConnection(url, "root", "Himas123@#");

        // Get the contact ID from the request
        int contactId = Integer.parseInt(request.getParameter("contactId"));

        // Prepare the DELETE SQL query
        String sql = "DELETE FROM contact WHERE id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, contactId);

        // Execute the deletion
        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0) {
            message = "Contact record deleted successfully!";
        } else {
            message = "No contact found with the given ID.";
            messageType = "error";
        }

    } catch (Exception e) {
        message = "An error occurred while deleting the contact: " + e.getMessage();
        messageType = "error";
    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Store the message in the session to display on the contactmanage.jsp page
    session.setAttribute("message", message);
    session.setAttribute("messageType", messageType);

    // Redirect back to the contact management page
    response.sendRedirect("contactmanage.jsp");
%>