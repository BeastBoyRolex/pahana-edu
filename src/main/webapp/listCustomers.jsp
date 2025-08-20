<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.icbt.model.Customer" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer List - Pahana Edu Bookshop</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&family=Montserrat:wght@600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        :root {
            --primary-color: #4361ee;
            --secondary-color: #3f37c9;
            --accent-color: #4895ef;
            --danger-color: #f72585;
            --success-color: #4cc9f0;
            --warning-color: #f8961e;
            --text-color: #2b2d42;
            --light-color: #f8f9fa;
            --border-radius: 12px;
            --box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
            --transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #e4e8f0 100%);
            color: var(--text-color);
            line-height: 1.6;
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            overflow: hidden;
            animation: fadeIn 0.6s ease-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 25px 30px;
            position: relative;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .header::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 8px;
            background: linear-gradient(90deg, var(--accent-color), var(--success-color));
        }

        .header h1 {
            font-family: 'Montserrat', sans-serif;
            font-size: 24px;
            font-weight: 700;
        }

        .back-button {
            background: rgba(255, 255, 255, 0.2);
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 50px;
            cursor: pointer;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: var(--transition);
            backdrop-filter: blur(5px);
        }

        .back-button:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateX(-3px);
        }

        .nav-tabs {
            background: white;
            padding: 0 30px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }

        .nav-tabs ul {
            display: flex;
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .nav-tabs li {
            position: relative;
        }

        .nav-tabs a {
            color: var(--text-color);
            text-decoration: none;
            padding: 15px 20px;
            display: block;
            font-weight: 500;
            transition: var(--transition);
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .nav-tabs a:hover {
            color: var(--primary-color);
        }

        .nav-tabs li.active a {
            color: var(--primary-color);
        }

        .nav-tabs li.active::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 20px;
            right: 20px;
            height: 3px;
            background: var(--primary-color);
            border-radius: 3px 3px 0 0;
        }

        .main-content {
            padding: 30px;
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

        .action-buttons {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }

        .btn {
            padding: 8px 12px;
            font-size: 13px;
            font-weight: 500;
            border-radius: 6px;
            text-decoration: none;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }

        .btn-edit {
            background-color: var(--warning-color);
            color: white;
        }

        .btn-edit:hover {
            background-color: #e07e0e;
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

        .btn-add {
            background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
            color: white;
            padding: 12px 20px;
            border-radius: var(--border-radius);
            text-decoration: none;
            font-weight: 500;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 20px;
            box-shadow: 0 4px 8px rgba(67, 97, 238, 0.2);
            transition: var(--transition);
        }

        .btn-add:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(67, 97, 238, 0.3);
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

        .floating-books {
            position: absolute;
            width: 100px;
            height: 100px;
            opacity: 0.1;
            z-index: -1;
        }

        .book-1 {
            top: 20px;
            right: 20px;
            background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="%234361ee"><path d="M18 2H6c-1.1 0-2 .9-2 2v16c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2zM6 4h5v8l-2.5-1.5L6 12V4z"/></svg>') no-repeat;
        }

        .book-2 {
            bottom: 20px;
            left: 20px;
            background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="%234361ee"><path d="M18 2H6c-1.1 0-2 .9-2 2v16c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2zM6 4h5v8l-2.5-1.5L6 12V4z"/></svg>') no-repeat;
        }

        @media (max-width: 768px) {
            .container {
                margin: 20px;
                width: calc(100% - 40px);
            }

            .nav-tabs ul {
                flex-direction: column;
            }

            .nav-tabs a {
                justify-content: center;
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
    <div class="floating-books book-1"></div>
    <div class="floating-books book-2"></div>

    <div class="header">
        <a href="javascript:history.back()" class="back-button">
            <i class="fas fa-arrow-left"></i> Back
        </a>
        <h1>Customer List</h1>
    </div>

    <div class="nav-tabs">
        <ul>
            <li><a href="dashboard.jsp"><i class="fas fa-home"></i> Home</a></li>
            <li class="active"><a href="#"><i class="fas fa-users"></i> Customers</a></li>
            <li><a href="addCustomer.jsp"><i class="fas fa-user-plus"></i> Add Customer</a></li>
        </ul>
    </div>

    <div class="main-content">

        <div class="table-container">
            <table class="table">
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
                    if (customers != null && !customers.isEmpty()) {
                        for (Customer customer : customers) {
                %>
                <tr>
                    <td><%= customer.getAccountNumber() %></td>
                    <td><%= customer.getName() %></td>
                    <td><%= customer.getAddress() %></td>
                    <td><%= customer.getTelephone() %></td>
                    <td><%= customer.getUnitsConsumed() %></td>
                    <td>
                        <div class="action-buttons">
                            <a href="customer?action=edit&accountNumber=<%= customer.getAccountNumber() %>" class="btn btn-edit">
                                <i class="fas fa-edit"></i> Edit
                            </a>
                            <a href="bill?action=list&accountNumber=<%= customer.getAccountNumber()%>" class="btn btn-view">
                                <i class="fas fa-receipt"></i> Bills
                            </a>
                        </div>
                    </td>
                </tr>
                <%
                    }
                } else {
                %>
                <tr>
                    <td colspan="6">
                        <div class="empty-state">
                            <i class="fas fa-users-slash"></i>
                            <h3>No Customers Found</h3>
                            <p>Add your first customer to get started</p>
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
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/js/all.min.js"></script>
</body>
</html>