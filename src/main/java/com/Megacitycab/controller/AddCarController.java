package com.Megacitycab.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.Megacitycab.dao.*;
import com.Megacitycab.model.*;

@WebServlet("/AddCarController")
public class AddCarController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            // Retrieve form parameters
            String driverIdStr = request.getParameter("driverid");
            String yearStr = request.getParameter("year");
            String seatsStr = request.getParameter("seats");
            String make = request.getParameter("make");
            String model = request.getParameter("model");
            String licensePlate = request.getParameter("licensePlate");
            String color = request.getParameter("color");

            // Check for missing values
            if (driverIdStr == null || yearStr == null || seatsStr == null || make == null || 
                model == null || licensePlate == null || color == null ||
                driverIdStr.trim().isEmpty() || yearStr.trim().isEmpty() || seatsStr.trim().isEmpty() ||
                make.trim().isEmpty() || model.trim().isEmpty() || licensePlate.trim().isEmpty() || 
                color.trim().isEmpty()) {
                response.getWriter().write("{\"success\": false, \"message\": \"All fields are required\"}");
                return;
            }

            // Convert and validate numeric values
            int driverId, year, seats;
            try {
                driverId = Integer.parseInt(driverIdStr);
                year = Integer.parseInt(yearStr);
                seats = Integer.parseInt(seatsStr);
            } catch (NumberFormatException e) {
                response.getWriter().write("{\"success\": false, \"message\": \"Invalid numeric values. Please enter valid numbers.\"}");
                return;
            }

            // Additional validation
            if (driverId <= 0) {
                response.getWriter().write("{\"success\": false, \"message\": \"Driver ID must be a positive number\"}");
                return;
            }
            int currentYear = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
            if (year < 1900 || year > currentYear) {
                response.getWriter().write("{\"success\": false, \"message\": \"Year must be between 1900 and " + currentYear + "\"}");
                return;
            }
            if (seats < 1 || seats > 20) {
                response.getWriter().write("{\"success\": false, \"message\": \"Seats must be between 1 and 20\"}");
                return;
            }

            // Create Car object
            Car car = new Car(driverId, make, model, year, licensePlate, color, seats);
            CarDAO carDAO = new CarDAO();

            // Attempt to add car
            if (carDAO.addCar(car)) {
                response.getWriter().write("{\"success\": true, \"message\": \"Car registered successfully\"}");
            } else {
                response.getWriter().write("{\"success\": false, \"message\": \"Failed to register car. License plate might already exist.\"}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("{\"success\": false, \"message\": \"Server error: " + e.getMessage() + "\"}");
        }
    }
}