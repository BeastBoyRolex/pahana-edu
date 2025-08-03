<%--
  Created by IntelliJ IDEA.
  User: LENOVO
  Date: 7/26/2025
  Time: 2:16 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add New Customer - Pahana Edu Bookshop</title>
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
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header-content {
            display: flex;
            align-items: center;
        }

        .header-title {
            padding: 0 0 0 20px;
        }

        .back-button {
            background: #e8491d;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
            font-size: 14px;
            margin-left: 20px;
            display: flex;
            align-items: center;
        }

        .back-button:hover {
            background: #d1401a;
        }

        .back-button:before {
            content: "←";
            margin-right: 5px;
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

        button,.button {
            background: #35424a;
            color: #ffffff;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            border-radius: 4px;
            text-decoration: none;
            display: inline-block;
        }

        button:hover,.button:hover {
            background: #e8491d;
        }

        .error-message {
            background-color: #ffdddd;
            border-left: 6px solid #f44336;
            margin-bottom: 15px;
            padding: 10px;
        }

        .error-message p {
            margin: 0;
            color: #d32f2f;
            font-weight: bold;
        }
    </style>
</head>
<body>
<div class="container">
    <header>
        <div class="header-content">
            <a href="dashboard.jsp" class="back-button">Back</a>
            <div class="header-title">
                <h1>Add New Customer</h1>
            </div>
        </div>
    </header>

    <nav>
        <ul>
            <li><a href="customer.jsp">Home</a></li>
            <li><a href="customer?action=list">View All Customers</a></li>
        </ul>
    </nav>

    <main>
        <c:if test="${not empty errorMessage}">
            <div class="error-message">
                <p>${errorMessage}</p>
            </div>
        </c:if>

        <form action="customer?action=insert" method="post">
            <div class="form-group">
                <label for="accountNumber">Account Number:</label>
                <input type="text" id="accountNumber" name="accountNumber" required>
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" required>
                <label for="address">Address:</label>
                <input type="text" id="address" name="address" required>
                <label for="telephone">Telephone:</label>
                <input type="text" id="telephone" name="telephone" required>
                <label for="units_consumed">Unit Consumed:</label>
                <input type="text" id="units_consumed" name="unitsConsumed" required>
            </div>

            <div class="form-actions">
                <button type="submit">Add Customer</button>
                <button type="reset">Clear</button>
                <a href="customer?action=list" class="button">Cancel</a>
            </div>
        </form>
    </main>

</div>
</body>
</html>