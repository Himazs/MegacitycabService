<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <title>Help - Mega City Cab</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            transition: .2s linear;
            text-transform: capitalize;
            text-decoration: none;
        }

        html {
            font-size: 62.5%;
            overflow-x: hidden;
            scroll-behavior: smooth;
        }

        .header {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            padding: 1rem 7%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            z-index: 1000;
            background: linear-gradient(to right, #FFD700, #FFA500);
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .header #logo img {
            height: 50px;
        }

        .header .navbar a {
            color: black;
            font-size: 1.6rem;
            margin: 0 1rem;
            transition: color 0.3s ease;
        }

        .header .navbar a:hover {
            color: #FFF;
        }

        .help-section {
            padding: 10rem 7% 5rem;
            background-image: url(images/bg.png);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .help-container {
            background: white;
            padding: 3rem;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
        }

        .help-container h1 {
            font-size: 2.8rem;
            color: #FFA500;
            margin-bottom: 2rem;
            text-align: center;
        }

        .help-container form {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }

        .help-container input,
        .help-container select {
            width: 100%;
            padding: 1.2rem;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1.4rem;
            transition: border-color 0.3s ease;
        }

        .help-container input:focus,
        .help-container select:focus {
            border-color: #FFA500;
            outline: none;
        }

        /* Style for the submit button */
        .help-container input[type="submit"] {
            background: #ff9100; /* Default color */
            color: white;
            padding: 1.2rem;
            border: none;
            border-radius: 5px;
            font-size: 1.6rem;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        .help-container input[type="submit"]:hover {
            background: #e07b00; /* Darker shade for hover */
        }

        .emergency-info {
            text-align: center;
            margin: 1.5rem 0;
        }

        .emergency-info p {
            color: black;
            font-size: 1.4rem;
            margin: 0.5rem 0;
        }

        .message {
            margin: 1rem 0;
            padding: 1rem;
            border-radius: 5px;
            font-size: 1.4rem;
            text-align: center;
        }

        .success {
            background: #d4edda;
            color: #155724;
        }

        .error {
            background: #f8d7da;
            color: #721c24;
        }
    </style>
</head>
<body>
    <header class="header">
        <a href="#" id="logo"><img src="images/logo.png" alt=""></a>
        <nav class="navbar">
            <a href="index.jsp">home</a>
            <a href="index.jsp#about">about</a>
            <a href="#">profile</a>
            <a href="index.jsp#booking">booking</a>
            <a href="userhelp.jsp">help</a>
            <a href="index.jsp#contact">contact</a>
            <a href="logout.jsp" class="logout-btn">logout</a>
        </nav>
    </header>

    <section class="help-section">
        <div class="help-container">
            <h1>Need Assistance?</h1>
            
            <% 
                String success = request.getParameter("success");
                String error = request.getParameter("error");
                if (success != null) {
            %>
                <div class="message success"><%= success %></div>
            <% 
                } else if (error != null) {
            %>
                <div class="message error"><%= error %></div>
            <% 
                }
            %>

            <form action="<%=request.getContextPath()%>/UHelpServlet" method="post">
                <label for="userid">User ID:</label>
                <input type="text" id="userid" name="userid" required><br>
                <label for="booking_id">Booking ID:</label>
                <input type="text" id="booking_id" name="booking_id" required><br>
                <label for="issue_type">Issue Type:</label>
                <select id="issue_type" name="issue_type" required>
                          <option value="">Select Issue</option>
            <option value="robbery">Robbery/Assault</option>
            <option value="medical">Medical Emergency</option>
            <option value="accident">Car Accident</option>
            <option value="payment">Payment Issue</option>
            <option value="gps">GPS/App Failure</option>
            <option value="client">driver Issue</option>
                    <option value="Other">Other</option>
                </select><br>
                <input type="submit" value="Submit Help Request">
            </form>
        </div>
    </section>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.querySelector('form');
            form.addEventListener('submit', function(event) {
                const bookingId = document.querySelector('input[name="booking_id"]').value;
                const issueType = document.querySelector('select[name="issue_type"]').value;

                if (!bookingId.trim() || !issueType) {
                    event.preventDefault();
                    alert('Please fill in all required fields');
                }
            });
        });
    </script>
</body>
</html>