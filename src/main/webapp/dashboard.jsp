<%--
  Created by IntelliJ IDEA.
  User: LENOVO
  Date: 7/26/2025
  Time: 1:41 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            align-items: center;
            min-height: 100vh;
        }

        .dashboard-container {
            width: 80%;
            max-width: 1000px;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 30px;
            margin-top: 50px;
        }

        .welcome-message {
            font-size: 24px;
            color: #333;
            margin-bottom: 30px;
            text-align: center;
        }

        .button-container {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-top: 20px;
        }

        .dashboard-button {
            background-color: #146b65;
            color: white;
            border: none;
            padding: 15px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .dashboard-button:hover {
            background-color: #45a049;
        }

        .logout-button {
            background-color: #b43127;
            margin-top: 30px;
            width: 97%;
        }

        .logout-button:hover {
            background-color: #d32f2f;
        }
    </style>
</head>
<body>
<div class="dashboard-container">
    <div class="welcome-message">
        Welcome, ${username}
        <p>You have successfully logged in.</p>
    </div>

    <div class="button-container">
        <a href="customer?action=add" class="dashboard-button">Add Customer</a>
        <a href="customer?action=list" class="dashboard-button">List Customers</a>
        <a href="items?action=new" class="dashboard-button">Add Item</a>
        <a href="items?action=list" class="dashboard-button">List Items</a>
        <a href="bill?action=add" class="dashboard-button">Add Bill</a>
        <a href="bill?action=list" class="dashboard-button">List Bills</a>
    </div>

    <a href="logout" class="dashboard-button logout-button">Logout</a>
</div>
</body>
</html>
