<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% session.invalidate(); %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Cache-Control" content="no-store, no-cache, must-revalidate">
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Expires" content="0">
    <title>Logout</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <style>
        body {
            background-image: url(images/nw.png);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .logout-container {
            background: linear-gradient(to right, #ffd407, #ffffff); 
            border-radius: 15px;
            padding: 2.5rem;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.2);
            max-width: 500px;
            width: 100%;
            animation: fadeIn 0.5s ease-in;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .logout-icon {
            font-size: 3rem;
            color: #dc3545;
            margin-bottom: 1rem;
        }

        h2 {
            color: #333;
            font-weight: 700;
            margin-bottom: 1.5rem;
        }

        .btn-custom {
            background-color: #ffa500;
            border: none;
            padding: 10px 30px;
            transition: all 0.3s ease;
        }

        .btn-custom:hover {
            background-color: #f97d56;
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }

        .footer-text {
            color: #000;
            font-size: 0.9rem;
            margin-top: 1.5rem;
        }
    </style>
</head>
<body>
    <div class="logout-container text-center">
        <i class="bi bi-box-arrow-right logout-icon"></i>
        <h2>You have been logged out</h2>
        <a href="index.jsp" class="btn btn-custom text-white">Login Again</a>
        <p class="footer-text">Thank you for using our service. See you soon!</p>
    </div>

    <!-- Bootstrap JS and Popper.js -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"></script>
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">

    <!-- JavaScript to prevent back button -->
    <script type="text/javascript">
        // Disable caching
        window.history.forward();
        function noBack() {
            window.history.forward();
        }

        // Redirect to login if back button is pressed
        window.onunload = function() { null; };
        window.onload = function() {
            noBack();
        };

        // Clear history state
        if (typeof window.history.pushState === "function") {
            window.history.pushState("forward", null, null);
        }
    </script>
</body>
</html>