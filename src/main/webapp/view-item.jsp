<%--
  Created by IntelliJ IDEA.
  User: LENOVO
  Date: 7/27/2025
  Time: 11:48 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>View Book - Pahana Edu Bookshop</title>
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


        .btn-edit {
            background-color: #f39c12;
            color: white;
        }

        .btn-edit:hover {
            background-color: #e67e22;
        }


        .btn-back {
            background-color: #95a5a6;
            color: white;
        }

        .btn-back:hover {
            background-color: #7f8c8d;
        }

        .book-details {
            margin: 20px 0;
        }

        .detail-row {
            margin-bottom: 10px;
            padding: 10px;
            background-color: #f9f9f9;
            border-left: 4px solid #3498db;
        }

        .detail-label {
            font-weight: bold;
            display: inline-block;
            width: 150px;
        }

        .detail-value {
            display: inline-block;
        }

        .action-buttons {
            margin-top: 20px;
        }

        @media (max-width: 768px) {
            .container {
                width: 95%;
            }


            .detail-label {
                display: block;
                width: auto;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <h1>Book Details</h1>

    <div class="book-details">
        <div class="detail-row">
            <span class="detail-label">Book Code:</span>
            <span class="detail-value">${item.itemCode}</span>
        </div>

        <div class="detail-row">
            <span class="detail-label">Title:</span>
            <span class="detail-value">${item.title}</span>
        </div>

        <div class="detail-row">
            <span class="detail-label">Author:</span>
            <span class="detail-value">${item.author}</span>
        </div>

        <div class="detail-row">
            <span class="detail-label">Publisher:</span>
            <span class="detail-value">${item.publisher}</span>
        </div>

        <div class="detail-row">
            <span class="detail-label">Category:</span>
            <span class="detail-value">${item.category}</span>
        </div>

        <div class="detail-row">
            <span class="detail-label">Price:</span>
            <span class="detail-value">${item.price}</span>
        </div>

        <div class="detail-row">
            <span class="detail-label">Quantity:</span>
            <span class="detail-value">${item.quantity}</span>
        </div>

        <div class="detail-row">
            <span class="detail-label">Description:</span>
            <span class="detail-value">${item.description}</span>
        </div>
    </div>

    <div class="action-buttons">
        <a href="items?action=edit&id=${item.itemId}" class="btn btn-edit">Edit</a>
        <a href="items" class="btn btn-back">Back to List</a>
    </div>
</div>
</body>
</html>
