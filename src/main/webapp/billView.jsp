<%--
  Created by IntelliJ IDEA.
  User: LENOVO
  Date: 7/29/2025
  Time: 1:36 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>Bill View</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      line-height: 1.6;
      margin: 0;
      padding: 20px;
      background-color: #f4f4f4;
    }

    .container {
      max-width: 800px;
      margin: 0 auto;
      background: #fff;
      padding: 20px;
      border-radius: 5px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    h1{
      color: #333;
    }

    input[type="text"],
    input[type="number"],
    input[type="tel"],
    input[type="email"],
    textarea {
      width: 100%;
      padding: 8px;
      border: 1px solid #ddd;
      border-radius: 4px;
      box-sizing: border-box;
    }

    .bill-details {
      margin: 20px 0;
      padding: 15px;
      border: 1px solid #ddd;
      border-radius: 4px;
      background-color: #f9f9f9;
    }

  </style></head>
<body>
<div class="container">
  <h1>Bill Details</h1>

  <div class="bill-details">
    <p><strong>Bill ID:</strong> ${bill.billId}</p>
    <p><strong>Account Number:</strong> ${bill.accountNumber}</p>
    <p><strong>Billing Date:</strong> ${bill.billingDate}</p>
    <p><strong>Units Consumed:</strong> ${bill.unitsConsumed}</p>
    <p><strong>Amount:</strong> Rs. ${bill.amount}</p>
    <p><strong>Payment Status:</strong> ${bill.paymentStatus}</p>
  </div>

  <button onclick="window.print()">Print Bill</button>
  <a href="billing?action=view&accountNumber=${bill.accountNumber}">Back to Bills</a>
  <a href="index.jsp">Back to Home</a>
</div>
</body>
</html>
