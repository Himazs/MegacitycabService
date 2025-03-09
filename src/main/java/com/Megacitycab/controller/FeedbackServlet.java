package com.Megacitycab.controller;



import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.Megacitycab.dao.*;
import com.Megacitycab.model.*;

@WebServlet("/FeedbackServlet")
public class FeedbackServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private FeedbackDAO feedbackDAO;
    
    public void init() {
        feedbackDAO = new FeedbackDAO();
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get form data
        String bookingId = request.getParameter("booking_id");
        String userid = request.getParameter("userid");  // Add userid parameter
        String email = request.getParameter("email");
        int rating = Integer.parseInt(request.getParameter("rating"));
        String feedbackText = request.getParameter("feedback_text");
        
        // Create feedback object
        Feedback feedback = new Feedback(bookingId, userid, email, rating, feedbackText);  // Pass userid to constructor
        
        // Save to database
        try {
            if (feedbackDAO.addFeedback(feedback)) {
                // Success - you can redirect to a success page or send a JSON response
                response.setContentType("application/json");
                response.getWriter().write("{\"success\":true,\"message\":\"Thank you for your feedback!\"}");
            } else {
                // Error
                response.setContentType("application/json");
                response.getWriter().write("{\"success\":false,\"message\":\"Failed to submit feedback. Please try again.\"}");
            }
        } catch (Exception e) {
            // Exception handling
            response.setContentType("application/json");
            response.getWriter().write("{\"success\":false,\"message\":\"An error occurred: " + e.getMessage() + "\"}");
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // If you want to implement a feedback view page, you can use this method
        // This is just a placeholder and can be modified as needed
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }
}