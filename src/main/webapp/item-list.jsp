<%--
  Created by IntelliJ IDEA.
  User: LENOVO
  Date: 7/27/2025
  Time: 11:45 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.icbt.model.Item" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Book List - Pahana Edu Bookshop</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&family=Montserrat:wght@500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        :root {
            --primary-color: #4361ee;
            --secondary-color: #3f37c9;
            --accent-color: #4895ef;
            --light-color: #f8f9fa;
            --dark-color: #212529;
            --success-color: #4cc9f0;
            --danger-color: #f72585;
            --warning-color: #f8961e;
            --info-color: #560bad;
            --text-color: #2b2d42;
            --border-radius: 12px;
            --box-shadow: 0 8px 20px rgba(0, 0, 0, 0.08);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #e4e8f0 100%);
            min-height: 100vh;
            color: var(--text-color);
            line-height: 1.6;
            padding: 20px;
        }

        .container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 30px;
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            animation: fadeIn 0.6s ease-out;
            position: relative;
            overflow: hidden;
        }

        .container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 8px;
            background: linear-gradient(90deg, var(--primary-color), var(--accent-color));
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        h1 {
            font-family: 'Montserrat', sans-serif;
            color: var(--primary-color);
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 2px solid rgba(67, 97, 238, 0.1);
            position: relative;
            font-weight: 700;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        h1::after {
            content: '';
            position: absolute;
            bottom: -2px;
            left: 0;
            width: 100px;
            height: 2px;
            background: var(--accent-color);
        }

        .header-actions {
            display: flex;
            gap: 15px;
        }

        .table-container {
            overflow-x: auto;
            border-radius: var(--border-radius);
            margin: 30px 0;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }

        .table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            background: white;
            border-radius: var(--border-radius);
            overflow: hidden;
        }

        .table th {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            font-weight: 600;
            text-align: left;
            padding: 16px 20px;
            position: sticky;
            top: 0;
        }

        .table td {
            padding: 14px 20px;
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
            vertical-align: middle;
        }

        .table tr:last-child td {
            border-bottom: none;
        }

        .table tr:hover td {
            background-color: rgba(72, 149, 239, 0.05);
        }

        .table th:first-child {
            border-top-left-radius: var(--border-radius);
        }

        .table th:last-child {
            border-top-right-radius: var(--border-radius);
        }

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 10px 18px;
            font-size: 14px;
            font-weight: 500;
            border-radius: 8px;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.3s ease;
            border: none;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .btn i {
            margin-right: 8px;
            font-size: 12px;
        }

        .btn-primary {
            background-color: var(--primary-color);
            color: white;
        }

        .btn-primary:hover {
            background-color: var(--secondary-color);
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(67, 97, 238, 0.2);
        }

        .btn-back {
            background-color: white;
            color: var(--primary-color);
            border: 2px solid var(--primary-color);
        }

        .btn-back:hover {
            background-color: rgba(67, 97, 238, 0.05);
            transform: translateY(-2px);
        }

        .btn-edit {
            background-color: var(--warning-color);
            color: white;
        }

        .btn-edit:hover {
            background-color: #e07e0e;
            transform: translateY(-2px);
        }

        .btn-delete {
            background-color: var(--danger-color);
            color: white;
        }

        .btn-delete:hover {
            background-color: #e51773;
            transform: translateY(-2px);
        }

        .btn-view {
            background-color: var(--success-color);
            color: white;
        }

        .btn-view:hover {
            background-color: #3ab8db;
            transform: translateY(-2px);
        }

        .action-buttons {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }

        .empty-state {
            text-align: center;
            padding: 40px;
            color: #6c757d;
        }

        .empty-state i {
            font-size: 50px;
            color: #dee2e6;
            margin-bottom: 20px;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .container {
                padding: 20px;
                margin: 15px;
            }

            .header-actions {
                flex-direction: column;
                gap: 10px;
            }

            .action-buttons {
                flex-direction: column;
            }

            .btn {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <h1>
        <span>Book Management</span>
        <div class="header-actions">
            <a href="items?action=new" class="btn btn-primary">
                <i class="fas fa-plus"></i> Add New Book
            </a>
            <a href="javascript:history.back()" class="btn btn-back">
                <i class="fas fa-arrow-left"></i> Back
            </a>
        </div>
    </h1>

    <div class="table-container">
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
                if (items != null && !items.isEmpty()) {
                    for (Item item : items) {
            %>
            <tr>
                <td><%= item.getItemId() %></td>
                <td><%= item.getItemCode() %></td>
                <td><strong><%= item.getTitle() %></strong></td>
                <td><%= item.getAuthor() %></td>
                <td>$<%= String.format("%.2f", item.getPrice()) %></td>
                <td><%= item.getQuantity() %></td>
                <td>
                    <div class="action-buttons">
                        <a href="items?action=edit&id=<%= item.getItemId() %>" class="btn btn-edit">
                            <i class="fas fa-edit"></i> Edit
                        </a>
                        <a href="items?action=delete&id=<%= item.getItemId() %>" class="btn btn-delete"
                           onclick="return confirm('Are you sure you want to delete this book?')">
                            <i class="fas fa-trash"></i> Delete
                        </a>
                        <a href="items?action=view&id=<%= item.getItemId() %>" class="btn btn-view">
                            <i class="fas fa-eye"></i> View
                        </a>
                    </div>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="7">
                    <div class="empty-state">
                        <i class="fas fa-book-open"></i>
                        <h3>No Books Found</h3>
                        <p>Add your first book to get started</p>
                    </div>
                </td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>