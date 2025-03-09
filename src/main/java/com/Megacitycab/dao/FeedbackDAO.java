package com.Megacitycab.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.Megacitycab.model.*;
import com.Megacitycab.util.*;

public class FeedbackDAO {
    private static final String INSERT_FEEDBACK = "INSERT INTO userfeedback (booking_id, userid, email, rating, feedback_text) VALUES (?, ?, ?, ?, ?)";  // Updated SQL
    private static final String SELECT_ALL_FEEDBACKS = "SELECT * FROM userfeedback";
    private static final String SELECT_FEEDBACK_BY_ID = "SELECT * FROM userfeedback WHERE id = ?";
    
    // Insert feedback
    public boolean addFeedback(Feedback feedback) {
        boolean success = false;
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        
        try {
            connection = DBConnectionUtil.getConnection();
            preparedStatement = connection.prepareStatement(INSERT_FEEDBACK);
            preparedStatement.setString(1, feedback.getBookingId());
            preparedStatement.setString(2, feedback.getUserid());  // Add userid to insert
            preparedStatement.setString(3, feedback.getEmail());
            preparedStatement.setInt(4, feedback.getRating());
            preparedStatement.setString(5, feedback.getFeedbackText());
            
            success = preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return success;
    }
    
    // Get all feedbacks
    public List<Feedback> getAllFeedbacks() {
        List<Feedback> feedbacks = new ArrayList<>();
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DBConnectionUtil.getConnection();
            preparedStatement = connection.prepareStatement(SELECT_ALL_FEEDBACKS);
            resultSet = preparedStatement.executeQuery();
            
            while (resultSet.next()) {
                Feedback feedback = new Feedback();
                feedback.setId(resultSet.getInt("id"));
                feedback.setBookingId(resultSet.getString("booking_id"));
                feedback.setUserid(resultSet.getString("userid"));  // Add userid to retrieval
                feedback.setEmail(resultSet.getString("email"));
                feedback.setRating(resultSet.getInt("rating"));
                feedback.setFeedbackText(resultSet.getString("feedback_text"));
                feedback.setSubmissionDate(resultSet.getTimestamp("submission_date"));
                
                feedbacks.add(feedback);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null) {
                    resultSet.close();
                }
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return feedbacks;
    }
    
    // Get feedback by ID
    public Feedback getFeedbackById(int id) {
        Feedback feedback = null;
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;
        
        try {
            connection = DBConnectionUtil.getConnection();
            preparedStatement = connection.prepareStatement(SELECT_FEEDBACK_BY_ID);
            preparedStatement.setInt(1, id);
            resultSet = preparedStatement.executeQuery();
            
            if (resultSet.next()) {
                feedback = new Feedback();
                feedback.setId(resultSet.getInt("id"));
                feedback.setBookingId(resultSet.getString("booking_id"));
                feedback.setUserid(resultSet.getString("userid"));  // Add userid to retrieval
                feedback.setEmail(resultSet.getString("email"));
                feedback.setRating(resultSet.getInt("rating"));
                feedback.setFeedbackText(resultSet.getString("feedback_text"));
                feedback.setSubmissionDate(resultSet.getTimestamp("submission_date"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (resultSet != null) {
                    resultSet.close();
                }
                if (preparedStatement != null) {
                    preparedStatement.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        
        return feedback;
    }
}