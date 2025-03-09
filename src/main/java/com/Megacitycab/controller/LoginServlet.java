package com.Megacitycab.controller;

import com.Megacitycab.dao.*;
import com.Megacitycab.model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private UserDao userDao;
    private DriverDAO driverDao;
    private AdminDao adminDao;

    @Override
    public void init() throws ServletException {
        try {
            userDao = new UserDao();
            driverDao = new DriverDAO();
            adminDao = new AdminDao();
        } catch (Exception e) {
            throw new ServletException("Failed to initialize DAOs", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        if (email == null || password == null || role == null) {
            response.getWriter().write("{\"success\": false, \"message\": \"Missing required parameters\"}");
            return;
        }

        HttpSession session = request.getSession();

        try {
            switch (role.trim()) {
                case "User":
                    User user = userDao.validateUser(email, password);
                    if (user != null) {
                        session.setAttribute("user", user);
                        session.setAttribute("role", "User");
                        response.getWriter().write("{\"success\": true, \"message\": \"Login successful\", \"redirectUrl\": \"" + 
                            request.getContextPath() + "/Megacitycab/userDashboard.jsp\"}");
                    } else {
                        response.getWriter().write("{\"success\": false, \"message\": \"Invalid email or password\"}");
                    }
                    break;

                case "Driver":
                    Driver driver = driverDao.validateDriver(email, password);
                    if (driver != null) {
                        session.setAttribute("driver", driver);
                        session.setAttribute("role", "Driver");
                        response.getWriter().write("{\"success\": true, \"message\": \"Login successful\", \"redirectUrl\": \"" + 
                            request.getContextPath() + "/Megacitycab/driverDashboard.jsp\"}");
                    } else {
                        response.getWriter().write("{\"success\": false, \"message\": \"Invalid email or password\"}");
                    }
                    break;

                case "Admin":
                    Admin admin = adminDao.validateAdmin(email, password);
                    if (admin != null) {
                        session.setAttribute("admin", admin);
                        session.setAttribute("role", "Admin");
                        response.getWriter().write("{\"success\": true, \"message\": \"Login successful\", \"redirectUrl\": \"" + 
                            request.getContextPath() + "/Megacitycab/adminDashboard.jsp\"}");
                    } else {
                        response.getWriter().write("{\"success\": false, \"message\": \"Invalid email or password\"}");
                    }
                    break;

                default:
                    response.getWriter().write("{\"success\": false, \"message\": \"Invalid role specified\"}");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("{\"success\": false, \"message\": \"Server error occurred\"}");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "GET method not supported");
    }
}