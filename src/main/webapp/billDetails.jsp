<%--
  Created by IntelliJ IDEA.
  User: LENOVO
  Date: 7/29/2025
  Time: 1:36 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <title>Bill Details</title>
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

  h1 {
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



  table {
    width: 100%;
    border-collapse: collapse;
    margin: 20px 0;
  }

  table, th, td {
    border: 1px solid #ddd;
  }

  th, td {
    padding: 10px;
    text-align: left;
  }

  th {
    background-color: #f2f2f2;
  }

  tr:nth-child(even) {
    background-color: #f9f9f9;
  }

</style>
</head>
<body>
<div class="container">
  <h1>Bill Details for Account: ${param.accountNumber}</h1>

  <table>
    <thead>
    <tr>
      <th>Bill ID</th>
      <th>Billing Date</th>
      <th>Units Consumed</th>
      <th>Amount (Rs.)</th>
      <th>Payment Status</th>
      <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="bill" items="${bills}">
      <tr>
        <td>${bill.billId}</td>
        <td>${bill.billingDate}</td>
        <td>${bill.unitsConsumed}</td>
        <td>${bill.amount}</td>
        <td>${bill.paymentStatus}</td>
        <td>
          <a href="billing?action=details&billId=${bill.billId}">View Details</a>
        </td>
      </tr>
    </c:forEach>
    </tbody>
  </table>

  <a href="viewAccount.jsp">Back to Account</a>
  <a href="index.jsp">Back to Home</a>
</div>
</body>
</html>
