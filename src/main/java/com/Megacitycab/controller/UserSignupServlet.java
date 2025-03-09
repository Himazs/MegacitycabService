package com.Megacitycab.controller;

import com.Megacitycab.dao.*;
import com.Megacitycab.model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/UserSignupServlet")
public class UserSignupServlet extends HttpServlet {
    private UserDao userDao;
    
    public void init() {
        userDao = new UserDao();
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String address = request.getParameter("address");
        String phoneNumber = request.getParameter("phoneNumber");
        String nic = request.getParameter("nic");

        // Set response type to JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Basic validation
        if (name == null || name.trim().isEmpty() || email == null || email.trim().isEmpty() ||
            password == null || password.trim().isEmpty() || address == null || address.trim().isEmpty() ||
            phoneNumber == null || phoneNumber.trim().isEmpty() || nic == null || nic.trim().isEmpty()) {
            response.getWriter().write("{\"success\": false, \"message\": \"Please fill all required fields.\"}");
            return;
        }

        // Additional validation
        if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            response.getWriter().write("{\"success\": false, \"message\": \"Invalid email format.\"}");
            return;
        }

        if (phoneNumber.length() != 10 || !phoneNumber.matches("\\d{10}")) {
            response.getWriter().write("{\"success\": false, \"message\": \"Phone number must be 10 digits.\"}");
            return;
        }

        if (nic.length() != 12) {
            response.getWriter().write("{\"success\": false, \"message\": \"NIC must be 12 characters.\"}");
            return;
        }

        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setPassword(password);  // Save plain password directly
        user.setAddress(address);
        user.setPhoneNumber(phoneNumber);
        user.setNic(nic);
        user.setRole("User");

        try {
            boolean isRegistered = userDao.insertUser(user);
            if (isRegistered) {
                response.getWriter().write("{\"success\": true, \"message\": \"User signup successful! Please login.\", \"redirectUrl\": \"userLogin.jsp\"}");
            } else {
                response.getWriter().write("{\"success\": false, \"message\": \"Registration failed. Email might already exist.\"}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("{\"success\": false, \"message\": \"Error during signup: " + e.getMessage().replace("\"", "\\\"") + "\"}");
        }
    }
}