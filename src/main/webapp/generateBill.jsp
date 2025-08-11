<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Generate New Bill - Pahana Edu Bookshop</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&family=Montserrat:wght@600;700&display=swap" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <style>
    :root {
      --primary-color: #4361ee;
      --secondary-color: #3f37c9;
      --accent-color: #4895ef;
      --danger-color: #f72585;
      --success-color: #28a745;
      --warning-color: #ffc107;
      --text-color: #2b2d42;
      --light-color: #f8f9fa;
      --border-radius: 12px;
      --box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
      --transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
    }

    body {
      font-family: 'Poppins', sans-serif;
      background: linear-gradient(135deg, #f5f7fa 0%, #e4e8f0 100%);
      color: var(--text-color);
      line-height: 1.6;
      min-height: 100vh;
      padding: 20px;
    }

    .container {
      max-width: 800px;
      margin: 30px auto;
      background: white;
      border-radius: var(--border-radius);
      box-shadow: var(--box-shadow);
      padding: 30px;
      animation: fadeIn 0.6s ease-out;
      position: relative;
      overflow: hidden;
    }

    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(20px); }
      to { opacity: 1; transform: translateY(0); }
    }

    .container::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 8px;
      background: linear-gradient(90deg, var(--primary-color), var(--accent-color));
    }

    .page-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 30px;
      flex-wrap: wrap;
      gap: 15px;
    }

    .page-header h2 {
      font-family: 'Montserrat', sans-serif;
      color: var(--primary-color);
      font-weight: 700;
      margin: 0;
      position: relative;
      padding-bottom: 10px;
    }

    .page-header h2::after {
      content: '';
      position: absolute;
      bottom: 0;
      left: 0;
      width: 60px;
      height: 3px;
      background: var(--accent-color);
      border-radius: 3px;
    }

    .btn {
      display: inline-flex;
      align-items: center;
      gap: 8px;
      font-weight: 500;
      border-radius: var(--border-radius);
      transition: var(--transition);
      padding: 10px 20px;
    }

    .btn-primary {
      background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
      color: white;
      border: none;
      box-shadow: 0 4px 8px rgba(67, 97, 238, 0.2);
    }

    .btn-primary:hover {
      transform: translateY(-2px);
      box-shadow: 0 6px 12px rgba(67, 97, 238, 0.3);
      color: white;
    }

    .btn-secondary {
      background-color: #6c757d;
      color: white;
      border: none;
    }

    .btn-secondary:hover {
      background-color: #5a6268;
      color: white;
    }

    .btn-outline-secondary {
      border: 2px solid #6c757d;
      color: #6c757d;
      background: transparent;
    }

    .btn-outline-secondary:hover {
      background: rgba(108, 117, 125, 0.05);
      color: #6c757d;
    }

    .btn-danger {
      background-color: var(--danger-color);
      color: white;
      border: none;
    }

    .btn-danger:hover {
      background-color: #dc3545;
      color: white;
    }

    .btn-back {
      background: rgba(255, 255, 255, 0.2);
      color: var(--primary-color);
      border: 2px solid var(--primary-color);
    }

    .btn-back:hover {
      background: rgba(67, 97, 238, 0.05);
      transform: translateY(-2px);
    }

    .alert {
      border-radius: var(--border-radius);
      padding: 15px;
      margin-bottom: 25px;
    }

    .alert-danger {
      background-color: rgba(220, 53, 69, 0.1);
      color: var(--danger-color);
      border-left: 4px solid var(--danger-color);
    }

    .form-control {
      border: 2px solid #e9ecef;
      border-radius: var(--border-radius);
      padding: 12px 15px;
      transition: var(--transition);
    }

    .form-control:focus {
      border-color: var(--accent-color);
      box-shadow: 0 0 0 3px rgba(72, 149, 239, 0.2);
    }

    .item-row {
      margin-bottom: 15px;
      padding: 15px;
      background-color: #f8f9fa;
      border-radius: var(--border-radius);
      transition: var(--transition);
    }

    .item-row:hover {
      background-color: #e9ecef;
    }

    .action-buttons {
      margin-top: 30px;
      display: flex;
      gap: 15px;
      flex-wrap: wrap;
    }

    .section-title {
      font-weight: 600;
      color: var(--primary-color);
      margin: 25px 0 15px;
      position: relative;
      padding-left: 15px;
    }

    .section-title::before {
      content: '';
      position: absolute;
      left: 0;
      top: 5px;
      height: 60%;
      width: 4px;
      background: var(--accent-color);
      border-radius: 4px;
    }

    .floating-books {
      position: absolute;
      width: 100px;
      height: 100px;
      opacity: 0.1;
      z-index: -1;
    }

    .book-1 {
      top: 20px;
      right: 20px;
      background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="%234361ee"><path d="M18 2H6c-1.1 0-2 .9-2 2v16c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2zM6 4h5v8l-2.5-1.5L6 12V4z"/></svg>') no-repeat;
    }

    .book-2 {
      bottom: 20px;
      left: 20px;
      background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="%234361ee"><path d="M18 2H6c-1.1 0-2 .9-2 2v16c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2zM6 4h5v8l-2.5-1.5L6 12V4z"/></svg>') no-repeat;
    }

    @media (max-width: 768px) {
      .container {
        margin: 20px;
        padding: 20px;
      }

      .page-header {
        flex-direction: column;
        align-items: flex-start;
      }

      .action-buttons {
        flex-direction: column;
      }

      .btn {
        width: 100%;
        justify-content: center;
      }

      .item-row .col-md-2 {
        margin-top: 10px;
      }
    }
  </style>
</head>
<body>
<div class="container">
  <div class="floating-books book-1"></div>
  <div class="floating-books book-2"></div>

  <div class="page-header">
    <h2><i class="fas fa-file-invoice-dollar"></i> Generate New Bill</h2>
    <a href="javascript:history.back()" class="btn btn-back">
      <i class="fas fa-arrow-left"></i> Back
    </a>
  </div>

  <%
    String error = (String) request.getAttribute("error");
    if (error != null && !error.isEmpty()) {
  %>
  <div class="alert alert-danger">
    <i class="fas fa-exclamation-circle"></i> <%= error %>
  </div>
  <% } %>

  <form action="bill" method="post">
    <input type="hidden" name="action" value="generate">

    <div class="mb-4">
      <label for="accountNumber" class="form-label">Account Number</label>
      <input type="text" class="form-control" id="accountNumber" name="accountNumber" required>
    </div>

    <div class="row mb-4">
      <div class="col-md-6">
        <label for="billDate" class="form-label">Bill Date</label>
        <input type="date" class="form-control" id="billDate" name="billDate" required>
      </div>
      <div class="col-md-6">
        <label for="dueDate" class="form-label">Due Date</label>
        <input type="date" class="form-control" id="dueDate" name="dueDate" required>
      </div>
    </div>

    <h4 class="section-title">Bill Items</h4>
    <div id="items-container">
      <div class="item-row row">
        <div class="col-md-5">
          <input type="text" class="form-control" name="description" placeholder="Item Description" required>
        </div>
        <div class="col-md-2">
          <input type="number" class="form-control" name="quantity" placeholder="Quantity" min="1" required>
        </div>
        <div class="col-md-3">
          <input type="number" step="0.01" class="form-control" name="unitPrice" placeholder="Unit Price (Rs.)" min="0" required>
        </div>
        <div class="col-md-2">
          <button type="button" class="btn btn-danger remove-item">
            <i class="fas fa-trash"></i> Remove
          </button>
        </div>
      </div>
    </div>

    <div class="action-buttons">
      <button type="button" id="add-item" class="btn btn-secondary">
        <i class="fas fa-plus"></i> Add Item
      </button>
      <button type="submit" class="btn btn-primary">
        <i class="fas fa-file-invoice"></i> Generate Bill
      </button>
      <a href="listBills.jsp" class="btn btn-outline-secondary">
        <i class="fas fa-times"></i> Cancel
      </a>
    </div>
  </form>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/js/all.min.js"></script>
<script>
  $(document).ready(function() {
    $('#add-item').click(function() {
      const newRow = `
        <div class="item-row row">
          <div class="col-md-5">
            <input type="text" class="form-control" name="description" placeholder="Item Description" required>
          </div>
          <div class="col-md-2">
            <input type="number" class="form-control" name="quantity" placeholder="Quantity" min="1" required>
          </div>
          <div class="col-md-3">
            <input type="number" step="0.01" class="form-control" name="unitPrice" placeholder="Unit Price (Rs.)" min="0" required>
          </div>
          <div class="col-md-2">
            <button type="button" class="btn btn-danger remove-item">
              <i class="fas fa-trash"></i> Remove
            </button>
          </div>
        </div>
      `;
      $('#items-container').append(newRow);
    });

    // Remove item row
    $(document).on('click', '.remove-item', function() {
      if ($('.item-row').length > 1) {
        $(this).closest('.item-row').remove();
      } else {
        alert('At least one item is required');
      }
    });

    // Set default dates
    const today = new Date().toISOString().split('T')[0];
    $('#billDate').val(today);

    const dueDate = new Date();
    dueDate.setDate(dueDate.getDate() + 30);
    $('#dueDate').val(dueDate.toISOString().split('T')[0]);
  });
</script>
</body>
</html>