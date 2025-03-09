<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
           background-image: url(images/back.png);
           
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-color: #f4f4f4;
        }
        .form-container {
               background: linear-gradient(to right, #ff6007, #ffffff); 
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 350px;
            text-align: center;
        }
        .form-container img {
            width: 120px;
            margin-bottom: 15px;
        }
        .form-container h2 {
            margin-bottom: 20px;
            color: #333;
        }
     
        .role-buttons {
        display: flex;
        justify-content: center;
        gap: 2rem;
        padding: 2rem;
    }

    .role-buttons a {
        text-decoration: none;
        color: #737373;
        display: flex;
        flex-direction: column;
        align-items: center;
        background: #040043;
        padding: 1.5rem;
        border-radius: 10px;
        width: 120px;
        transition: all 0.3s ease;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }

    .role-buttons a:hover {
        transform: translateY(-5px);
        box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        background: #f8f9fa;
    }

    .button-icon {
        font-size: 2rem;
        color: #FFA500; /* Orange color to match previous button */
        margin-bottom: 0.5rem; /* Adds gap between icon and text */
    }

    .role-buttons a div {
        margin-top: 0.5rem; /* Additional control for spacing */
    }
    </style>
</head>
<body>
    <div class="form-container">
        <a href="#" id="logo"><img src="images/logo.png" alt=""></a>
        
        <h2>Choose a Role to Register</h2>
        <p> Welcome to Meagacity Cab Services </p>
   <div class="role-buttons">
    <a href="http://localhost:8080/Citycab/Megacitycab/userSignup.jsp">
        <i class="fas fa-user button-icon"></i>
        <br>
        <div>User</div>
    </a>
    <a href="http://localhost:8080/Citycab/Megacitycab/driverSignup.jsp">
        <i class="fas fa-car button-icon"></i>
        <br>
        <div>Driver</div>
    </a>
   
</div>
    </div>
</body>
</html>