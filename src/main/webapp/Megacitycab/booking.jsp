<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            transition: .2s linear;
            text-transform: capitalize;
            text-decoration: none;
        }

        html {
            font-size: 62.5%;
            overflow-x: hidden;
            scroll-behavior: smooth;
        }

        .header {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            padding: 1rem 7%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            z-index: 1000;
            background: linear-gradient(to right, #FFD700, #FFA500);
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .header #logo img {
            height: 50px;
        }

        .header .navbar a {
            color: black;
            font-size: 1.6rem;
            margin-left: 2rem;
            transition: color 0.3s ease;
        }

        .header .navbar a:hover {
            color: #FFF;
        }

        .home-container {
            background-image: url('images/back.png');
            background-size: cover;
            background-position: center;
            padding: 5rem 7%;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .home-content {
            max-width: 1100px;
            width: 100%;
            display: flex;
            flex-wrap: wrap;
            gap: 10rem;
            align-items: stretch;
        }

        .inner-content {
            flex: 1 1 45%;
            padding: 2rem;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .inner-content h3 {
            font-size: 2.8rem;
            color: #040043;
        }

        .inner-content h2 {
            font-size: 4rem;
            font-weight: bold;
            margin-bottom: 1rem;
            color: #040043;
        }

        .inner-content p {
            font-size: 1.3rem;
            padding-bottom: 1.5rem;
            color: #040043;
        }

        .book-image {
            width: 100%;
            max-width: 500px;
            height: auto;
            margin-bottom: 10rem;
        }

        .contact-form {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
            text-align: center;
            color: black;
        }

        .contact-form h1 {
            font-size: 2.8rem;
            color: #FFA500;
            margin-bottom: 1rem;
        }

        .form-fields input, .form-fields select {
            width: 100%;
            padding: 1rem;
            margin-bottom: 1rem;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 1.4rem;
        }

        button {
            background: #FFA500;
            color: white;
            padding: 1rem 2rem;
            border: none;
            border-radius: 5px;
            font-size: 1.4rem;
            cursor: pointer;
            transition: background 0.3s ease;
        }

        button:hover {
            background: #FF8C00;
        }

        /* Footer Styles */
        .footer {
            background: linear-gradient(to right, #FFD700, #FFA500); /* Matching header gradient */
            color: #040043; /* Dark blue text to match title color */
            text-align: center;
            padding: 1rem 7%;
            font-size: 1.2rem;
            margin-top: 2rem;
            position: relative;
            bottom: 0;
            width: 100%;
        }

        @media (max-width: 768px) {
            .home-container {
                padding: 3rem 5%;
            }

            .home-content {
                flex-direction: column;
                gap: 1.5rem;
            }

            .inner-content {
                flex: 1 1 100%;
            }

            .inner-content h2 {
                font-size: 3rem;
            }

            .inner-content h3 {
                font-size: 2.2rem;
            }

            .book-image {
                max-width: 200px;
            }

            .footer {
                padding: 1rem 5%;
            }
        }
    </style>
</head>
<body>
    <header class="header">
        <a href="#" id="logo"><img src="images/logo.png" alt="Mega City Cab Logo"></a>
        <nav class="navbar">
            <a href="userDashboard.jsp">home</a>
            <a href="bookinghelp.jsp">help</a>
            <a href="logout.jsp">logout</a>
            <a href="contact.jsp">contact</a>
        </nav>
    </header>

    <div class="home-container">
        <div class="home-content">
            <div class="inner-content">
                <h3>Best in Colombo</h3>
                <h2>Trusted Cab Service</h2>
                <p>Book your ride within Colombo city for a fast and safe journey.</p>
                <img src="images/booking.png" alt="Book a Cab" class="book-image">
            </div>
            <div class="inner-content">
                <div class="contact-form">
                    <h1>Book a Cab</h1>
                    <form id="CabBookingForm" action="<%=request.getContextPath()%>/CabBookingServlet" method="post" onsubmit="return handleFormSubmit(event, 'CabBookingForm')">
                        <div class="form-fields">
                            <input type="text" id="userid" name="userid" placeholder="User_Id" required>
                            <input type="text" id="name" name="name" placeholder="Name" required>
                            <input type="text" id="phone" name="phone" placeholder="Phone" required>
                            <input type="text" id="pickup" name="pickup" placeholder="Pickup Location (Colombo)" required>
                            <input type="text" id="drop" name="drop" placeholder="Drop Location (Colombo)" required>
                            <select id="carType" name="carType" required>
                                <option value="standard">Economic Class Ride</option>
                                <option value="premium">Premium Class Ride</option>
                                <option value="executive">Executive Class Ride</option>
                            </select>
                            <button type="submit">Book Now</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <footer class="footer">
        © Sri Lanka | Design by: Codewild-j | All Rights Reserved: Megacitycab Service
    </footer>

    <!-- Add JavaScript for form handling if needed -->
    <script>
        function handleFormSubmit(event, formId) {
            event.preventDefault();
            const form = document.getElementById(formId);
            const formData = new FormData(form);
            
            // Example validation (you can expand this)
            const requiredFields = ['userid', 'name', 'phone', 'pickup', 'drop', 'carType'];
            let isValid = true;

            requiredFields.forEach(field => {
                if (!formData.get(field)) {
                    isValid = false;
                    alert(`Please fill in the ${field.replace('carType', 'ride type')} field.`);
                }
            });

            if (isValid) {
                form.submit();
            }
            return false;
        }
    </script>
</body>
</html>