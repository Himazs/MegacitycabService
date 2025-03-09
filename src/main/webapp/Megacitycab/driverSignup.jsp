<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Driver Sign Up</title>
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
        <a href="#" id="logo"><img src="images/logo.png" alt="Logo"></a>
        
        <div id="messageBox" class="success-message"></div>
        <div id="errorBox" class="error-message"></div>
        
        <form id="driverSignupForm">
            <input type="hidden" name="role" value="Driver">
            <h2><i class="fas fa-user-plus"></i> Driver Sign Up</h2>
            <div class="input-group">
                <i class="fas fa-user"></i>
                <input type="text" id="driverSignupName" name="name" placeholder="Name" required>
            </div>
            <div class="input-group">
                <i class="fas fa-envelope"></i>
                <input type="email" id="driverSignupEmail" name="email" placeholder="Email" required>
            </div>
            <div class="input-group">
                <i class="fas fa-phone"></i>
                <input type="text" id="driverPhoneNumber" name="phoneNumber" placeholder="Phone Number" required>
            </div>
            <div class="input-group">
                <i class="fas fa-map-marker-alt"></i>
                <input type="text" id="driverAddress" name="address" placeholder="Address" required>
            </div>
            <div class="input-group">
                <i class="fas fa-id-card"></i>
                <input type="text" id="driverNIC" name="nic" placeholder="NIC Number" required>
            </div>
            <div class="input-group password-container">
                <i class="fas fa-lock"></i>
                <input type="password" id="driverSignupPassword" name="password" placeholder="Password" required>
                <span class="toggle-password" onclick="togglePassword('driverSignupPassword')">👁</span>
            </div>
            <button type="submit"><i class="fas fa-user-plus"></i> Sign Up</button>
            <a class="toggle-form-link" href="driverLogin.jsp">Already have an account? Login</a>
        </form>
    </div>

    <script>
    function togglePassword(inputId) {
        const passwordInput = document.getElementById(inputId);
        if (passwordInput.type === "password") {
            passwordInput.type = "text";
        } else {
            passwordInput.type = "password";
        }
    }
    
    $(document).ready(function() {
        $('#driverSignupForm').submit(function(event) {
            event.preventDefault();
            
            // Client-side validation
            const phone = $('#driverPhoneNumber').val();
            const nic = $('#driverNIC').val();
            
            // Clear previous error messages
            $('#errorBox').hide().text('');
            $('#messageBox').hide().text('');
            
            if (phone.length !== 10) {
                $('#errorBox').text('Phone number must be 10 digits').show();
                return false;
            }
            
            if (nic.length !== 12) {
                $('#errorBox').text('NIC must be 12 characters').show();
                return false;
            }
            
            // If validation passes, submit via AJAX
            $.ajax({
                type: "POST",
                url: "<%=request.getContextPath()%>/DriverSignupServlet",
                data: $(this).serialize(),
                dataType: "json",
                success: function(response) {
                    if (response.success) {
                        $('#messageBox').text(response.message).show();
                        setTimeout(function() {
                            window.location.href = "driverLogin.jsp";
                        }, 2000);
                    } else {
                        $('#errorBox').text(response.message).show();
                    }
                },
                error: function(xhr, status, error) {
                    $('#errorBox').text("An error occurred: " + error).show();
                }
            });
        });
    });
    </script>
</body>
</html>