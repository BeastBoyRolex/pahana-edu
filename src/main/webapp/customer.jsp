<%--
  Created by IntelliJ IDEA.
  User: LENOVO
  Date: 7/26/2025
  Time: 2:18 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Pahana Edu Bookshop - Customer Management</title>
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


    </style>
</head>
<body>
<div class="container">
    <header>
        <h1>Pahana Edu Bookshop</h1>
        <h2>Customer Management System</h2>
    </header>

    <nav>
        <ul>
            <li><a href="customer?action=new">Add New Customer</a></li>
            <li><a href="customer?action=list">View All Customers</a></li>
        </ul>
    </nav>

    <main>
        <div class="welcome">
            <h3>Welcome to Pahana Edu Bookshop Customer Management</h3>
            <p>Use the navigation above to manage customer accounts.</p>
        </div>
    </main>
</div>
</body>
</html>
