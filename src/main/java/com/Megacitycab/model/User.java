package com.Megacitycab.model;

public class User {
    private int userId;
    private String name;
    private String email;
    private String password;
    private String address;
    private String phoneNumber;
    private String nic;  // Added NIC field
    private String role;

    // Constructors
    public User() {}

    public User(String name, String email, String password, String address, 
                String phoneNumber, String nic, String role) {
        this.name = name;
        this.email = email;
        this.password = password;
        this.address = address;
        this.phoneNumber = phoneNumber;
        this.nic = nic;
        this.role = role;
    }

    // Getters and Setters
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    public String getPhoneNumber() { return phoneNumber; }
    public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }
    public String getNic() { return nic; }
    public void setNic(String nic) { this.nic = nic; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
}