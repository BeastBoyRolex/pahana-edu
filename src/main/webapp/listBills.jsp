<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.icbt.model.Bill" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>All Bills - Pahana Edu Bookshop</title>
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

    .btn-sm {
      padding: 5px 10px;
      font-size: 0.875rem;
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

    .alert-success {
      background-color: rgba(40, 167, 69, 0.1);
      color: var(--success-color);
      border-left: 4px solid var(--success-color);
    }

    .table {
      border-radius: var(--border-radius);
      overflow: hidden;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }

    .table thead th {
      background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
      color: white;
      border: none;
      font-weight: 600;
      padding: 15px;
    }

    .table tbody tr {
      transition: var(--transition);
    }

    .table tbody tr:hover {
      background-color: rgba(72, 149, 239, 0.05);
    }

    .status-badge {
      padding: 5px 12px;
      border-radius: 20px;
      font-size: 0.75rem;
      font-weight: 600;
      text-transform: uppercase;
    }

    .status-pending {
      background-color: rgba(255, 193, 7, 0.2);
      color: #856404;
    }

    .status-paid {
      background-color: rgba(40, 167, 69, 0.2);
      color: #155724;
    }

    .no-bills {
      text-align: center;
      padding: 60px 20px;
      color: #6c757d;
    }

    .no-bills i {
      font-size: 4rem;
      margin-bottom: 20px;
      opacity: 0.3;
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

      .table-responsive {
        font-size: 0.875rem;
      }

      .btn {
        width: 100%;
        justify-content: center;
        margin-bottom: 10px;
      }
    }
  </style>
</head>
<body>
<div class="container">
  <div class="page-header">
    <h2><i class="fas fa-file-invoice-dollar"></i> All Bills</h2>
    <div>
      <a href="bill?action=generate" class="btn btn-primary">
        <i class="fas fa-plus"></i> Generate New Bill
      </a>
      <a href="dashboard.jsp" class="btn btn-secondary">
        <i class="fas fa-arrow-left"></i> Back to Dashboard
      </a>
    </div>
  </div>

  <%-- Display error message if any --%>
  <% if (request.getAttribute("errorMessage") != null) { %>
  <div class="alert alert-danger">
    <i class="fas fa-exclamation-triangle"></i>
    <%= request.getAttribute("errorMessage") %>
  </div>
  <% } %>

  <%-- Display success message if any --%>
  <% if (request.getAttribute("message") != null) { %>
  <div class="alert alert-success">
    <i class="fas fa-check-circle"></i>
    <%= request.getAttribute("message") %>
  </div>
  <% } %>

  <%
    List<Bill> bills = (List<Bill>) request.getAttribute("bills");
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
  %>

  <% if (bills != null && !bills.isEmpty()) { %>
  <div class="table-responsive">
    <table class="table table-hover">
      <thead>
        <tr>
          <th>Bill ID</th>
          <th>Customer Account</th>
          <th>Bill Date</th>
          <th>Due Date</th>
          <th>Total Amount</th>
          <th>Status</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
        <% for (Bill bill : bills) { %>
        <tr>
          <td>
            <strong><%= bill.getBillId() %></strong>
          </td>
          <td><%= bill.getAccountNumber() %></td>
          <td><%= dateFormat.format(bill.getBillDate()) %></td>
          <td><%= dateFormat.format(bill.getDueDate()) %></td>
          <td>
            <strong>Rs. <%= String.format("%,.2f", bill.getTotalAmount()) %></strong>
          </td>
          <td>
            <span class="status-badge <%= bill.getStatus().equals("Pending") ? "status-pending" : "status-paid" %>">
              <%= bill.getStatus() %>
            </span>
          </td>
          <td>
            <div class="btn-group" role="group">
              <a href="bill?action=view&billId=<%= bill.getBillId() %>" 
                 class="btn btn-secondary btn-sm" title="View Bill">
                <i class="fas fa-eye"></i>
              </a>
              <a href="bill?action=print&billId=<%= bill.getBillId() %>" 
                 class="btn btn-primary btn-sm" title="Print Bill">
                <i class="fas fa-print"></i>
              </a>
              <% if (bill.getStatus().equals("Pending")) { %>
              <form action="bill" method="post" style="display: inline;">
                <input type="hidden" name="action" value="markPaid">
                <input type="hidden" name="billId" value="<%= bill.getBillId() %>">
                <button type="submit" class="btn btn-success btn-sm" title="Mark as Paid"
                        onclick="return confirm('Are you sure you want to mark this bill as paid?')">
                  <i class="fas fa-check"></i>
                </button>
              </form>
              <% } %>
            </div>
          </td>
        </tr>
        <% } %>
      </tbody>
    </table>
  </div>
  <% } else { %>
  <div class="no-bills">
    <i class="fas fa-file-invoice"></i>
    <h4>No Bills Found</h4>
    <p>There are no bills in the system yet.</p>
    <a href="bill?action=generate" class="btn btn-primary">
      <i class="fas fa-plus"></i> Generate Your First Bill
    </a>
  </div>
  <% } %>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
  $(document).ready(function() {
    // Auto-hide alerts after 5 seconds
    setTimeout(function() {
      $('.alert').fadeOut('slow');
    }, 5000);

    // Confirm delete actions
    $('.btn-danger').click(function() {
      return confirm('Are you sure you want to perform this action?');
    });
  });
</script>
</body>
</html>
