<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MegaCity Cab Services - FAQ</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <style>
        body {
            background-color: #fff3cd;
            color: #333;
            font-family: 'Arial', sans-serif;
        }
        .navbar {
            background-color: #f8a425;
        }
        .navbar-brand {
            font-weight: bold;
            color: #fff !important;
        }
        .faq-container {
            max-width: 900px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .faq-question {
            cursor: pointer;
            padding: 15px;
            border-bottom: 1px solid #eee;
        }
        .faq-answer {
            padding: 15px;
            display: none;
        }
        .faq-question:hover {
            background-color: #f9f9f9;
        }
        .footer {
            background-color: #f8a425;
            color: #fff;
            text-align: center;
            padding: 10px 0;
            position: fixed;
            width: 100%;
            bottom: 0;
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-light">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">MegaCity Cab Services</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item"><a class="nav-link text-white" href="home.jsp">Home</a></li>
                    <li class="nav-item"><a class="nav-link text-white" href="booking.jsp">Booking</a></li>
                    <li class="nav-item"><a class="nav-link text-white" href="contact.jsp">Contact</a></li>
                    <li class="nav-item"><a class="nav-link text-white" href="login.jsp">Login</a></li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- FAQ Section -->
    <div class="faq-container">
        <h2 class="text-center mb-4" style="color: #f8a425;">Frequently Asked Questions (FAQs)</h2>
        <div class="accordion" id="faqAccordion">
            <!-- FAQ 1 -->
            <div class="faq-question" data-bs-toggle="collapse" data-bs-target="#faq1" aria-expanded="false" aria-controls="faq1">
                Can I book a ride for someone else?
            </div>
            <div id="faq1" class="collapse faq-answer" data-bs-parent="#faqAccordion">
                Yes, you can book a ride for someone else by entering their pickup and drop-off details during the booking process and sharing the ride details with them.
            </div>

            <!-- FAQ 2 -->
            <div class="faq-question" data-bs-toggle="collapse" data-bs-target="#faq2" aria-expanded="false" aria-controls="faq2">
                What if I forget my password?
            </div>
            <div id="faq2" class="collapse faq-answer" data-bs-parent="#faqAccordion">
                Use the "Forgot Password" option on the login page to reset your password. Follow the instructions sent to your registered email.
            </div>

            <!-- FAQ 3 -->
            <div class="faq-question" data-bs-toggle="collapse" data-bs-target="#faq3" aria-expanded="false" aria-controls="faq3">
                Are there different ride types available?
            </div>
            <div id="faq3" class="collapse faq-answer" data-bs-parent="#faqAccordion">
                Yes, options like "Economic Class Ride" and "Premium" are available. Select your preferred type during the booking process.
            </div>

            <!-- FAQ 4 -->
            <div class="faq-question" data-bs-toggle="collapse" data-bs-target="#faq4" aria-expanded="false" aria-controls="faq4">
                How can I cancel a booking?
            </div>
            <div id="faq4" class="collapse faq-answer" data-bs-parent="#faqAccordion">
                Go to the booking details page and click the "Cancel Booking" button to cancel your ride. A confirmation message will appear upon successful cancellation.
            </div>

            <!-- FAQ 5 -->
            <div class="faq-question" data-bs-toggle="collapse" data-bs-target="#faq5" aria-expanded="false" aria-controls="faq5">
                How do I view my ride bill?
            </div>
            <div id="faq5" class="collapse faq-answer" data-bs-parent="#faqAccordion">
                From the booking confirmation page, click "Booking Bill" to view the detailed bill, including the total amount and fare breakdown.
            </div>

            <!-- FAQ 6 -->
            <div class="faq-question" data-bs-toggle="collapse" data-bs-target="#faq6" aria-expanded="false" aria-controls="faq6">
                What should I do in an emergency during a ride?
            </div>
            <div id="faq6" class="collapse faq-answer" data-bs-parent="#faqAccordion">
                Use the help feature to submit an emergency request (e.g., robbery, medical emergency, car accident) or call the hotline numbers listed on the contact page.
            </div>

            <!-- FAQ 7 -->
            <div class="faq-question" data-bs-toggle="collapse" data-bs-target="#faq7" aria-expanded="false" aria-controls="faq7">
                How can I provide feedback?
            </div>
            <div id="faq7" class="collapse faq-answer" data-bs-parent="#faqAccordion">
                After your ride, use the feedback form to rate and comment on your experience. Your input helps us improve our services.
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
        <p>&copy; 2025 MegaCity Cab Services. All rights reserved.</p>
    </footer>

    <!-- Bootstrap JS and Popper.js -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
    <!-- Custom JavaScript for FAQ toggle -->
    <script>
        document.querySelectorAll('.faq-question').forEach(question => {
            question.addEventListener('click', () => {
                const answer = question.nextElementSibling;
                if (answer.style.display === 'block') {
                    answer.style.display = 'none';
                } else {
                    answer.style.display = 'block';
                }
            });
        });
    </script>
</body>
</html>