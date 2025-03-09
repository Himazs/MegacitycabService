<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact - Mega City Cab</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
               background-image: url(images/back.png);
            color: #333;
        }

        .header {
            background: url('images/bg.png') no-repeat center center;
            background-size: cover;
            padding: 40px 7%;
            text-align: center;
            color: white;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .header h1 {
            font-size: 2.5rem;
            font-weight: bold;
            text-transform: uppercase;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
            display: flex;
            justify-content: space-between;
            gap: 50px;
        }

        .contact-form, .hotlines {
            flex: 1;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .contact-form h2 {
            font-size: 1.8rem;
            color: #333;
            margin-bottom: 15px;
        }

        .contact-form p {
            font-size: 1rem;
            color: #666;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-size: 1rem;
            color: #666;
        }

        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 1rem;
            background-color: #f9f9f9;
        }

        .form-group textarea {
            height: 100px;
            resize: vertical;
        }

        .submit-btn {
            background-color: #ff9100;
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 4px;
            font-size: 1.1rem;
            cursor: pointer;
            transition: background-color 0.3s ease;
            width: 100%;
        }

        .submit-btn:hover {
            background-color: #e07b00;
        }

        .hotlines h2 {
            font-size: 1.5rem;
            color: #333;
            margin-bottom: 20px;
        }

        .hotlines p {
            font-size: 1rem;
            color: #666;
            margin-bottom: 10px;
        }

        .hotlines a {
            color: #ff9100;
            text-decoration: none;
        }

        .hotlines a:hover {
            text-decoration: underline;
        }

        .car-icon {
            position: absolute;
            right: 20px;
            bottom: 20px;
            width: 100px;
            opacity: 0.5;
        }
    </style>
</head>

<body>
    <header class="header">
        <h1>CONTACT US</h1>
    </header>
<br><br><br>
    <div class="container">
        <div class="contact-form">
            <h2>Get in Touch</h2>
            <p>We would love to hear from you. Get in touch with us by email.</p>

            <% 
                String successMsg = (String) request.getAttribute("successMsg");
                String errorMsg = (String) request.getAttribute("errorMsg");
                if (successMsg != null) {
            %>
                <p style="color: green;"><%= successMsg %></p>
            <% 
                } else if (errorMsg != null) {
            %>
                <p style="color: red;"><%= errorMsg %></p>
            <% 
                }
            %>

            <form action="<%=request.getContextPath()%>/ContactServlet" method="post">
                <div class="form-group">
                    <label for="name">Name</label>
                    <input type="text" id="name" name="name" required>
                </div>
                <div class="form-group">
                    <label for="email">Email Address*</label>
                    <input type="email" id="email" name="email" required>
                </div>
                <div class="form-group">
                    <label for="message">Your Message*</label>
                    <textarea id="message" name="message" required></textarea>
                </div>
                <button type="submit" class="submit-btn">SUBMIT</button>
            </form>
        </div>

        <div class="hotlines">
            <h2>Hotlines</h2>
            <p><strong>General Inquiries</strong><br> +94 117 434 343</p>
            <p><strong>Media & Marketing</strong><br> social@megacitycab.lk</p>
            <p><strong>Business Inquiries</strong><br> +94 114 507 500<br> business@megacitycab.lk</p>
            <p><strong>Careers</strong><br> careers@megacitycab.lk</p>
            <p><strong>Inquiries on Affiliations (Driver or Fleet Owner)</strong><br> +94 114 507 555<br> registration@megacitycab.lk</p>
        </div>
    </div>

    <img src="https://via.placeholder.com/100" alt="Car Icon" class="car-icon">
</body>
</html>