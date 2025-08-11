<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.icbt.model.Bill" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Customer Bills - Pahana Edu Bookshop</title>
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
      max-width: 1200px;
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

    .btn-group {
      display: flex;
      gap: 10px;
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

    .btn-outline-primary {
      border: 2px solid var(--primary-color);
      color: var(--primary-color);
      background: transparent;
    }

    .btn-outline-primary:hover {
      background: rgba(67, 97, 238, 0.05);
      color: var(--primary-color);
      transform: translateY(-2px);
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

    .alert-info {
      background-color: rgba(23, 162, 184, 0.1);
      color: #17a2b8;
      border-left: 4px solid #17a2b8;
    }

    .table-container {
      overflow-x: auto;
      border-radius: var(--border-radius);
      margin: 30px 0;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
    }

    .table {
      width: 100%;
      border-collapse: separate;
      border-spacing: 0;
      background: white;
      border-radius: var(--border-radius);
      overflow: hidden;
    }

    .table th {
      background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
      color: white;
      font-weight: 600;
      text-align: left;
      padding: 16px 20px;
      position: sticky;
      top: 0;
    }

    .table td {
      padding: 14px 20px;
      border-bottom: 1px solid rgba(0, 0, 0, 0.05);
      vertical-align: middle;
    }

    .table tr:last-child td {
      border-bottom: none;
    }

    .table tr:hover td {
      background-color: rgba(72, 149, 239, 0.05);
    }

    .table th:first-child {
      border-top-left-radius: var(--border-radius);
    }

    .table th:last-child {
      border-top-right-radius: var(--border-radius);
    }

    .status-pending {
      color: var(--danger-color);
      font-weight: 500;
    }

    .status-paid {
      color: var(--success-color);
      font-weight: 500;
    }

    .action-buttons {
      display: flex;
      gap: 8px;
      flex-wrap: wrap;
    }

    .btn-sm {
      padding: 6px 12px;
      font-size: 14px;
      border-radius: 6px;
    }

    .btn-info {
      background-color: #17a2b8;
      color: white;
      border: none;
    }

    .btn-info:hover {
      background-color: #138496;
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

      .btn-group {
        width: 100%;
        flex-direction: column;
      }

      .btn {
        width: 100%;
        justify-content: center;
      }

      .action-buttons {
        flex-direction: column;
      }
    }
  </style>
</head>
<body>
<div class="container">
  <div class="floating-books book-1"></div>
  <div class="floating-books book-2"></div>

  <div class="page-header">
    <div>
      <h2>Bills for Account: <%= request.getAttribute("accountNumber") %></h2>
    </div>
    <div class="btn-group">
      <a href="generateBill.jsp" class="btn btn-primary">
        <i class="fas fa-file-invoice-dollar"></i> Generate New Bill
      </a>
      <a href="javascript:history.back()" class="btn btn-back">
        <i class="fas fa-arrow-left"></i> Back
      </a>
    </div>
  </div>

  <%
    String message = (String) request.getAttribute("message");
    if (message != null && !message.isEmpty()) {
  %>
  <div class="alert alert-success">
    <i class="fas fa-check-circle"></i> <%= message %>
  </div>
  <%
    }
    String error = (String) request.getAttribute("error");
    if (error != null && !error.isEmpty()) {
  %>
  <div class="alert alert-danger">
    <i class="fas fa-exclamation-circle"></i> <%= error %>
  </div>
  <%
    }
  %>

  <%
    List<Bill> bills = (List<Bill>) request.getAttribute("bills");
    NumberFormat currencyFormat = NumberFormat.getCurrencyInstance();
    currencyFormat.setCurrency(java.util.Currency.getInstance("LKR"));
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
  %>

  <div class="table-container">
    <table class="table table-hover">
      <thead>
      <tr>
        <th>Bill ID</th>
        <th>Bill Date</th>
        <th>Due Date</th>
        <th>Total Amount</th>
        <th>Status</th>
        <th>Actions</th>
      </tr>
      </thead>
      <tbody>
      <%
        if (bills != null && !bills.isEmpty()) {
          for (Bill bill : bills) {
      %>
      <tr>
        <td><%= bill.getBillId() %></td>
        <td><%= dateFormat.format(bill.getBillDate()) %></td>
        <td><%= dateFormat.format(bill.getDueDate()) %></td>
        <td><%= currencyFormat.format(bill.getTotalAmount()).replace("LKR", "Rs. ") %></td>
        <td class="<%= "PENDING".equals(bill.getStatus()) ? "status-pending" : "status-paid" %>">
          <i class="<%= "PENDING".equals(bill.getStatus()) ? "fas fa-clock" : "fas fa-check-circle" %>"></i>
          <%= bill.getStatus() %>
        </td>
        <td class="action-buttons">
          <a href="BillServlet?action=view&billId=<%= bill.getBillId() %>" class="btn btn-sm btn-info">
            <i class="fas fa-eye"></i> View
          </a>
          <% if ("PENDING".equals(bill.getStatus())) { %>
          <form action="BillServlet" method="post" style="display: inline;">
            <input type="hidden" name="action" value="updateStatus">
            <input type="hidden" name="billId" value="<%= bill.getBillId() %>">
            <input type="hidden" name="status" value="PAID">
            <button type="submit" class="btn btn-sm btn-success">
              <i class="fas fa-check"></i> Mark Paid
            </button>
          </form>
          <% } %>
        </td>
      </tr>
      <%
        }
      } else {
      %>
      <tr>
        <td colspan="6">
          <div class="alert alert-info">
            <i class="fas fa-info-circle"></i> No bills found for this customer.
          </div>
        </td>
      </tr>
      <%
        }
      %>
      </tbody>
    </table>
  </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/js/all.min.js"></script>
</body>
</html>