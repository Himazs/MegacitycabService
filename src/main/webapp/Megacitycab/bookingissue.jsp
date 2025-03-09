<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Client Help - Booking Assistance</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body { 
              background-image: url(images/nw.png);
            background-size: cover; /* Cover the entire page */
            background-repeat: no-repeat; /* No repetition */
            background-position: center; /* Center the image */
            padding: 10px; /* Reduced padding for compactness */
            font-family: Arial, sans-serif;
            margin: 0; /* Remove default margins */
        }
        .container { 
            background-color: rgba(255, 255, 255, 0.9); /* Semi-transparent white for readability over background */
            border-radius: 10px; /* Smaller border radius */
            padding: 15px; /* Reduced padding */
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* Lighter shadow */
            max-width: 800px; /* Slightly narrower container */
            margin: 10px auto; /* Center and minimize margins */
        }
        .help-section { margin-bottom: 15px; } /* Reduced margin */
        .help-section h3 { 
            color: #ff6b00; 
            font-size: 1.1rem; /* Smaller header size */
            margin-bottom: 10px; /* Reduced margin */
        }
        .help-section p, .help-section ul { 
            font-size: 0.9rem; /* Smaller text size */
            margin-bottom: 8px; /* Reduced margin */
        }
        .help-section ul { padding-left: 20px; } /* Reduced padding for lists */
        .btn-help { 
            background-color: #007bff; 
            color: white; 
            margin: 3px; /* Reduced margin */
            font-size: 0.9rem; /* Smaller button text */
            padding: 5px 10px; /* Reduced padding */
        }
        .btn-help:hover { background-color: #0056b3; }
        .text-center .btn { 
            margin: 5px; /* Reduced margin for buttons at bottom */
            font-size: 0.9rem; /* Smaller button text */
            padding: 5px 15px; /* Reduced padding */
        }
    </style>
</head>
<body>
    <div class="container">
        <h2 class="text-center mb-3"><i class="fas fa-headset"></i> Client Help - Booking Assistance</h2>

        <div class="help-section">
            <h3><i class="fas fa-question-circle"></i> How to Use Booking Confirmation</h3>
            <p>Learn to use your confirmation page with these steps:</p>
        </div>

        <div class="help-section">
            <h3><i class="fas fa-info-circle"></i> Booking Details</h3>
            <p>Click "Booking Details," enter your User ID to see:</p>
            <ul>
                <li>Booking ID, date, destination, status.</li>
                <li>Cancel button to cancel rides.</li>
            </ul>
            <button class="btn btn-help" disabled><i class="fas fa-info-circle"></i> Booking Details</button>
        </div>

        <div class="help-section">
            <h3><i class="fas fa-file-invoice-dollar"></i> Booking Bill</h3>
            <p>Click "Booking Bill," enter User ID to view:</p>
            <ul>
                <li>Booking ID, date, amount, payment status.</li>
            </ul>
            <button class="btn btn-help" disabled><i class="fas fa-file-invoice-dollar"></i> Booking Bill</button>
        </div>

        <div class="help-section">
            <h3><i class="fas fa-plus-circle"></i> Book Another Ride</h3>
            <p>Click "Booking Another Ride" to open a form for a new booking.</p>
            <button class="btn btn-help" disabled><i class="fas fa-plus-circle"></i> Book Another Ride</button>
        </div>

        <div class="help-section">
            <h3><i class="fas fa-exclamation-triangle"></i> Common Issues</h3>
            <ul>
                <li><strong>Invalid ID:</strong> Use correct User ID or contact support.</li>
                <li><strong>Cancellation Failed:</strong> Check booking status.</li>
                <li><strong>Payment Issue:</strong> Wait or contact support.</li>
            </ul>
        </div>

        <div class="text-center mt-3">
            <a href="booking-success.jsp" class="btn btn-primary"><i class="fas fa-arrow-left"></i> Back</a>
            <a href="contact.jsp" class="btn btn-success"><i class="fas fa-envelope"></i> Support</a>
        </div>
    </div>

    <!-- Bootstrap JS and Popper.js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>