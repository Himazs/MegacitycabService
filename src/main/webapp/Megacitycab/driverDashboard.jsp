<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ page import="com.Megacitycab.model.Driver" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    HttpSession sessionDriver = request.getSession(false);
    if (sessionDriver == null || sessionDriver.getAttribute("driver") == null) {
        response.sendRedirect("driverLogin.jsp");
        return;
    }
    Driver driver = (Driver) sessionDriver.getAttribute("driver");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Driver Home Page</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-image: url(images/back.png);
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
            color: #333;
            display: flex;
            min-height: 100vh;
        }

        .sidebar {
            width: 260px;
            background: linear-gradient(to right, #ffd407, #ffffff); 
            padding: 25px;
            box-shadow: 3px 0 10px rgba(0, 0, 0, 0.15);
            transition: width 0.3s ease;
        }

        .sidebar img {
            width: 100%;
            margin-bottom: 25px;
            border-radius: 8px;
        }

        .sidebar ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .sidebar ul li {
            margin: 12px 0;
        }

        .sidebar ul li a {
            text-decoration: none;
            color: #000000;
            display: flex;
            align-items: center;
            padding: 12px 15px;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .sidebar ul li a:hover, .sidebar ul li a.active {
            background:#ff6100;
            color: #fff;
            transform: translateX(5px);
        }

        .sidebar ul li a i {
            margin-right: 12px;
            font-size: 18px;
        }

        .main-content {
            flex: 1;
            padding: 25px;
            overflow-y: auto;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: rgba(255, 255, 255, 0.9);
            padding: 15px 25px;
            border-radius: 12px;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        .header h1 {
            margin: 0;
            font-size: 24px;
            color: #222;
        }

        .logout-btn {
            background: #ff0000;
            color: #fff;
            padding: 12px;
            border-radius: 8px;
            text-align: center;
            display: block;
            transition: background-color 0.3s ease;
            cursor: pointer;
        }

        .logout-btn:hover {
            background: #d60000;
        }

        iframe {
            width: 100%;
            height: 100%;
            border: none;
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
    <div class="sidebar">
        <img src="images/logo.png" alt="Logo">
        <ul>
            <li><a href="dprofile.jsp" class="user-btn" target="contentFrame"><i class="fas fa-user"></i> Profile</a></li>
              <li><a href="Carprofile.jsp" class="register-btn" target="contentFrame"><i class="fas fa-car-side"></i> Car Details</a></li>
            <li><a href="dnotification.jsp" class="bell-btn" target="contentFrame"><i class="fas fa-bell"></i> Ride Notification</a></li>
            <li><a href="dtrips.jsp" class="book-btn" target="contentFrame"><i class="fas fa-book"></i> Bookings Details</a></li>
            <li><a href="DriverReceivedTrips.jsp" class="trip-btn" target="contentFrame"><i class="fas fa-history"></i> Recent Trips</a></li>
            <li><a href="driverhelp.jsp" class="user-btn" target="contentFrame"><i class="fas fa-question-circle"></i> Help</a></li>
            <li><a href="registerCar.jsp" class="register-btn" target="contentFrame"><i class="fas fa-car-side"></i> Register Car</a></li>
            <li>
                <a href="#" class="logout-btn" onclick="logoutDriver()">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
            </li>
        </ul>
    </div>

    <div class="main-content">
        <div class="header">
            <h1>Driver Dashboard</h1>
            <p>Welcome, <%= driver.getName() %><br>Id, <%= driver.getDriverId() %></p><br>
        </div>

        <iframe name="contentFrame" src="dnotification.jsp"></iframe>
    </div>

    <script>
        function logoutDriver() {
            if (confirm("Are you sure you want to log out?")) {
                window.location.href = "logout.jsp";
            }
        }
    </script>
</body>
</html>
