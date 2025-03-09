<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Driver Profile</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <div class="row">
            <div class="col-md-8 offset-md-2">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h2>Driver Profile</h2>
                    </div>
                    <div class="card-body">
                        <c:if test="${not empty message}">
                            <div class="alert alert-success" role="alert">
                                ${message}
                            </div>
                        </c:if>
                        
                        <div class="row mb-3">
                            <div class="col-md-4 fw-bold">Driver ID:</div>
                            <div class="col-md-8">${driver.driverId}</div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-4 fw-bold">Name:</div>
                            <div class="col-md-8">${driver.name}</div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-4 fw-bold">Email:</div>
                            <div class="col-md-8">${driver.email}</div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-4 fw-bold">Phone:</div>
                            <div class="col-md-8">${driver.phone}</div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-4 fw-bold">License Number:</div>
                            <div class="col-md-8">${driver.licenseNumber}</div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-4 fw-bold">Address:</div>
                            <div class="col-md-8">${driver.address}</div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-md-4 fw-bold">Status:</div>
                            <div class="col-md-8">${driver.status}</div>
                        </div>
                        
                        <div class="mt-4">
                            <a href="DriverController?action=editProfile&driverId=${driver.driverId}" class="btn btn-primary">Edit Profile</a>
                            <button type="button" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#changePasswordModal">
                                Change Password
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Change Password Modal -->
    <div class="modal fade" id="changePasswordModal" tabindex="-1" aria-labelledby="changePasswordModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <form action="DriverController" method="post">
                    <input type="hidden" name="action" value="updatePassword">
                    <input type="hidden" name="driverId" value="${driver.driverId}">
                    
                    <div class="modal-header">
                        <h5 class="modal-title" id="changePasswordModalLabel">Change Password</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <label for="newPassword" class="form-label">New Password</label>
                            <input type="password" class="form-control" id="newPassword" name="newPassword" required>
                        </div>
                        <div class="mb-3">
                            <label for="confirmPassword" class="form-label">Confirm Password</label>
                            <input type="password" class="form-control" id="confirmPassword" required>
                            <div id="passwordError" class="text-danger d-none">Passwords do not match</div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-primary" id="submitPassword">Save Changes</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
    <script>
        // Client-side password validation
        document.getElementById('confirmPassword').addEventListener('input', function() {
            var newPassword = document.getElementById('newPassword').value;
            var confirmPassword = this.value;
            var passwordError = document.getElementById('passwordError');
            var submitButton = document.getElementById('submitPassword');
            
            if (newPassword !== confirmPassword) {
                passwordError.classList.remove('d-none');
                submitButton.disabled = true;
            } else {
                passwordError.classList.add('d-none');
                submitButton.disabled = false;
            }
        });
    </script>
</body>
</html>

