<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>MegaCityCab - Help</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            margin: 0;
            background-image: url('images/back.png');
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .container {
            max-width: 900px; /* Increased from 700px to 900px for a larger form */
            background: linear-gradient(to right, #ffd407, #ffffff);
            padding: 40px; /* Increased padding for more internal space */
            border-radius: 15px; /* Slightly larger border radius */
            box-shadow: 0 6px 25px rgba(0, 0, 0, 0.15); /* Enhanced shadow */
            border: 1px solid #e0e0e0;
        }
        .header {
            text-align: center;
            padding-bottom: 25px; /* Slightly more padding */
            border-bottom: 2px solid #f5f5f5;
        }
        .header h1 {
            color: #1a73e8;
            font-size: 32px; /* Larger font size */
            margin: 0;
        }
        .header p {
            color: #666;
            font-size: 16px; /* Slightly larger font */
            margin: 8px 0 0;
        }
        .form-container {
            margin-top: 25px; /* Increased margin */
        }
        .form-group {
            margin-bottom: 25px; /* Increased spacing between groups */
        }
        label {
            display: block;
            font-weight: 600;
            color: #333;
            margin-bottom: 8px; /* More space below label */
            font-size: 18px; /* Larger font size */
        }
        select, textarea {
            width: 100%;
            padding: 12px; /* Increased padding */
            border: 1px solid #ccc;
            border-radius: 6px; /* Slightly larger radius */
            font-size: 18px; /* Larger font size */
            box-sizing: border-box;
        }
        textarea {
            height: 200px; /* Increased height for larger textarea */
            resize: vertical;
        }
        .submit-btn {
            background-color: #1a73e8;
            color: white;
            border: none;
            padding: 15px 25px; /* Larger padding */
            border-radius: 6px;
            cursor: pointer;
            font-size: 18px; /* Larger font size */
            width: 100%;
            transition: background-color 0.3s ease;
        }
        .submit-btn:hover {
            background-color: #1557b0;
        }
        .success-message {
            background-color: #d4edda;
            color: #155724;
            padding: 12px; /* Increased padding */
            margin-bottom: 20px;
            border-radius: 6px;
            display: none;
            text-align: center;
            font-size: 16px; /* Larger font size */
        }
        .error-message {
            background-color: #f8d7da;
            color: #721c24;
            padding: 12px; /* Increased padding */
            margin-bottom: 20px;
            border-radius: 6px;
            display: none;
            text-align: center;
            font-size: 16px; /* Larger font size */
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>MegaCityCab</h1>
            <p>Help & Support</p>
        </div>

        <div class="form-container">
            <div id="messageBox" class="success-message"></div>
            <div id="errorBox" class="error-message"></div>
            
            <form id="helpForm" method="POST">
                <div class="form-group">
                    <label for="issue">Select Issue:</label>
                    <select name="issue" id="issue" required>
                        <option value="">Select Issue</option>
                        <option value="robbery">Robbery/Assault</option>
                        <option value="medical">Medical Emergency</option>
                        <option value="accident">Car Accident</option>
                        <option value="payment">Payment Issue</option>
                        <option value="gps">GPS/App Failure</option>
                        <option value="client">Client Issue</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="description">Description:</label>
                    <textarea name="description" id="description" placeholder="Please provide details about the issue..." required></textarea>
                </div>
                <button type="submit" class="submit-btn">Submit Request</button>
            </form>
        </div>
    </div>

    <script>
    $(document).ready(function() {
        $('#helpForm').submit(function(event) {
            event.preventDefault();

            // Clear previous messages
            $('#messageBox').hide().text('');
            $('#errorBox').hide().text('');

            // Get form values
            const issue = $('#issue').val();
            const description = $('#description').val().trim();

            // Client-side validation
            if (!issue) {
                $('#errorBox').text('Please select an issue').show();
                return;
            }
            if (!description) {
                $('#errorBox').text('Please provide a description').show();
                return;
            }

            // Loading state
            const $button = $('.submit-btn');
            $button.prop('disabled', true).text('Submitting...');

            // AJAX submission
            $.ajax({
                type: "POST",
                url: "<%=request.getContextPath()%>/HelpServlet",
                data: $(this).serialize(),
                dataType: "json",
                success: function(response) {
                    if (response.success) {
                        $('#messageBox').text(response.message).show();
                        setTimeout(function() {
                            $('#helpForm')[0].reset();
                            $('#messageBox').hide();
                        }, 2000);
                    } else {
                        $('#errorBox').text(response.message).show();
                    }
                },
                error: function(xhr, status, error) {
                    $('#errorBox').text("An error occurred: " + error).show();
                },
                complete: function() {
                    $button.prop('disabled', false).text('Submit Request');
                }
            });
        });
    });
    </script>
</body>
</html>