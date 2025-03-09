package com.Megacitycab.model;


import java.sql.Timestamp;

public class DriverHelp {
    private int id;
    private String issue;
    private String description;
    private Timestamp submissionTimestamp;

    // Constructors
    public DriverHelp() {}

    public DriverHelp(String issue, String description) {
        this.issue = issue;
        this.description = description;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getIssue() {
        return issue;
    }

    public void setIssue(String issue) {
        this.issue = issue;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Timestamp getSubmissionTimestamp() {
        return submissionTimestamp;
    }

    public void setSubmissionTimestamp(Timestamp submissionTimestamp) {
        this.submissionTimestamp = submissionTimestamp;
    }
}