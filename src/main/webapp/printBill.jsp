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
  <title>Print Bill - Pahana Edu Bookshop</title>
  <style>
    @media print {
      body { margin: 0; padding: 20px; }
      .no-print { display: none !important; }
      .page-break { page-break-before: always; }
    }

    body {
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 20px;
      background: white;
      color: #333;
      line-height: 1.4;
    }

    .container {
      max-width: 800px;
      margin: 0 auto;
      background: white;
    }

    .bill-header {
      text-align: center;
      margin-bottom: 30px;
      padding-bottom: 20px;
      border-bottom: 2px solid #333;
    }

    .bill-header h1 {
      color: #333;
      margin: 0 0 10px 0;
      font-size: 28px;
      font-weight: bold;
    }

    .bill-header p {
      margin: 5px 0;
      font-size: 14px;
      color: #666;
    }

    .bill-info {
      margin-bottom: 30px;
    }

    .bill-info .row {
      display: flex;
      justify-content: space-between;
      margin-bottom: 20px;
    }

    .bill-info .col {
      flex: 1;
    }

    .bill-info h3 {
      color: #333;
      margin: 0 0 10px 0;
      font-size: 16px;
      font-weight: bold;
    }

    .bill-info p {
      margin: 5px 0;
      font-size: 14px;
    }

    .status-badge {
      display: inline-block;
      padding: 5px 12px;
      border-radius: 15px;
      font-size: 12px;
      font-weight: bold;
      text-transform: uppercase;
    }

    .status-pending {
      background-color: #fff3cd;
      color: #856404;
      border: 1px solid #ffeaa7;
    }

    .status-paid {
      background-color: #d4edda;
      color: #155724;
      border: 1px solid #c3e6cb;
    }

    .table {
      width: 100%;
      border-collapse: collapse;
      margin-bottom: 30px;
    }

    .table th,
    .table td {
      border: 1px solid #ddd;
      padding: 12px;
      text-align: left;
    }

    .table th {
      background-color: #f8f9fa;
      font-weight: bold;
      color: #333;
    }

    .table tbody tr:nth-child(even) {
      background-color: #f9f9f9;
    }

    .total-row {
      background-color: #f8f9fa !important;
      font-weight: bold;
    }

    .total-row td {
      font-size: 16px;
    }

    .bill-footer {
      margin-top: 40px;
      padding-top: 20px;
      border-top: 1px solid #ddd;
      text-align: center;
    }

    .bill-footer p {
      margin: 10px 0;
      font-size: 14px;
      color: #666;
    }

    .print-actions {
      margin-bottom: 30px;
      text-align: center;
      padding: 20px;
      background-color: #f8f9fa;
      border-radius: 8px;
    }

    .btn {
      display: inline-block;
      padding: 10px 20px;
      margin: 5px;
      background-color: #007bff;
      color: white;
      text-decoration: none;
      border-radius: 5px;
      border: none;
      cursor: pointer;
      font-size: 14px;
    }

    .btn:hover {
      background-color: #0056b3;
    }

    .btn-secondary {
      background-color: #6c757d;
    }

    .btn-secondary:hover {
      background-color: #545b62;
    }

    @media screen and (max-width: 768px) {
      .bill-info .row {
        flex-direction: column;
      }
      
      .bill-info .col {
        margin-bottom: 20px;
      }
      
      .table {
        font-size: 12px;
      }
      
      .table th,
      .table td {
        padding: 8px;
      }
    }
  </style>
</head>
<body>
<div class="container">
  <div class="print-actions no-print">
    <h3>Print Preview</h3>
    <p>This is a printer-friendly version of your bill. Use the print button below to print or save as PDF.</p>
    <button onclick="window.print()" class="btn">🖨️ Print Bill</button>
    <a href="bill?action=view&billId=<%= request.getParameter("billId") %>" class="btn btn-secondary">← Back to View</a>
    <a href="bill?action=list" class="btn btn-secondary">📋 All Bills</a>
  </div>

  <div class="bill-header">
    <h1>📚 Pahana Edu Bookshop</h1>
    <p>123 Book Street, Colombo, Sri Lanka</p>
    <p>📞 Phone: +94 11 2345678 | 📧 Email: info@pahanaedu.lk</p>
    <p>🌐 Website: www.pahanaedu.lk</p>
  </div>

  <%
    // Get the bill object from request
    Bill bill = (Bill) request.getAttribute("bill");

    // Setup formatters
    NumberFormat currencyFormat = NumberFormat.getCurrencyInstance();
    currencyFormat.setCurrency(java.util.Currency.getInstance("LKR"));
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
  %>

  <div class="bill-info">
    <div class="row">
      <div class="col">
        <h3>👤 Bill To:</h3>
        <p><strong>Account Number:</strong> <%= bill.getAccountNumber() %></p>
        <p><strong>Date:</strong> <%= dateFormat.format(bill.getBillDate()) %></p>
      </div>
      <div class="col">
        <h3>📄 Invoice Details:</h3>
        <p><strong>Bill ID:</strong> #<%= bill.getBillId() %></p>
        <p><strong>Due Date:</strong> <%= dateFormat.format(bill.getDueDate()) %></p>
        <p><strong>Status:</strong>
          <span class="status-badge <%= "PENDING".equalsIgnoreCase(bill.getStatus()) ? "status-pending" : "status-paid" %>">
            <%= bill.getStatus() %>
          </span>
        </p>
      </div>
    </div>
  </div>

  <table class="table">
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
        <td colspan="3" style="text-align: right;"><strong>Total Amount:</strong></td>
        <td><strong>Rs. <%= String.format("%,.2f", bill.getTotalAmount()) %></strong></td>
      </tr>
    </tfoot>
  </table>

  <div class="bill-footer">
    <p><strong>Thank you for your business!</strong></p>
    <p>Please make payment by the due date to avoid any late fees.</p>
    <p>For any questions, please contact us at info@pahanaedu.lk</p>
    <p>Generated on: <%= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new java.util.Date()) %></p>
  </div>
</div>

<script>
  // Auto-print when page loads (optional)
  // window.onload = function() {
  //   window.print();
  // };

  // Handle print completion
  window.onafterprint = function() {
    console.log('Print completed');
  };
</script>
</body>
</html>