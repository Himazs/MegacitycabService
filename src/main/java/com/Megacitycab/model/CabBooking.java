package com.Megacitycab.model;


public class CabBooking {
    private String userid;
    private String name;
    private String phone;
    private String pickupLocation;
    private String dropLocation;
    private String carType;

    public CabBooking(String name, String phone, String pickupLocation, String dropLocation, String carType, String userid) {
        this.name = name;
        this.phone = phone;
        this.pickupLocation = pickupLocation;
        this.dropLocation = dropLocation;
        this.carType = carType;
        this.userid = userid;  // Add userid to constructor
    }

    // Getters and setters for all fields
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
}