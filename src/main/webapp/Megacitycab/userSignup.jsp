<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Sign Up</title>
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
            display: block;
        }

        .toggle-form-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <a href="#" id="logo"><img src="images/logo.png" alt="Logo"></a>
        
        <div id="messageBox" class="success-message"></div>
        <div id="errorBox" class="error-message"></div>
        
        <form id="userSignupForm">
            <input type="hidden" name="role" value="User">
            <h2><i class="fas fa-user-plus"></i> User Sign Up</h2>
            <div class="input-group">
                <i class="fas fa-user"></i>
                <input type="text" id="userSignupName" name="name" placeholder="Name" required>
            </div>
            <div class="input-group">
                <i class="fas fa-envelope"></i>
                <input type="email" id="userSignupEmail" name="email" placeholder="Email" required>
            </div>
            <div class="input-group">
                <i class="fas fa-phone"></i>
                <input type="text" id="userPhoneNumber" name="phoneNumber" placeholder="Phone Number" required>
            </div>
            <div class="input-group">
                <i class="fas fa-map-marker-alt"></i>
                <input type="text" id="userAddress" name="address" placeholder="Address" required>
            </div>
            <div class="input-group">
                <i class="fas fa-id-card"></i>
                <input type="text" id="userNIC" name="nic" placeholder="NIC Number" required>
            </div>
            <div class="input-group password-container">
                <i class="fas fa-lock"></i>
                <input type="password" id="userSignupPassword" name="password" 
                       pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}"
                       title="Must contain at least one number, one uppercase and lowercase letter, and at least 8 characters"
                       placeholder="Password" required>
                <span class="toggle-password" onclick="togglePassword('userSignupPassword')">👁</span>
            </div>
            <button type="submit"><i class="fas fa-user-plus"></i> Sign Up</button>
            <a class="toggle-form-link" href="userLogin.jsp">Already have an account? Login</a>
        </form>
    </div>

    <script>
    function togglePassword(inputId) {
        const passwordInput = document.getElementById(inputId);
        passwordInput.type = passwordInput.type === "password" ? "text" : "password";
    }
    
    $(document).ready(function() {
        $('#userSignupForm').submit(function(event) {
            event.preventDefault();
            
            // Client-side validation
            const phone = $('#userPhoneNumber').val();
            const nic = $('#userNIC').val();
            
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
            
            // Loading state
            const $button = $('button[type="submit"]');
            $button.prop('disabled', true).text('Signing Up...');
            
            $.ajax({
                type: "POST",
                url: "<%=request.getContextPath()%>/UserSignupServlet",
                data: $(this).serialize(),
                dataType: "json",
                success: function(response) {
                    if (response.success) {
                        $('#messageBox').text(response.message).show();
                        setTimeout(function() {
                            window.location.href = "userLogin.jsp";
                        }, 2000);
                    } else {
                        $('#errorBox').text(response.message).show();
                    }
                },
                error: function(xhr, status, error) {
                    $('#errorBox').text("An error occurred: " + error).show();
                },
                complete: function() {
                    $button.prop('disabled', false).text('Sign Up');
                }
            });
        });
    });
    </script>
</body>
</html>