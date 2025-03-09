package com.Megacitycab.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import com.Megacitycab.model.*;

public class CarDAO {
    private String jdbcURL = "jdbc:mysql://localhost:3306/Megacitycab";
    private String jdbcUsername = "root";
    private String jdbcPassword = "Himas123@#";

    public boolean addCar(Car car) {
        String sql = "INSERT INTO car_new (driver_id, make, model, year, license_plate, color, seats) VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
                 PreparedStatement stmt = connection.prepareStatement(sql)) {

                stmt.setInt(1, car.getDriverId());
                stmt.setString(2, car.getMake());
                stmt.setString(3, car.getModel());
                stmt.setInt(4, car.getYear());
                stmt.setString(5, car.getLicensePlate());
                stmt.setString(6, car.getColor());
                stmt.setInt(7, car.getSeats());

                return stmt.executeUpdate() > 0;
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}

