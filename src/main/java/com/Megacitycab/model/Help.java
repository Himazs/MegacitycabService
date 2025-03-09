package com.Megacitycab.model;


import java.sql.Timestamp;

public class Help {
    private String userid;  // New field
    private int id;
    private String bookingId;
    private String issueType;
    private Timestamp submissionTimestamp;

    // Constructors
    public Help() {}

    public Help(String bookingId, String issueType, String userid) {  // Updated constructor
        this.bookingId = bookingId;
        this.issueType = issueType;
        this.userid = userid;  // Add userid to constructor
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getBookingId() {
        return bookingId;
    }

    public void setBookingId(String bookingId) {
        this.bookingId = bookingId;
    }

    public String getIssueType() {
        return issueType;
    }

    public void setIssueType(String issueType) {
        this.issueType = issueType;
    }

    public Timestamp getSubmissionTimestamp() {
        return submissionTimestamp;
    }

    public void setSubmissionTimestamp(Timestamp submissionTimestamp) {
        this.submissionTimestamp = submissionTimestamp;
    }
}
