<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String url = "jdbc:mysql://localhost:3306/megacitycab";
    String username = "root";
    String password = "Himas123@#";
    
    Connection conn = null;
    PreparedStatement pstmt = null;
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, username, password);
        
        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.trim().isEmpty()) {
            int id = Integer.parseInt(idParam);
            String sql = "DELETE FROM userhelp WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            
            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                response.sendRedirect("userHelps.jsp?status=success");
            } else {
                response.sendRedirect("userHelps.jsp?status=fail&message=No record found with ID: " + id);
            }
        } else {
            response.sendRedirect("userHelps.jsp?status=fail&message=Invalid ID provided");
        }
    } catch (SQLException e) {
        response.sendRedirect("userHelps.jsp?status=error&message=" + java.net.URLEncoder.encode("Database error: " + e.getMessage(), "UTF-8"));
    } catch (NumberFormatException e) {
        response.sendRedirect("userHelps.jsp?status=error&message=" + java.net.URLEncoder.encode("Invalid ID format: " + e.getMessage(), "UTF-8"));
    } catch (Exception e) {
        response.sendRedirect("userHelps.jsp?status=error&message=" + java.net.URLEncoder.encode("Error: " + e.getMessage(), "UTF-8"));
    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            response.sendRedirect("userHelps.jsp?status=error&message=" + java.net.URLEncoder.encode("Error closing connection: " + e.getMessage(), "UTF-8"));
        }
    }
%>
