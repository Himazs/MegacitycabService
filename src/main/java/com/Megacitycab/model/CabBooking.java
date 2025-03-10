package com.Megacitycab.model;

public class CabBooking {
    private String userid;
    private String name;
    private String phone;
    private String pickupLocation;
    private String dropLocation;
    private String carType;
    private double distance; // Added distance field

    public CabBooking(String name, String phone, String pickupLocation, String dropLocation, String carType, String userid, double distance) {
        this.name = name;
        this.phone = phone;
        this.pickupLocation = pickupLocation;
        this.dropLocation = dropLocation;
        this.carType = carType;
        this.userid = userid;
        this.distance = distance; // Initialize distance
    }

    // Getters and setters
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public String getPickupLocation() { return pickupLocation; }
    public void setPickupLocation(String pickupLocation) { this.pickupLocation = pickupLocation; }
    public String getDropLocation() { return dropLocation; }
    public void setDropLocation(String dropLocation) { this.dropLocation = dropLocation; }
    public String getCarType() { return carType; }
    public void setCarType(String carType) { this.carType = carType; }
    public String getUserid() { return userid; }
    public void setUserid(String userid) { this.userid = userid; }
    public double getDistance() { return distance; }
    public void setDistance(double distance) { this.distance = distance; }
}