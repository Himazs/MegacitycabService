package com.Megacitycab.dao;

import com.Megacitycab.model.*;
import java.sql.*;

public class AdminDao {
    private String jdbcURL = "jdbc:mysql://localhost:3306/Megacitycab";
    private String jdbcUsername = "root";
    private String jdbcPassword = "Himas123@#";

    private static final String INSERT_ADMIN_SQL = "INSERT INTO admins (email, password, role) VALUES (?, ?, 'Admin')";
    private static final String SELECT_ADMIN_BY_EMAIL_PASSWORD = "SELECT * FROM admins WHERE email = ? AND password = ?";

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

    public void insertAdmin(Admin admin) throws SQLException {
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(INSERT_ADMIN_SQL)) {
            ps.setString(1, admin.getEmail());
            ps.setString(2, admin.getPassword());
            ps.executeUpdate();
        }
    }

    public Admin validateAdmin(String email, String password) throws SQLException {
        Admin admin = null;
        try (Connection connection = getConnection();
             PreparedStatement ps = connection.prepareStatement(SELECT_ADMIN_BY_EMAIL_PASSWORD)) {
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                admin = new Admin();
                admin.setAdminId(rs.getInt("admin_id"));
                admin.setEmail(rs.getString("email"));
                admin.setPassword(rs.getString("password"));
                admin.setRole(rs.getString("role"));
            }
        }
        return admin;
    }
}