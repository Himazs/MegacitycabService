<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
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

        .header .navbar {
            display: flex;
            gap: 2rem;
        }

        .header .navbar a {
            color: black;
            font-size: 1.6rem;
            transition: color 0.3s ease;
        }

        .header .navbar a:hover {
            color: #FFF;
        }

        #menu-bars {
            display: none;
            font-size: 1.5rem;
            color: #FFF;
            cursor: pointer;
        }

        .about-section {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
            color: white;
            background-image: url(images/hm.jpg);
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
        }

        .content-container {
            max-width: 800px;
            padding: 2rem;
            background-color: rgba(0, 0, 0, 0.5);
            border-radius: 10px;
        }

        h1 {
            font-size: 2.5rem;
            margin-bottom: 1.5rem;
            text-align: center;
            color: #FFD700;
        }

        p {
            font-size: 1.5rem;
            line-height: 1.6;
            margin-bottom: 1rem;
            color: #FFF;
        }

        .main-tariff {
            padding: 3rem 7%;
            background: linear-gradient(to right, #FFD700, #FFA500);
        }

        .main-tariff h1 {
            font-size: 38px;
            text-align: center;
            padding-bottom: 6rem;
            color: black;
        }

        .main-tariff h1 span {
            color: #040043;
        }

        .inner-tarrif {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 15px;
        }

        .tarrif-container {
            flex: 1 1 250px;
            text-align: center;
            padding: 3rem 0;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .tarrif-container:nth-child(2) {
            background: #FFD700;
        }

        .tarrif-container img {
            width: 60%;
            margin-top: -50px;
        }

        .tarrif-container .inner-box h2 {
            font-size: 30px;
            color: black;
            margin-bottom: 1rem;
        }

        .tarrif-container .inner-box p {
            font-size: 1.5rem;
            color: black;
            padding: 1rem;
        }

        .tarrif-container .inner-box h3 {
            font-size: 2rem;
            color: black;
            margin-bottom: 1rem;
        }

        .tarrif-container .inner-box a {
            font-size: 1.5rem;
            padding: 1rem 3rem;
            background: black;
            color: white;
            display: inline-block;
            margin-top: 1rem;
            border-radius: 5px;
            transition: background 0.3s ease;
        }

        .tarrif-container .inner-box a:hover {
            background: #333;
        }

        .fast-booking {
            background: url(images/secbg.png);
            background-size: cover;
            padding: 3rem 7%;
            text-align: center;
        }

        .fast-booking .fast-hading {
            color: #FFD700;
            font-size: 38px;
            padding-top: 2rem;
        }

        .fast-booking h2 {
            font-size: 31px;
            color: white;
            margin-bottom: 3rem;
        }

        .inner-fast {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 2rem;
        }

        .booking-content {
            flex: 1 1 45rem;
            background: rgba(255, 255, 255, 0.1);
            padding: 2rem;
            border-radius: 10px;
        }

        .icon-fast {
            background: linear-gradient(to right, #FFD700, #FFA500);
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
        }

        .icon-fast span i {
            font-size: 2rem;
            color: white;
        }

        .inner-fast-text h1 {
            font-size: 22px;
            color: #FFD700;
            margin-bottom: 1rem;
        }

        .topic-line {
            width: 50%;
            margin: 1rem auto;
            border: 1px solid #FFD700;
        }

        .inner-fast-text p {
            font-size: 1.5rem;
            color: white;
        }

        footer {
            background: linear-gradient(to right, #FFD700, #FFA500);
            color: #000;
            padding: 40px 20px;
        }

        .footer-container {
            display: flex;
            justify-content: space-between;
            padding: 0 50px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .footer-column {
            flex: 1;
            margin: 0 10px;
        }

        .footer-column h3 {
            font-size: 16px;
            color: #000;
            font-weight: 600;
            margin-bottom: 20px;
            text-transform: uppercase;
        }

        .footer-column ul {
            list-style: none;
            padding: 0;
        }

        .footer-column ul li {
            margin-bottom: 10px;
        }

        .footer-column ul li a {
            color: #000;
            text-decoration: none;
            font-size: 14px;
        }

        .footer-column ul li a:hover {
            text-decoration: underline;
        }

        /* Social Media Icons Horizontal Styling */
        .footer-column.social-column ul {
            display: flex;
            justify-content: flex-start;
            gap: 15px; /* Space between icons */
            margin-top: 10px;
        }

        .footer-column.social-column ul li {
            margin-bottom: 0; /* Remove vertical spacing */
        }

        .footer-column.social-column ul li a,
        .footer-column.social-column ul li i {
            font-size: 18px; /* Icon size */
            color: #000; /* Black icons */
            transition: color 0.3s ease, transform 0.3s ease; /* Smooth transition */
        }

        .footer-column.social-column ul li a:hover,
        .footer-column.social-column ul li i:hover {
            color: #FFF; /* White on hover */
            transform: scale(1.2); /* Slight zoom effect */
        }

        .footer-bottom {
            text-align: center;
            margin-top: 30px;
        }

        .footer-bottom p {
            font-size: 12px;
            color: #333;
        }

        .footer-bottom a {
            color: #333;
            text-decoration: none;
        }

        @media (max-width: 768px) {
            html {
                font-size: 50%;
            }

            #menu-bars {
                display: initial;
            }

            .navbar {
                position: absolute;
                top: -100%;
                right: 0;
                left: 0;
                background: rgba(0, 0, 0, 0.9);
            }

            .navbar a {
                display: block;
                font-size: 1.5rem;
                background: #FFD700;
                margin: 1rem;
                padding: 1rem;
            }

            .header {
                padding: 2rem;
            }

            .footer-container {
                flex-direction: column;
                padding: 0 20px;
            }

            .footer-column {
                margin-bottom: 20px;
            }

            .footer-column.social-column ul {
                justify-content: center; /* Center icons on mobile */
            }
        }
    </style>
</head>
<body>
    <header class="header">
        <a href="#" id="logo"><img src="images/logo.png" alt=""></a>
        <nav class="navbar">
       
            <a href="#">About</a> 
            <a href="http://localhost:8080/Citycab/Megacitycab/index.jsp">login</a>
            <a href="http://localhost:8080/Citycab/Megacitycab/signup.jsp">signup</a>
            <a href="contact.jsp" id="contact-link">Contact</a>
        </nav>
        <a href="#" id="menu-bars" class="fas fa-bars"></a>
    </header>

    <section class="about-section">
        <div class="content-container">
            <h1>About Mega City Cab</h1><br>
            <p>Welcome to Mega City Cab, your trusted partner for all your transportation needs in Colombo, Sri Lanka. Whether you're heading to the airport, attending an important meeting, or simply need a ride around the city, we've got you covered.</p><br>
            <p>At Mega City Cab, we pride ourselves on providing a safe, efficient, and comfortable ride exclusively in Colombo. Our fleet of modern vehicles is equipped with everything you need to make your journey pleasant, while our professional drivers ensure timely and reliable service every time.</p>
            <p>With our easy-to-use booking system, you can request a ride anytime, anywhere in Colombo. Choose Mega City Cab for a premium transportation experience that you can rely on.</p>
        </div>
    </section>

    <div class="main-tariff">
        <h1>our <span>tarrif</span></h1>
        <div class="inner-tarrif">
            <div class="tarrif-container">
                <div class="inner-box">
                    <img src="images/img2.png" alt="">
                    <h2>Economic Class Ride</h2>
                    <p>Affordable and reliable rides for everyday travel. Perfect for short trips and budget-conscious travelers.</p>
                    <h3>Per Km Rs.150/=</h3>
                  
                </div>
            </div>
            <div class="tarrif-container">
                <div class="inner-box">
                    <img src="images/image1.png" alt="">
                    <h2>Premium Class Ride</h2>
                    <p>Experience luxury and comfort with our premium vehicles. Ideal for business trips and special occasions.</p>
                    <h3>Per Km Rs.350/=</h3>
                   
                </div>
            </div>
            <div class="tarrif-container">
                <div class="inner-box">
                    <img src="images/carmain.png" alt="">
                    <h2>Executive Class Ride</h2>
                    <p>Top-tier service with high-end vehicles and professional drivers. Designed for executives and VIPs.</p>
                    <h3>Per Km Rs.500/=</h3>
                  
                </div>
            </div>
        </div>
    </div>

    <div class="fast-booking">
        <h1 class="fast-hading">we do best</h1>
        <h2>than you wish</h2>
        <div class="inner-fast">
            <div class="booking-content">
                <div class="icon-fast">
                    <span><i class="fas fa-clock"></i></span>
                </div>
                <div class="inner-fast-text">
                    <h1>Fast Booking</h1>
                    <hr class="topic-line">
                    <p>Book your ride in seconds with our user-friendly app. Get instant confirmation and real-time updates on your driver's arrival.</p>
                </div>
            </div>
            <div class="booking-content">
                <div class="icon-fast">
                    <span><i class="fas fa-shield-alt"></i></span>
                </div>
                <div class="inner-fast-text">
                    <h1>Secure Ride</h1>
                    <hr class="topic-line">
                    <p>Your safety is our priority. All our drivers are verified, and vehicles are regularly inspected to ensure a secure journey.</p>
                </div>
            </div>
            <div class="booking-content">
                <div class="icon-fast">
                    <span><i class="fas fa-wallet"></i></span>
                </div>
                <div class="inner-fast-text">
                    <h1>Easy Payment</h1>
                    <hr class="topic-line">
                    <p>Choose from multiple payment options, including credit cards, mobile wallets, and cash. Enjoy hassle-free transactions.</p>
                </div>
            </div>
            <div class="booking-content">
                <div class="icon-fast">
                    <span><i class="fas fa-car"></i></span>
                </div>
                <div class="inner-fast-text">
                    <h1>Quick Pick-up</h1>
                    <hr class="topic-line">
                    <p>Our drivers are always nearby, ensuring quick pick-ups and minimal waiting time. Reach your destination faster.</p>
                </div>
            </div>
        </div>
    </div>

    <footer>
        <div class="footer-container">
           <div class="footer-column">
    <h3>CONTACT US</h3>
    <ul style="color: black;  font-size: 13px;">
        <li>+94117433433</li>
        <li>Colombo 5</li>
        <li>Havelock Town, Narahenpita.</li>
        <li>megacitycabservice@gmail.com</li>
    </ul>
</div>

            <div class="footer-column">
                <h3>LOGIN</h3>
                <ul>
                    <li><a href="http://localhost:8080/Citycab/Megacitycab/userLogin.jsp">User Login</a></li>
                    <li><a href="http://localhost:8080/Citycab/Megacitycab/driverLogin.jsp">Driver Login</a></li>
                    <li><a href="http://localhost:8080/Citycab/Megacitycab/adminLogin.jsp">Admin Login</a></li>
                </ul>
            </div>
            <div class="footer-column">
                <h3>COMPANY INFO</h3>
                   <ul>
                       <li><a href="home.jsp">home</a></li>
                    <li><a href="#">about</a></li>
                    <li><a href="booking.jsp">booking</a></li>
                    <li><a href="userhelp.jsp">help</a></li>
                    <li><a href="contact.jsp">contact</a></li>
                    <li><a href="logout.jsp">logout</a></li>
          
                </ul>
                
            </div>
            <div class="footer-column social-column">
                <h3>FOLLOW US</h3>
                <ul>
                    <li><a href="https://www.facebook.com/profile.php?id=100093469936738&mibextid=ZbWKwL" target="_blank"><i class="fab fa-facebook-f"></i></a></li>
                    <li><a href="#"><i class="fab fa-twitter"></i></a></li>
                    <li><a href="#"><i class="fab fa-instagram"></i></a></li>
                    <li><a href="#"><i class="fab fa-linkedin-in"></i></a></li>
                </ul>
            </div>
        </div>
        <div class="footer-bottom">
          <p style="color: white; font-weight: bold;">
 <a href="#" style="color: darkblue; font-size: 16px; font-weight: bold;">© Sri Lanka | Design by: Codewild-j | All Rights Reserved: Megacitycab Service</a> 
   <a href="#" style="color: white; font-weight: bold;"></a>
</p>


        </div>
    </footer>
</body>
</html>