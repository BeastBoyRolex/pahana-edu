<%--
  Created by IntelliJ IDEA.
  User: LENOVO
  Date: 7/26/2025
  Time: 2:18 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Edit Customer - Pahana Edu Bookshop</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      line-height: 1.6;
      margin: 0;
      padding: 0;
      background-color: #f4f4f4;
      color: #333;
    }

    .container {
      width: 80%;
      margin: auto;
      overflow: hidden;
    }

    header {
      background: #35424a;
      color: #ffffff;
      padding: 20px 0;
      border-bottom: #e8491d 3px solid;
    }

    header h1, header h2 {
      margin: 0;
      padding: 0 0 0 20px;
    }

    nav {
      background: #e8491d;
      color: #ffffff;
    }

    nav ul {
      padding: 0;
      list-style: none;
    }

    nav ul li {
      display: inline;
      padding: 0 20px 0 20px;
    }

    nav a {
      color: #ffffff;
      text-decoration: none;
      text-transform: uppercase;
      font-size: 16px;
    }

    nav a:hover {
      color: #cccccc;
      font-weight: bold;
    }

    form {
      background: #ffffff;
      padding: 20px;
      margin: 20px 0;
      border-radius: 5px;
    }

    .form-group {
      margin-bottom: 15px;
    }

    .form-group label {
      display: block;
      margin-bottom: 5px;
      font-weight: bold;
    }

    .form-group input[type="text"],
    .form-group input[type="tel"],
    .form-group input[type="number"],
    .form-group textarea {
      width: 100%;
      padding: 8px;
      border: 1px solid #ddd;
      border-radius: 4px;
      box-sizing: border-box;
    }

    .form-group textarea {
      height: 100px;
    }

    .form-actions {
      margin-top: 20px;
    }

    button, .button {
      background: #35424a;
      color: #ffffff;
      border: none;
      padding: 10px 20px;
      cursor: pointer;
      border-radius: 4px;
      text-decoration: none;
      display: inline-block;
    }

    button:hover, .button:hover {
      background: #e8491d;
    }

  </style>
</head>
<body>
<div class="container">
  <header>
    <h1>Edit Customer</h1>
  </header>

  <nav>
    <ul>
      <li><a href="customer.jsp">Home</a></li>
      <li><a href="listCustomers.jsp">View All Customers</a></li>
    </ul>
  </nav>

  <main>
    <form action="customer?action=update" method="post">
      <input type="hidden" name="accountNumber" value="<c:out value='${customer.accountNumber}' />">

      <div class="form-group">
        <label for="accountNumberDisplay">Account Number:</label>
        <input type="text" id="accountNumberDisplay" value="<c:out value='${customer.accountNumber}' />" disabled>
      </div>

      <div class="form-group">
        <label for="name">Full Name:</label>
        <input type="text" id="name" name="name" value="<c:out value='${customer.name}' />" required>
      </div>

      <div class="form-group">
        <label for="address">Address:</label>
        <textarea id="address" name="address" rows="3" required><c:out value='${customer.address}' /></textarea>
      </div>

      <div class="form-group">
        <label for="telephone">Telephone:</label>
        <input type="tel" id="telephone" name="telephone" value="<c:out value='${customer.telephone}' />" required>
      </div>

      <div class="form-group">
        <label for="unitsConsumed">Units Consumed:</label>
        <input type="number" id="unitsConsumed" name="unitsConsumed" min="0" value="<c:out value='${customer.unitsConsumed}' />" required>
      </div>

      <div class="form-actions">
        <button type="submit">Update</button>
        <a href="listCustomers.jsp" class="button">Cancel</a>
      </div>
    </form>
  </main>

</div>
</body>
</html>
