<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register New Car</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-image: url(images/back.png);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .form-container {
            background: linear-gradient(to right, #ffd407, #ffffff); 
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
            text-align: center;
        }

        h2 {
            margin: 0 0 20px;
            font-size: 24px;
            color: #333;
        }

        .input-group {
            position: relative;
            margin-bottom: 15px;
            text-align: left;
        }

        .input-group i {
            position: absolute;
            left: 10px;
            top: 50%;
            transform: translateY(-50%);
            color: #777;
        }

        .input-group input {
            width: 100%;
            padding: 10px 10px 10px 40px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 14px;
            box-sizing: border-box;
        }

        button {
            background-color: #1c185e;
            color: #fff;
            padding: 12px 20px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            width: 100%;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #0056b3;
        }

        .toggle-form-link {
            display: block;
            margin-top: 20px;
            color: #007bff;
            text-decoration: none;
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
        <h2>Register New Car</h2>
        
        <div id="messageBox" class="success-message"></div>
        <div id="errorBox" class="error-message"></div>
        
        <form id="carRegisterForm" method="post">
            <div class="input-group">
                <i class="fas fa-id-card"></i>
                <input type="number" name="driverid" placeholder="Driver ID" required>
            </div>
            <div class="input-group">
                <i class="fas fa-calendar-alt"></i>
                <input type="number" name="year" placeholder="Year" required>
            </div>
            <div class="input-group">
                <i class="fas fa-chair"></i>
                <input type="number" name="seats" placeholder="Seats" required>
            </div>
            <div class="input-group">
                <i class="fas fa-car"></i>
                <input type="text" name="make" placeholder="Make" required>
            </div>
            <div class="input-group">
                <i class="fas fa-car-side"></i>
                <input type="text" name="model" placeholder="Model" required>
            </div>
            <div class="input-group">
                <i class="fas fa-list"></i>
                <input type="text" name="licensePlate" placeholder="License Plate" required>
            </div>
            <div class="input-group">
                <i class="fas fa-palette"></i>
                <input type="text" name="color" placeholder="Color" required>
            </div>
            <button type="submit">Submit</button>
        </form>
    </div>

    <script>
    $(document).ready(function() {
        $('#carRegisterForm').submit(function(event) {
            event.preventDefault();

            // Clear previous messages
            $('#messageBox').hide().text('');
            $('#errorBox').hide().text('');

            // Get form values
            const driverId = $('input[name="driverid"]').val().trim();
            const year = $('input[name="year"]').val().trim();
            const seats = $('input[name="seats"]').val().trim();
            const make = $('input[name="make"]').val().trim();
            const model = $('input[name="model"]').val().trim();
            const licensePlate = $('input[name="licensePlate"]').val().trim();
            const color = $('input[name="color"]').val().trim();

            // Client-side validation
            if (!driverId || isNaN(driverId) || parseInt(driverId) <= 0) {
                $('#errorBox').text('Please enter a valid Driver ID').show();
                return;
            }
            if (!year || isNaN(year) || parseInt(year) < 1900 || parseInt(year) > new Date().getFullYear()) {
                $('#errorBox').text('Please enter a valid year between 1900 and ' + new Date().getFullYear()).show();
                return;
            }
            if (!seats || isNaN(seats) || parseInt(seats) < 1 || parseInt(seats) > 20) {
                $('#errorBox').text('Please enter a valid number of seats (1-20)').show();
                return;
            }
            if (!make || !model || !licensePlate || !color) {
                $('#errorBox').text('All fields are required').show();
                return;
            }

            // Loading state
            const $button = $('button[type="submit"]');
            $button.prop('disabled', true).text('Submitting...');

            // AJAX submission
            $.ajax({
                type: "POST",
                url: "<%=request.getContextPath()%>/AddCarController",
                data: $(this).serialize(),
                dataType: "json",
                success: function(response) {
                    if (response.success) {
                        $('#messageBox').text(response.message).show();
                        setTimeout(function() {
                            
                        }, 2000);
                    } else {
                        $('#errorBox').text(response.message).show();
                    }
                },
                error: function(xhr, status, error) {
                    $('#errorBox').text("An error occurred: " + error).show();
                },
                complete: function() {
                    $button.prop('disabled', false).text('Submit');
                }
            });
        });
    });
    </script>
</body>
</html>