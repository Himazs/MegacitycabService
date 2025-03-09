<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ page import="com.Megacitycab.model.Admin" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    HttpSession sessionAdmin = request.getSession(false);
    if (sessionAdmin == null || sessionAdmin.getAttribute("admin") == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
    Admin admin = (Admin) sessionAdmin.getAttribute("admin");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
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
            background: #ff6100;
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
            <li><a href="carManage.jsp" target="contentFrame"><i class="fas fa-car"></i> Car Manage</a></li>
            <li><a href="driverManage.jsp" target="contentFrame"><i class="fas fa-users"></i> Driver Manage</a></li>
            <li><a href="userManage.jsp" target="contentFrame"><i class="fas fa-user-friends"></i> User Manage</a></li>
            <li><a href="userHelps.jsp" target="contentFrame"><i class="fas fa-question-circle"></i> User Help Manage</a></li>
            <li><a href="driverHelps.jsp" target="contentFrame"><i class="fas fa-question-circle"></i> Driver Help Manage</a></li>
            <li><a href="feedbackdetail.jsp" target="contentFrame"><i class="fas fa-comments"></i> Feedback Manage</a></li>
            <li><a href="bookingmanage.jsp" target="contentFrame"><i class="fas fa-book"></i> Bookings Manage</a></li>
            <li>
                <a href="logout.jsp" class="logout-btn" onclick="return confirmLogout();">
                    <i class="fas fa-sign-out-alt"></i> Logout
                </a>
            </li>
        </ul>
    </div>

    <div class="main-content">
        <div class="header">
            <h1>Admin Dashboard</h1>
        </div>
        <iframe name="contentFrame" src="carManage.jsp"></iframe>
    </div>

    <script>
        document.querySelectorAll('.sidebar ul li a').forEach(item => {
            item.addEventListener('click', function() {
                document.querySelectorAll('.sidebar ul li a').forEach(link => link.classList.remove('active'));
                this.classList.add('active');
            });
        });

        function confirmLogout() {
            return confirm("Are you sure you want to logout?");
        }
    </script>
</body>
</html>
