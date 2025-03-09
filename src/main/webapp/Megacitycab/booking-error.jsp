<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Error</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <style>
        body {
            background-image: url(images/nw.png);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .error-container {
            text-align: center;
            padding: 2rem;
            background: linear-gradient(to right, #ffd407, #ffffff);
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            max-width: 500px;
            width: 90%;
        }
        .error-container h1 {
            color: #dc3545; /* Bootstrap danger red */
            margin-bottom: 1rem;
        }
        .error-container p {
            font-size: 1.2rem;
            color: #333;
            margin-bottom: 1.5rem;
        }
        .error-container a {
            text-decoration: none;
            color: white;
            background-color: #007bff; /* Bootstrap primary blue */
            padding: 0.5rem 1.5rem;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }
        .error-container a:hover {
            background-color: #0056b3; /* Darker blue on hover */
        }
        .fail-image {
            max-width: 200px;
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <img src="images/fail.png" alt="Booking Failed" class="fail-image">


        <h1>Booking Failed</h1>
        <p>Sorry, something went wrong. Please try again.</p>
        <a href="booking.jsp" class="btn btn-primary">Try Again</a>
    </div>

    <!-- Bootstrap JS and Popper.js (required for some Bootstrap components) -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkmvNW+oWpQ8a5Um6NwsGyAtQaB0VTuWRfH8nKyh1OykH5g3WrEA6Zkw4" crossorigin="anonymous"></script>
</body>
</html>