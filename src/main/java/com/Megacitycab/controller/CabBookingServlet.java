package com.Megacitycab.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.Megacitycab.model.*;
import com.Megacitycab.dao.*;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/CabBookingServlet")
public class CabBookingServlet extends HttpServlet {

    private CabBookingDAO cabBookingDAO;

    @Override
    public void init() throws ServletException {
        cabBookingDAO = new CabBookingDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            String name = request.getParameter("name");
            String phone = request.getParameter("phone");
            String pickupLocation = request.getParameter("pickup");
            String dropLocation = request.getParameter("drop");
            String carType = request.getParameter("carType");
            String userid = request.getParameter("userid");
            double distance = Double.parseDouble(request.getParameter("distance").replace(" km", "")); // Parse distance

            CabBooking booking = new CabBooking(name, phone, pickupLocation, dropLocation, carType, userid, distance);

            cabBookingDAO.saveBooking(booking);

            response.sendRedirect("http://localhost:8080/Citycab/Megacitycab/booking-success.jsp"); // Redirect to success page
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("http://localhost:8080/Citycab/Megacitycab/booking-error.jsp"); // Redirect to error page
        }
    }
}