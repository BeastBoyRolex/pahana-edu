<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.icbt.model.Bill" %>
<%@ page import="com.icbt.model.BillItem" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>View Bill - Pahana Edu Bookshop</title>
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

    .bill-header {
      text-align: center;
      margin-bottom: 30px;
      padding-bottom: 20px;
      border-bottom: 2px solid #e9ecef;
    }

    .bill-header h2 {
      font-family: 'Montserrat', sans-serif;
      color: var(--primary-color);
      font-weight: 700;
      margin-bottom: 10px;
    }

    .bill-header p {
      color: #6c757d;
      margin: 5px 0;
    }

    .bill-info {
      margin-bottom: 30px;
    }

    .bill-info .row {
      margin-bottom: 20px;
    }

    .bill-info h4 {
      color: var(--primary-color);
      font-weight: 600;
      margin-bottom: 15px;
    }

    .bill-info p {
      margin: 8px 0;
      font-size: 0.95rem;
    }

    .status-badge {
      padding: 8px 16px;
      border-radius: 20px;
      font-size: 0.8rem;
      font-weight: 600;
      text-transform: uppercase;
      display: inline-block;
    }

    .status-pending {
      background-color: rgba(255, 193, 7, 0.2);
      color: #856404;
    }

    .status-paid {
      background-color: rgba(40, 167, 69, 0.2);
      color: #155724;
    }

    .table {
      border-radius: var(--border-radius);
      overflow: hidden;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
      margin-bottom: 30px;
    }

    .table thead th {
      background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
      color: white;
      border: none;
      font-weight: 600;
      padding: 15px;
    }

    .table tbody td {
      padding: 15px;
      vertical-align: middle;
    }

    .bill-footer {
      margin-top: 30px;
      padding-top: 20px;
      border-top: 2px solid #e9ecef;
    }

    .btn {
      display: inline-flex;
      align-items: center;
      gap: 8px;
      font-weight: 500;
      border-radius: var(--border-radius);
      transition: var(--transition);
      padding: 10px 20px;
      margin: 5px;
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

    .btn-success {
      background-color: var(--success-color);
      color: white;
      border: none;
    }

    .btn-success:hover {
      background-color: #218838;
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

    .alert {
      border-radius: var(--border-radius);
      padding: 15px;
      margin-bottom: 25px;
    }

    .alert-success {
      background-color: rgba(40, 167, 69, 0.1);
      color: var(--success-color);
      border-left: 4px solid var(--success-color);
    }

    .alert-danger {
      background-color: rgba(220, 53, 69, 0.1);
      color: var(--danger-color);
      border-left: 4px solid var(--danger-color);
    }

    .total-row {
      background-color: #f8f9fa;
      font-weight: 600;
    }

    .total-row td {
      font-size: 1.1rem;
    }

    @media (max-width: 768px) {
      .container {
        margin: 20px;
        padding: 20px;
      }

      .bill-info .row {
        text-align: center;
      }

      .btn {
        width: 100%;
        justify-content: center;
        margin: 5px 0;
      }
    }
  </style>
</head>
<body>
<div class="container">
  <div class="bill-header">
    <h2><i class="fas fa-book"></i> Pahana Edu Bookshop</h2>
    <p>123 Book Street, Colombo, Sri Lanka</p>
    <p>Phone: +94 11 2345678 | Email: info@pahanaedu.lk</p>
  </div>

  <%
    // Get the bill object from request
    Bill bill = (Bill) request.getAttribute("bill");

    // Setup formatters
    NumberFormat currencyFormat = NumberFormat.getCurrencyInstance();
    currencyFormat.setCurrency(java.util.Currency.getInstance("LKR"));
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

    // Get message and error if they exist
    String message = (String) request.getAttribute("message");
    String error = (String) request.getAttribute("error");
  %>

  <div class="bill-info">
    <div class="row">
      <div class="col-md-6">
        <h4><i class="fas fa-user"></i> Bill To:</h4>
        <p><strong>Account Number:</strong> <%= bill.getAccountNumber() %></p>
      </div>
      <div class="col-md-6 text-end">
        <h4><i class="fas fa-file-invoice"></i> Invoice Details</h4>
        <p><strong>Bill ID:</strong> #<%= bill.getBillId() %></p>
        <p><strong>Bill Date:</strong> <%= dateFormat.format(bill.getBillDate()) %></p>
        <p><strong>Due Date:</strong> <%= dateFormat.format(bill.getDueDate()) %></p>
        <p><strong>Status:</strong>
          <span class="status-badge <%= "PENDING".equalsIgnoreCase(bill.getStatus()) ? "status-pending" : "status-paid" %>">
            <%= bill.getStatus() %>
          </span>
        </p>
      </div>
    </div>
  </div>

  <table class="table table-bordered">
    <thead>
    <tr>
      <th>Description</th>
      <th>Quantity</th>
      <th>Unit Price</th>
      <th>Amount</th>
    </tr>
    </thead>
    <tbody>
    <%
      // Loop through bill items
      if (bill.getItems() != null) {
        for (BillItem item : bill.getItems()) {
    %>
    <tr>
      <td><%= item.getDescription() != null ? item.getDescription() : "N/A" %></td>
      <td><%= item.getQuantity() %></td>
      <td>Rs. <%= String.format("%,.2f", item.getUnitPrice()) %></td>
      <td>Rs. <%= String.format("%,.2f", item.getAmount()) %></td>
    </tr>
    <%
        }
      }
    %>
    </tbody>
    <tfoot>
    <tr class="total-row">
      <td colspan="3" class="text-end"><strong>Total Amount:</strong></td>
      <td><strong>Rs. <%= String.format("%,.2f", bill.getTotalAmount()) %></strong></td>
    </tr>
    </tfoot>
  </table>

  <div class="bill-footer">
    <div class="d-flex justify-content-between flex-wrap">
      <div>
        <%
          if ("PENDING".equalsIgnoreCase(bill.getStatus())) {
        %>
        <form action="bill" method="post" style="display: inline;">
          <input type="hidden" name="action" value="markPaid">
          <input type="hidden" name="billId" value="<%= bill.getBillId() %>">
          <button type="submit" class="btn btn-success" 
                  onclick="return confirm('Are you sure you want to mark this bill as paid?')">
            <i class="fas fa-check"></i> Mark as Paid
          </button>
        </form>
        <%
          }
        %>
        <a href="bill?action=customer&accountNumber=<%= bill.getAccountNumber() %>" class="btn btn-secondary">
          <i class="fas fa-arrow-left"></i> Back to Customer Bills
        </a>
      </div>
      <div>
        <button onclick="window.print()" class="btn btn-primary">
          <i class="fas fa-print"></i> Print Bill
        </button>
        <a href="bill?action=list" class="btn btn-secondary">
          <i class="fas fa-list"></i> All Bills
        </a>
      </div>
    </div>

    <%
      if (message != null && !message.isEmpty()) {
    %>
    <div class="alert alert-success mt-3">
      <i class="fas fa-check-circle"></i> <%= message %>
    </div>
    <%
      }

      if (error != null && !error.isEmpty()) {
    %>
    <div class="alert alert-danger mt-3">
      <i class="fas fa-exclamation-triangle"></i> <%= error %>
    </div>
    <%
      }
    %>
  </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
  $(document).ready(function() {
    // Auto-hide alerts after 5 seconds
    setTimeout(function() {
      $('.alert').fadeOut('slow');
    }, 5000);

    // Print functionality
    $('button[onclick="window.print()"]').click(function() {
      window.print();
    });
  });
</script>
</body>
</html>