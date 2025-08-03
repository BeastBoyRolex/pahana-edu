<%--
  Created by IntelliJ IDEA.
  User: LENOVO
  Date: 7/26/2025
  Time: 2:19 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.icbt.model.Customer" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer List - Pahana Edu Bookshop</title>
    <style>
        /* General Styles */
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

        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 12px;
            text-align: left;
        }

        th {
            background-color: #35424a;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        tr:hover {
            background-color: #ddd;
        }

    </style>
</head>
<body>
<div class="container">
    <header>
        <h1>Customer List</h1>
    </header>

    <nav>
        <ul>
            <li><a href="dashboard.jsp">Home</a></li>
            <li><a href="addCustomer.jsp">Add New Customer</a></li>
        </ul>
    </nav>

    <main>
        <table>
            <thead>
            <tr>
                <th>Account Number</th>
                <th>Name</th>
                <th>Address</th>
                <th>Telephone</th>
                <th>Units Consumed</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <%
                List<Customer> customers = (List<Customer>) request.getAttribute("listCustomer");
                if (customers != null) {
                    for (Customer customer : customers) {
            %>
            <tr>
                <td><%= customer.getAccountNumber() %></td>
                <td><%= customer.getName() %></td>
                <td><%= customer.getAddress() %></td>
                <td><%= customer.getTelephone() %></td>
                <td><%= customer.getUnitsConsumed() %></td>
                <td><%= customer.getActions() %></td>
                <td>
                    <a href="customer?action=edit&accountNumber=<%= customer.getAccountNumber() %>">Edit</a>
                </td>
            </tr>
            <%
                    }
                }
            %>
            </tbody>
        </table>
    </main>
</div>
</body>
</html>