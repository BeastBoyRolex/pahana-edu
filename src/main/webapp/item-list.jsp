<%--
  Created by IntelliJ IDEA.
  User: LENOVO
  Date: 7/27/2025
  Time: 11:45 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.icbt.model.Item" %> <%-- Replace with your actual package and class name --%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Book List - Pahana Edu Bookshop</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            line-height: 1.6;
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
            color: #333;
        }

        .container {
            width: 80%;
            margin: 20px auto;
            padding: 20px;
            background: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 5px;
        }

        h1 {
            color: #2c3e50;
            border-bottom: 2px solid #3498db;
            padding-bottom: 10px;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }

        .table th, .table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .table th {
            background-color: #3498db;
            color: white;
        }

        .table tr:hover {
            background-color: #f5f5f5;
        }


        .btn {
            display: inline-block;
            padding: 10px 15px;
            font-size: 16px;
            border-radius: 4px;
            text-decoration: none;
            cursor: pointer;
            transition: background-color 0.3s;
            border: none;
        }

        .btn-primary {
            background-color: #3498db;
            color: white;
        }

        .btn-primary:hover {
            background-color: #2980b9;
        }

        .btn-edit {
            background-color: #f39c12;
            color: white;
        }

        .btn-edit:hover {
            background-color: #e67e22;
        }

        .btn-delete {
            background-color: #e74c3c;
            color: white;
        }

        .btn-delete:hover {
            background-color: #c0392b;
        }

        .btn-view {
            background-color: #2ecc71;
            color: white;
        }

        .btn-view:hover {
            background-color: #27ae60;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .container {
                width: 95%;
            }

            .table {
                display: block;
                overflow-x: auto;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Book Management</h1>

    <a href="items?action=new" class="btn btn-primary">Add New Book</a>

    <table class="table">
        <thead>
        <tr>
            <th>ID</th>
            <th>Code</th>
            <th>Title</th>
            <th>Author</th>
            <th>Price</th>
            <th>Quantity</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<Item> items = (List<Item>) request.getAttribute("items");
            if (items != null) {
                for (Item item : items) {
        %>
        <tr>
            <td><%= item.getItemId() %></td>
            <td><%= item.getItemCode() %></td>
            <td><%= item.getTitle() %></td>
            <td><%= item.getAuthor() %></td>
            <td><%= item.getPrice() %></td>
            <td><%= item.getQuantity() %></td>
            <td>
                <a href="items?action=edit&id=<%= item.getItemId() %>" class="btn btn-edit">Edit</a>
                <a href="items?action=delete&id=<%= item.getItemId() %>" class="btn btn-delete"
                   onclick="return confirm('Are you sure you want to delete this book?')">Delete</a>
                <a href="items?action=view&id=<%= item.getItemId() %>" class="btn btn-view">View</a>
            </td>
        </tr>
        <%
                }
            }
        %>
        </tbody>
    </table>
</div>
</body>
</html>