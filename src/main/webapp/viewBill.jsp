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
  <title>View Bill</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .container { max-width: 800px; margin-top: 30px; }
    .bill-header { margin-bottom: 30px; }
    .bill-footer { margin-top: 30px; }
    .status-pending { color: #dc3545; font-weight: bold; }
    .status-paid { color: #28a745; font-weight: bold; }
  </style>
</head>
<body>
<div class="container">
  <div class="bill-header">
    <h2>Pahana Edu Bookshop</h2>
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

  <div class="row mb-4">
    <div class="col-md-6">
      <h4>Bill To:</h4>
      <p>Account Number: <%= bill.getAccountNumber() %></p>
    </div>
    <div class="col-md-6 text-end">
      <h4>Invoice #<%= bill.getBillId() %></h4>
      <p>Bill Date: <%= dateFormat.format(bill.getBillDate()) %></p>
      <p>Due Date: <%= dateFormat.format(bill.getDueDate()) %></p>
      <p>Status:
        <span class="<%= bill.getStatus().equals("PENDING") ? "status-pending" : "status-paid" %>">
          <%= bill.getStatus() %>
        </span>
      </p>
    </div>
  </div>

  <table class="table table-bordered">
    <thead class="table-light">
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
      for (BillItem item : bill.getItems()) {
    %>
    <tr>
      <td><%= item.getDescription() %></td>
      <td><%= item.getQuantity() %></td>
      <td>Rs. <%= String.format("%,.2f", item.getUnitPrice()) %></td>
      <td>Rs. <%= String.format("%,.2f", item.getAmount()) %></td>
    </tr>
    <%
      }
    %>
    </tbody>
    <tfoot>
    <tr>
      <td colspan="3" class="text-end"><strong>Total Amount:</strong></td>
      <td><strong>Rs. <%= String.format("%,.2f", bill.getTotalAmount()) %></strong></td>
    </tr>
    </tfoot>
  </table>

  <div class="bill-footer">
    <div class="d-flex justify-content-between">
      <div>
        <%
          if (bill.getStatus().equals("PENDING")) {
        %>
        <form action="BillServlet" method="post" style="display: inline;">
          <input type="hidden" name="action" value="updateStatus">
          <input type="hidden" name="billId" value="<%= bill.getBillId() %>">
          <input type="hidden" name="status" value="PAID">
          <button type="submit" class="btn btn-success">Mark as Paid</button>
        </form>
        <%
          }
        %>
        <a href="BillServlet?action=customerBills&accountNumber=<%= bill.getAccountNumber() %>" class="btn btn-secondary">Back to Customer Bills</a>
      </div>
      <div>
        <button onclick="window.print()" class="btn btn-primary">Print Bill</button>
      </div>
    </div>

    <%
      if (message != null && !message.isEmpty()) {
    %>
    <div class="alert alert-success mt-3"><%= message %></div>
    <%
      }

      if (error != null && !error.isEmpty()) {
    %>
    <div class="alert alert-danger mt-3"><%= error %></div>
    <%
      }
    %>
  </div>
</div>
</body>
</html>