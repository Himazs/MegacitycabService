<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Driver Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
           <style>
        body {
            font-family: Arial, sans-serif;
            background-image: url(images/bg.png);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-color: #f4f4f4;
        }

        .form-container {
           background: linear-gradient(to right, #FFD700, #FFA500); 
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 350px;
            text-align: center;
        }

        .form-container img {
            width: 120px;
            height: auto;
            margin-bottom: 15px;
        }

        .form-container h2 {
            margin-bottom: 20px;
            color: #333;
        }

        .role-buttons button {
            padding: 10px;
            margin: 5px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            background-color: #1c185e;
            color: white;
        }

        .role-buttons button:hover {
            background-color: #040043;
        }

        .input-group {
            position: relative;
            margin: 10px 0;
            width: 100%;
        }

        .input-group input {
            width: 100%;
            padding: 10px 30px 10px 35px;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }

        .input-group i {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: #666;
            z-index: 1;
        }

        .password-container {
            position: relative;
        }

        .password-container input {
            padding-right: 35px;
        }

        .toggle-password {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            z-index: 1;
        }

        form button {
            width: 100%;
            padding: 10px;
            background-color: #1c185e;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 10px;
        }

        form button:hover {
            background-color: #040043;
        }

        .toggle-form-link {
            margin-top: 15px;
            font-size: 14px;
            color: #1c185e;
            text-decoration: none;
            cursor: pointer;
            display: block;
        }

        .toggle-form-link:hover {
            text-decoration: underline;
        }

        .form-section {
            display: none;
        }

        .button-icon {
            margin-right: 8px;
        }
        .success-message {
            background-color: #d4edda;
            color: #155724;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 5px;
            display: none;
        }
        .error-message {
            background-color: #f8d7da;
            color: #721c24;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 5px;
            display: none;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <a href="#" id="logo"><img src="images/logo.png" alt=""></a>
        
        <div id="messageBox" class="success-message"></div>
        <div id="errorBox" class="error-message"></div>
        
        <form id="driverLoginForm">
            <input type="hidden" name="role" value="Driver">
            <h2><i class="fas fa-car"></i> Driver Login</h2>
            <div class="input-group">
                <i class="fas fa-envelope"></i>
                <input type="email" id="driverLoginEmail" name="email" placeholder="Email" required>
            </div>
            <div class="input-group password-container">
                <i class="fas fa-lock"></i>
                <input type="password" id="driverLoginPassword" name="password" placeholder="Password" required>
                <span class="toggle-password" onclick="togglePassword('driverLoginPassword')">👁</span>
            </div>
            <button type="submit"><i class="fas fa-sign-in-alt button-icon"></i>Login</button>
            <a class="toggle-form-link" href="driverSignup.jsp">Don't have an account? Sign Up</a>
        </form>
    </div>

    <script>
    function togglePassword(inputId) {
        const passwordInput = document.getElementById(inputId);
        passwordInput.type = passwordInput.type === "password" ? "text" : "password";
    }

    $(document).ready(function() {
        $('#driverLoginForm').submit(function(event) {
            event.preventDefault();
            
            $('#errorBox').hide().text('');
            $('#messageBox').hide().text('');
            
            const $button = $('button[type="submit"]');
            $button.prop('disabled', true).text('Logging In...');

            $.ajax({
                type: "POST",
                url: "<%=request.getContextPath()%>/LoginServlet",
                data: $(this).serialize(),
                dataType: "json",
                success: function(response) {
                    if (response.success) {
                        $('#messageBox').text(response.message).show();
                        setTimeout(function() {
                            window.location.href = response.redirectUrl;
                        }, 2000);
                    } else {
                        $('#errorBox').text(response.message).show();
                    }
                },
                error: function(xhr, status, error) {
                    $('#errorBox').text("An error occurred: " + error).show();
                },
                complete: function() {
                    $button.prop('disabled', false).text('Login');
                }
            });
        });
    });
    </script>
</body>
</html>