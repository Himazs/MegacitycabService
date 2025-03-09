package com.Megacitycab.controller;



import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.Megacitycab.dao.*;
import com.Megacitycab.model.*;
@WebServlet("/UHelpServlet")
public class UHelpServlet extends HttpServlet {
    private HelpDAO helpDAO;

    @Override
    public void init() throws ServletException {
        helpDAO = new HelpDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String bookingId = request.getParameter("booking_id");
        String issueType = request.getParameter("issue_type");
        String userid = request.getParameter("userid");  // Add userid parameter

        System.out.println("Booking ID: " + bookingId); // Add debug
        System.out.println("Issue Type: " + issueType); // Add debug
        System.out.println("User ID: " + userid);       // Add debug

        if (bookingId == null || bookingId.trim().isEmpty() || 
            issueType == null || issueType.isEmpty() || 
            userid == null || userid.trim().isEmpty()) {  // Include userid in validation
            System.out.println("Validation failed"); // Add debug
            response.sendRedirect("userhelp.jsp?error=Please provide booking ID, user ID, and select an issue.");
            return;
        }
        
        Help help = new Help(bookingId, issueType, userid);  // Pass userid to constructor

        try {
            helpDAO.saveHelpRequest(help);
            response.sendRedirect("http://localhost:8080/Citycab/Megacitycab/userhelp.jsp?success=Help request submitted successfully!");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("http://localhost:8080/Citycab/Megacitycab/userhelp.jsp?error=Error submitting request: " + e.getMessage());
        }
    }
}