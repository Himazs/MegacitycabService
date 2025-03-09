package com.Megacitycab.model;



public class Car {
    private int driverId;
    private String make;
    private String model;
    private int year;
    private String licensePlate;
    private String color;
    private int seats;

    public Car(int driverId, String make, String model, int year, String licensePlate, String color, int seats) {
        this.driverId = driverId;
        this.make = make;
        this.model = model;
        this.year = year;
        this.licensePlate = licensePlate;
        this.color = color;
        this.seats = seats;
    }

    public int getDriverId() { return driverId; }
    public String getMake() { return make; }
    public String getModel() { return model; }
    public int getYear() { return year; }
    public String getLicensePlate() { return licensePlate; }
    public String getColor() { return color; }
    public int getSeats() { return seats; }
}
