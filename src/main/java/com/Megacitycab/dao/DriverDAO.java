package com.Megacitycab.dao;


import com.Megacitycab.model.Driver;

import java.sql.*;

public class DriverDAO {
    private String jdbcURL = "jdbc:mysql://localhost:3306/Megacitycab";
    private String jdbcUsername = "root";
    private String jdbcPassword = "Himas123@#";

    private static final String INSERT_DRIVER_SQL = 
        "INSERT INTO drivers (name, email, password, address, phone_number, nic, role) " +
        "VALUES (?, ?, ?, ?, ?, ?, ?)";
    
    private static final String SELECT_DRIVER_BY_EMAIL_PASSWORD = 
        "SELECT * FROM drivers WHERE email = ? AND password = ?";

    protected Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return connection;
    }

    public boolean registerDriver(Driver driver) throws SQLException {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_DRIVER_SQL)) {
            
            preparedStatement.setString(1, driver.getName());
            preparedStatement.setString(2, driver.getEmail());
            preparedStatement.setString(3, driver.getPassword()); // In production, hash this password
            preparedStatement.setString(4, driver.getAddress());
            preparedStatement.setString(5, driver.getPhoneNumber());
            preparedStatement.setString(6, driver.getNic());
            preparedStatement.setString(7, driver.getRole());

            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            printSQLException(e);
            return false;
        }
    }

    // New method to validate driver credentials
    public Driver validateDriver(String email, String password) throws SQLException {
        Driver driver = null;
        
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_DRIVER_BY_EMAIL_PASSWORD)) {
            
            preparedStatement.setString(1, email);
            preparedStatement.setString(2, password);
            
            ResultSet resultSet = preparedStatement.executeQuery();
            
            if (resultSet.next()) {
                driver = new Driver();
                driver.setDriverId(resultSet.getInt("driver_id"));
                driver.setName(resultSet.getString("name"));
                driver.setEmail(resultSet.getString("email"));
                driver.setPassword(resultSet.getString("password"));
                driver.setAddress(resultSet.getString("address"));
                driver.setPhoneNumber(resultSet.getString("phone_number"));
                driver.setNic(resultSet.getString("nic"));
                driver.setRole(resultSet.getString("role"));
            }
        } catch (SQLException e) {
            printSQLException(e);
            throw e;
        }
        
        return driver; // Returns null if no matching driver found
    }

    private void printSQLException(SQLException ex) {
        for (Throwable e : ex) {
            if (e instanceof SQLException) {
                e.printStackTrace(System.err);
                System.err.println("SQLState: " + ((SQLException) e).getSQLState());
                System.err.println("Error Code: " + ((SQLException) e).getErrorCode());
                System.err.println("Message: " + e.getMessage());
                Throwable t = ex.getCause();
                while (t != null) {
                    System.out.println("Cause: " + t);
                    t = t.getCause();
                }
            }
        }
    }
}
