<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Book a Cab</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
             background-image: url(images/bg.png);
            min-height: 100vh;
            padding: 20px;
        }
        .instructions-container {
            background: white;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }
        h2 { font-size: 1.25rem; }
        p, li { font-size: 0.9rem; }
    </style>
</head>
<br><br><br>
<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-12 col-md-6">
                <div class="instructions-container mt-3">
                    <h1 class="text-center text-warning mb-3">How to Book a Cab</h1>
                    
                    <section class="mb-3">
                        <h2 class="text-dark">1. User ID</h2>
                        <p class="text-muted">Enter the User ID from your dashboard.</p>
                    </section>

                    <section class="mb-3">
                        <h2 class="text-dark">2. Name</h2>
                        <p class="text-muted">Type your full name (e.g., Mohammed Rasid).</p>
                    </section>

                    <section class="mb-3">
                        <h2 class="text-dark">3. Phone</h2>
                        <p class="text-muted">Enter a valid number (e.g., +94 123 456 789).</p>
                    </section>

                    <section class="mb-3">
                        <h2 class="text-dark">4. Pickup</h2>
                        <p class="text-muted">Specify pickup spot in Colombo (e.g., 123 Main St, Colombo 03).</p>
                    </section>

                    <section class="mb-3">
                        <h2 class="text-dark">5. Drop-off</h2>
                        <p class="text-muted">Specify drop-off spot in Colombo (e.g., 456 Park Ave, Colombo 07).</p>
                    </section>

                    <section class="mb-3">
                        <h2 class="text-dark">6. Ride Class</h2>
                        <ul class="list-unstyled text-muted">
                            <li>• Economic: 150 LKR/km</li>
                            <li>• Premium: 350 LKR/km</li>
                            <li>• Executive: 500 LKR/km</li>
                        </ul>
                    </section>

                    <section>
                        <h2 class="text-dark">7. Submit</h2>
                        <p class="text-muted">Click "Book Now" to confirm.</p>
                    </section>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>