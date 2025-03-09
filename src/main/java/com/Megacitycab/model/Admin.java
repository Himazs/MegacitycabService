package com.Megacitycab.model;



public class Admin {
    private int adminId;
    private String name; // Added name field
    private String email;
    private String password;
    private String role;

    // Constructors
    public Admin() {}

    // Getters and Setters
    public int getAdminId() { return adminId; }
    public void setAdminId(int adminId) { this.adminId = adminId; }
    
    public String getName() { return name; } // Added getter for name
    public void setName(String name) { this.name = name; } // Added setter for name
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
}