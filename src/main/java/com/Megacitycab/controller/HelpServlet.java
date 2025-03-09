package com.Megacitycab.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import com.Megacitycab.model.*;
import com.Megacitycab.dao.*;

@WebServlet("/HelpServlet")
public class HelpServlet extends HttpServlet {
    private DriverHelpDAO driverHelpDAO;

    @Override
    public void init() throws ServletException {
        driverHelpDAO = new DriverHelpDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Set content type to JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        String issue = request.getParameter("issue");
        String description = request.getParameter("description");

        if (issue == null || issue.isEmpty() || description == null || description.trim().isEmpty()) {
            // Return JSON error response
            out.print("{\"success\": false, \"message\": \"Please select an issue and provide a description.\"}");
            out.flush();
            return;
        }

        DriverHelp help = new DriverHelp(issue, description);

        try {
            driverHelpDAO.saveHelpRequest(help);
            // Return JSON success response
            out.print("{\"success\": true, \"message\": \"Help request submitted successfully!\"}");
        } catch (Exception e) {
            e.printStackTrace();
            // Return JSON error response
            out.print("{\"success\": false, \"message\": \"Error submitting request: " + escapeJSON(e.getMessage()) + "\"}");
        }
        out.flush();
    }
    
    // Helper method to escape JSON special characters
    private String escapeJSON(String input) {
        if (input == null) {
            return "";
        }
        return input.replace("\\", "\\\\")
                   .replace("\"", "\\\"")
                   .replace("\n", "\\n")
                   .replace("\r", "\\r")
                   .replace("\t", "\\t");
    }
}