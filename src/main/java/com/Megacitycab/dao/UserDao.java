package com.Megacitycab.dao;

import com.Megacitycab.model.*;
import java.sql.*;

public class UserDao {
    private String jdbcURL = "jdbc:mysql://localhost:3306/Megacitycab";
    private String jdbcUsername = "root";
    private String jdbcPassword = "Himas123@#";

    private static final String INSERT_USER_SQL = 
        "INSERT INTO users (name, email, password, address, phone_number, nic, role) " +
        "VALUES (?, ?, ?, ?, ?, ?, ?)";
    private static final String SELECT_USER_BY_EMAIL_PASSWORD = 
        "SELECT * FROM users WHERE email = ? AND password = ?";

    protected Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return connection;
    }

    public boolean insertUser(User user) throws SQLException {
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(INSERT_USER_SQL)) {
            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getAddress());
            ps.setString(5, user.getPhoneNumber());
            ps.setString(6, user.getNic());
            ps.setString(7, user.getRole());
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public User validateUser(String email, String password) throws SQLException {
        User user = null;
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(SELECT_USER_BY_EMAIL_PASSWORD)) {
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setAddress(rs.getString("address"));
                user.setPhoneNumber(rs.getString("phone_number"));
                user.setNic(rs.getString("nic"));
                user.setRole(rs.getString("role"));
            }
        }
        return user;
    }
}
