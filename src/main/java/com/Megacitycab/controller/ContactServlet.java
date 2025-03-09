package com.Megacitycab.controller;



import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;




@WebServlet("/ContactServlet")
public class ContactServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String message = request.getParameter("message");

        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            // Load the MySQL driver
            Class.forName("com.mysql.cj.jdbc.Driver");

         
            String url = "jdbc:mysql://localhost:3306/megacitycab";
            String username = "root"; 
            String password = "Himas123@#"; 

            conn = DriverManager.getConnection(url, username, password);

            // SQL query to insert data
            String sql = "INSERT INTO contact (name, email, message) VALUES (?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.setString(2, email);
            pstmt.setString(3, message);

            // Execute the query
            pstmt.executeUpdate();

            // Set success message
            request.setAttribute("successMsg", "Thank you for your message! We will get back to you soon.");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "Error submitting your message. Please try again later.");
        } finally {
            // Close connections
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }

        // Forward back to contact.jsp with the message
        request.getRequestDispatcher("Megacitycab/contact.jsp").forward(request, response);
    }
}
