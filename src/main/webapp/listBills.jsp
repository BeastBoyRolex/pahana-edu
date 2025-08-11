<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Bill Management</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <style>
    :root {
      --primary-color: #4361ee;
      --secondary-color: #3f37c9;
      --accent-color: #4cc9f0;
      --light-color: #f8f9fa;
      --dark-color: #212529;
      --success-color: #4bb543;
      --danger-color: #ff3333;
    }

    body {
      background-color: #f5f7ff;
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }

    .container {
      max-width: 1200px;
      margin-top: 20px;
      margin-bottom: 40px;
    }

    .card {
      border-radius: 15px;
      border: none;
      box-shadow: 0 10px 20px rgba(0, 0, 0, 0.08);
      transition: transform 0.3s ease, box-shadow 0.3s ease;
      overflow: hidden;
    }

    .card:hover {
      transform: translateY(-5px);
      box-shadow: 0 15px 30px rgba(0, 0, 0, 0.12);
    }

    .card-header {
      background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
      color: white;
      border-bottom: none;
      padding: 1.25rem 1.5rem;
    }

    .btn-primary {
      background-color: var(--primary-color);
      border-color: var(--primary-color);
      padding: 0.5rem 1.5rem;
      border-radius: 50px;
      font-weight: 500;
      transition: all 0.3s ease;
    }

    .btn-primary:hover {
      background-color: var(--secondary-color);
      border-color: var(--secondary-color);
      transform: translateY(-2px);
    }

    .btn-outline-primary {
      color: var(--primary-color);
      border-color: var(--primary-color);
      border-radius: 50px;
    }

    .btn-outline-primary:hover {
      background-color: var(--primary-color);
      border-color: var(--primary-color);
    }

    .status-pending {
      color: var(--danger-color);
      font-weight: 600;
    }

    .status-paid {
      color: var(--success-color);
      font-weight: 600;
    }

    .action-buttons {
      white-space: nowrap;
    }

    .search-box {
      background: white;
      border-radius: 15px;
      padding: 2rem;
    }

    .page-title {
      color: var(--dark-color);
      font-weight: 700;
      position: relative;
      display: inline-block;
    }

    .page-title:after {
      content: '';
      position: absolute;
      bottom: -10px;
      left: 0;
      width: 60px;
      height: 4px;
      background: var(--accent-color);
      border-radius: 2px;
    }

    .back-btn {
      background-color: white;
      color: var(--primary-color);
      border: 2px solid var(--primary-color);
      border-radius: 50px;
      padding: 0.5rem 1rem 0.5rem 0.8rem;
      font-weight: 500;
      transition: all 0.3s ease;
      display: inline-flex;
      align-items: center;
      margin-right: 15px;
    }

    .back-btn:hover {
      background-color: var(--primary-color);
      color: white;
      transform: translateX(-3px);
    }

    .back-btn i {
      margin-right: 5px;
      transition: all 0.3s ease;
    }

    .back-btn:hover i {
      transform: translateX(-3px);
    }

    .alert {
      border-radius: 10px;
      border-left: 5px solid;
    }

    .alert-success {
      border-left-color: var(--success-color);
    }

    .alert-danger {
      border-left-color: var(--danger-color);
    }

    .input-group-text {
      background-color: var(--primary-color);
      color: white;
      border: none;
    }

    .form-control {
      border-radius: 50px;
      padding: 0.5rem 1rem;
    }

    .form-control:focus {
      border-color: var(--accent-color);
      box-shadow: 0 0 0 0.25rem rgba(67, 97, 238, 0.25);
    }
  </style>
</head>
<body>
<div class="container">
  <div class="d-flex justify-content-between align-items-center mb-4">
    <div class="d-flex align-items-center">
      <button onclick="history.back()" class="back-btn">
        <i class="fas fa-arrow-left"></i> Back
      </button>
      <h2 class="page-title mb-0">Bill Management</h2>
    </div>
    <a href="generateBill.jsp" class="btn btn-primary">
      <i class="fas fa-file-invoice-dollar me-2"></i>Generate New Bill
    </a>
  </div>

  <div class="card mb-4">
    <div class="card-header">
      <h5 class="mb-0"><i class="fas fa-search me-2"></i>Find Customer Bills</h5>
    </div>
    <div class="card-body">
      <form action="bill" method="get" class="row g-3 align-items-center">
        <input type="hidden" name="action" value="customerBills">
        <div class="col-md-8">
          <div class="input-group">
            <span class="input-group-text"><i class="fas fa-user"></i></span>
            <input type="text" name="accountNumber" class="form-control" placeholder="Enter Customer Account Number" required>
          </div>
        </div>
        <div class="col-md-4">
          <button type="submit" class="btn btn-primary w-100">
            <i class="fas fa-search me-2"></i>Search Bills
          </button>
        </div>
      </form>
    </div>
  </div>

  <%
    String message = (String) request.getAttribute("message");
    if (message != null && !message.isEmpty()) {
  %>
  <div class="alert alert-success alert-dismissible fade show">
    <i class="fas fa-check-circle me-2"></i><%= message %>
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  </div>
  <%
    }
    String error = (String) request.getAttribute("error");
    if (error != null && !error.isEmpty()) {
  %>
  <div class="alert alert-danger alert-dismissible fade show">
    <i class="fas fa-exclamation-circle me-2"></i><%= error %>
    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
  </div>
  <%
    }
  %>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
  // Add smooth back button functionality
  document.querySelector('.back-btn').addEventListener('click', function(e) {
    e.preventDefault();
    history.back();
  });
</script>
</body>
</html>