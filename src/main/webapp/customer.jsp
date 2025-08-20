<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer Management - Pahana Edu Bookshop</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&family=Montserrat:wght@600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        :root {
            --primary-color: #4361ee;
            --secondary-color: #3f37c9;
            --accent-color: #4895ef;
            --light-color: #f8f9fa;
            --dark-color: #212529;
            --text-color: #2b2d42;
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
            padding: 30px;
            position: relative;
            text-align: center;
        }

        .header::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 8px;
            background: linear-gradient(90deg, var(--accent-color), #4cc9f0);
        }

        .header h1 {
            font-family: 'Montserrat', sans-serif;
            font-size: 36px;
            font-weight: 700;
            margin-bottom: 10px;
        }

        .header h2 {
            font-size: 18px;
            opacity: 0.9;
            font-weight: 400;
        }

        .nav {
            background: white;
            padding: 0 30px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }

        .nav ul {
            display: flex;
            list-style: none;
            justify-content: center;
        }

        .nav li {
            position: relative;
        }

        .nav a {
            color: var(--text-color);
            text-decoration: none;
            padding: 20px 30px;
            display: block;
            font-weight: 500;
            transition: var(--transition);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .nav a:hover {
            color: var(--primary-color);
        }

        .nav li.active a {
            color: var(--primary-color);
        }

        .nav li.active::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 30px;
            right: 30px;
            height: 3px;
            background: var(--primary-color);
            border-radius: 3px 3px 0 0;
        }

        .main-content {
            padding: 50px;
            text-align: center;
        }

        .welcome {
            max-width: 700px;
            margin: 0 auto;
        }

        .welcome h3 {
            font-size: 28px;
            margin-bottom: 20px;
            color: var(--primary-color);
            font-weight: 600;
        }

        .welcome p {
            font-size: 18px;
            color: #7f8c8d;
            margin-bottom: 40px;
        }

        .action-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 30px;
            margin-top: 50px;
        }

        .action-card {
            background: white;
            border-radius: var(--border-radius);
            padding: 30px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            transition: var(--transition);
            border-top: 4px solid var(--primary-color);
            text-align: center;
        }

        .action-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }

        .action-card i {
            font-size: 40px;
            color: var(--primary-color);
            margin-bottom: 20px;
            background: rgba(67, 97, 238, 0.1);
            width: 80px;
            height: 80px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
        }

        .action-card h4 {
            font-size: 20px;
            margin-bottom: 15px;
            color: var(--text-color);
        }

        .action-card p {
            color: #7f8c8d;
            margin-bottom: 20px;
        }

        .action-card .btn {
            display: inline-block;
            padding: 12px 25px;
            background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
            color: white;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 500;
            transition: var(--transition);
            box-shadow: 0 4px 8px rgba(67, 97, 238, 0.2);
        }

        .action-card .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(67, 97, 238, 0.3);
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

            .nav ul {
                flex-direction: column;
            }

            .nav a {
                padding: 15px;
                justify-content: center;
            }

            .main-content {
                padding: 30px 20px;
            }

            .action-cards {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="floating-books book-1"></div>
    <div class="floating-books book-2"></div>

    <div class="header">
        <h1>Pahana Edu Bookshop</h1>
        <h2>Customer Management System</h2>
    </div>

    <nav class="nav">
        <ul>
            <li class="active">
                <a href="#">
                    <i class="fas fa-home"></i> Dashboard
                </a>
            </li>
            <li>
                <a href="customer?action=new">
                    <i class="fas fa-user-plus"></i> Add Customer
                </a>
            </li>
            <li>
                <a href="customer?action=list">
                    <i class="fas fa-users"></i> View Customers
                </a>
            </li>
        </ul>
    </nav>

    <main class="main-content">
        <div class="welcome">
            <h3>Welcome to Customer Management</h3>
            <p>Manage all customer accounts and information with our intuitive system</p>
        </div>

        <div class="action-cards">
            <div class="action-card">
                <i class="fas fa-user-plus"></i>
                <h4>Add New Customer</h4>
                <p>Create new customer accounts with complete details</p>
                <a href="customer?action=new" class="btn">
                    <i class="fas fa-plus"></i> Add Customer
                </a>
            </div>

            <div class="action-card">
                <i class="fas fa-users"></i>
                <h4>View All Customers</h4>
                <p>Browse, search and manage existing customer accounts</p>
                <a href="customer?action=list" class="btn">
                    <i class="fas fa-list"></i> View Customers
                </a>
            </div>
        </div>
    </main>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/js/all.min.js"></script>
</body>
</html>