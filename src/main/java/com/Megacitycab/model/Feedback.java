package com.Megacitycab.model;


import java.sql.Timestamp;

public class Feedback {
    private int id;
    private String bookingId;
    private String userid;  // New field
    private String email;
    private int rating;
    private String feedbackText;
    private Timestamp submissionDate;
    
    // Default constructor
    public Feedback() {
    }
    
    // Constructor without id and submission date (will be generated)
    public Feedback(String bookingId, String userid, String email, int rating, String feedbackText) {  // Updated constructor
        this.bookingId = bookingId;
        this.userid = userid;  // Add userid to constructor
        this.email = email;
        this.rating = rating;
        this.feedbackText = feedbackText;
    }
    
    // Getters and Setters
    public int getId() {
        return id;
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
    
    public String getUserid() {  // New getter
        return userid;
    }
    
    public void setUserid(String userid) {  // New setter
        this.userid = userid;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public int getRating() {
        return rating;
    }
    
    public void setRating(int rating) {
        this.rating = rating;
    }
    
    public String getFeedbackText() {
        return feedbackText;
    }
    
    public void setFeedbackText(String feedbackText) {
        this.feedbackText = feedbackText;
    }
    
    public Timestamp getSubmissionDate() {
        return submissionDate;
    }
    
    public void setSubmissionDate(Timestamp submissionDate) {
        this.submissionDate = submissionDate;
    }

    @Override
    public String toString() {
        return "Feedback [id=" + id + ", bookingId=" + bookingId + ", userid=" + userid + ", email=" + email + ", rating=" + rating
                + ", feedbackText=" + feedbackText + ", submissionDate=" + submissionDate + "]";
    }
}
