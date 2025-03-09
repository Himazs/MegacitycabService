<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Success</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <style>
        body {
            background-image: url(images/nw.png);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            margin: 0;
            position: relative; /* Added for positioning the help button */
        }
        .success-container {
            text-align: center;
            padding: 2rem;
            background: linear-gradient(to right, #ffd407, #ffffff); 
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            width: 90%;
            transition: transform 0.3s ease;
            position: relative; /* Added for layout */
        }
        .success-container:hover {
            transform: scale(1.02);
        }
        .success-container h1 {
            color: #28a745;
            margin-bottom: 1rem;
            font-size: 2rem;
        }
        .success-container p {
            font-size: 1.2rem;
            color: #333;
            margin-bottom: 1.5rem;
        }
        .button-group {
            display: flex;
            justify-content: center;
            gap: 0.5rem;
            flex-wrap: wrap;
        }
        .success-container a {
            text-decoration: none;
            color: white;
            background-color: #007bff;
            padding: 0.5rem 1rem;
            border-radius: 6px;
            transition: background-color 0.3s ease;
            white-space: nowrap;
            flex: 1;
            text-align: center;
            min-width: 130px;
            margin-bottom: 0.5rem;
        }
        .success-container a:hover {
            background-color: #0056b3;
        }
        .cancel-btn {
            background-color: #dc3545;
        }
        .cancel-btn:hover {
            background-color: #b02a37;
        }
        .pass-image {
            max-width: 200px;
            margin-bottom: 1rem;
            display: block;
            margin-left: auto;
            margin-right: auto;
        }
        .pass-image[src=""] {
            width: 200px;
            height: 150px;
            background-color: #f8f9fa;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #6c757d;
            font-size: 1rem;
            text-align: center;
        }
        .help-btn {
            position: absolute;
            top: 10px;
            right: 10px;
            background-color: #17a2b8;
            padding: 0.3rem 0.8rem;
            font-size: 0.9rem;
        }
        .help-btn:hover {
            background-color: #138496;
        }
        @media (max-width: 576px) {
            .success-container {
                padding: 1.5rem;
                width: 95%;
            }
            .success-container h1 {
                font-size: 1.5rem;
            }
            .success-container p {
                font-size: 1rem;
            }
            .success-container a {
                padding: 0.4rem 0.8rem;
                font-size: 0.9rem;
            }
            .pass-image {
                max-width: 150px;
            }
            .button-group {
                gap: 0.3rem;
            }
            .help-btn {
                padding: 0.2rem 0.6rem;
                font-size: 0.8rem;
            }
        }
    </style>
</head>
<body>
    <div class="success-container">
        <a href="bookingissue.jsp" class="btn help-btn">Help</a>
        <img src="images/pass.png" alt="Booking Success" class="pass-image">
        <h1>Booking Confirmed!</h1>
        <p>Your cab has been booked successfully.</p>
        <div class="button-group">
            <a href="BookingDetails.jsp" class="btn cancel-btn">Booking Details</a>
            <a href="Bill.jsp" class="btn cancel-btn">Booking Bill</a>
            <a href="booking.jsp" class="btn btn-primary">Booking Another Ride</a>
        </div>
    </div>

    <!-- Bootstrap JS and Popper.js -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkmvNW+oWpQ8a5Um6NwsGyAtQaB0VTuWRfH8nKyh1OykH5g3WrEA6Zkw4" crossorigin="anonymous"></script>
</body>
</html>