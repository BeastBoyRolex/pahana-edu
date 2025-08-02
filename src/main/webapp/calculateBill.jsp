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
  <title>Calculate Bill</title>
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


  .form-group {
    margin-bottom: 15px;
  }

  label {
    display: block;
    margin-bottom: 5px;
    font-weight: bold;
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

  button {
    background: #28a745;
    color: #fff;
    border: none;
    padding: 10px 15px;
    border-radius: 4px;
    cursor: pointer;
  }

  button:hover {
    background: #218838;
  }

  .error {
    color: #dc3545;
    padding: 10px;
    margin: 10px 0;
    border: 1px solid #f5c6cb;
    background-color: #f8d7da;
    border-radius: 4px;
  }

  .message {
    color: #155724;
    padding: 10px;
    margin: 10px 0;
    border: 1px solid #c3e6cb;
    background-color: #d4edda;
    border-radius: 4px;
  }


</style>k rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="container">
  <h1>Calculate and Print Bill</h1>

  <form action="billing" method="post">
    <input type="hidden" name="action" value="generate">

    <div class="form-group">
      <label for="accountNumber">Account Number:</label>
      <input type="text" id="accountNumber" name="accountNumber" required>
    </div>

    <div class="form-group">
      <label for="unitsConsumed">Units Consumed:</label>
      <input type="number" id="unitsConsumed" name="unitsConsumed" required min="1">
    </div>

    <button type="submit">Calculate Bill</button>
  </form>

  <a href="index.jsp">Back to Home</a>

  <% if (request.getAttribute("error") != null) { %>
  <div class="error"><%= request.getAttribute("error") %></div>
  <% } %>

  <% if (request.getAttribute("message") != null) { %>
  <div class="message"><%= request.getAttribute("message") %></div>
  <% } %>
</div>
</body>
</html>
