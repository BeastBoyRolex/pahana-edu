<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard - Pahana Edu Bookshop</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&family=Montserrat:wght@600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        :root {
            --primary-color: #4361ee;
            --secondary-color: #3f37c9;
            --accent-color: #4895ef;
            --success-color: #4cc9f0;
            --danger-color: #f72585;
            --warning-color: #f8961e;
            --info-color: #560bad;
            --text-color: #2b2d42;
            --light-color: #f8f9fa;
            --border-radius: 12px;
            --box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
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
            min-height: 100vh;
            color: var(--text-color);
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 20px;
        }

        .dashboard-container {
            width: 90%;
            max-width: 1200px;
            background-color: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            padding: 40px;
            margin-top: 40px;
            position: relative;
            overflow: hidden;
            animation: fadeInUp 0.6s ease-out;
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .dashboard-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 8px;
            background: linear-gradient(90deg, var(--primary-color), var(--accent-color));
        }

        .welcome-message {
            text-align: center;
            margin-bottom: 40px;
            position: relative;
            padding-bottom: 20px;
        }

        .welcome-message h1 {
            font-family: 'Montserrat', sans-serif;
            color: var(--primary-color);
            font-size: 32px;
            margin-bottom: 10px;
            font-weight: 700;
        }

        .welcome-message p {
            color: #7f8c8d;
            font-size: 16px;
        }

        .welcome-message::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 3px;
            background: linear-gradient(90deg, var(--primary-color), var(--accent-color));
            border-radius: 3px;
        }

        .button-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 25px;
            margin: 30px 0;
        }

        .dashboard-button {
            background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
            color: white;
            border: none;
            padding: 20px;
            text-align: center;
            text-decoration: none;
            font-size: 16px;
            font-weight: 500;
            border-radius: var(--border-radius);
            cursor: pointer;
            transition: var(--transition);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 150px;
            box-shadow: 0 4px 8px rgba(67, 97, 238, 0.2);
        }


        .dashboard-button.guide {
            background: linear-gradient(135deg, var(--info-color), #7209b7);
            box-shadow: 0 4px 8px rgba(86, 11, 173, 0.2);
        }

        .dashboard-button:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 15px rgba(67, 97, 238, 0.3);
        }


        .dashboard-button.guide:hover {
            box-shadow: 0 8px 15px rgba(86, 11, 173, 0.3);
        }


        .dashboard-button i {
            font-size: 32px;
            margin-bottom: 15px;
            color: white;
        }

        .dashboard-button span {
            display: block;
            margin-top: 5px;
            font-size: 14px;
            opacity: 0.9;
        }

        .logout-container {
            display: flex;
            justify-content: center;
            margin-top: 40px;
        }

        .logout-button {
            background: linear-gradient(135deg, var(--danger-color), #f94144);
            color: white;
            border: none;
            padding: 15px 30px;
            text-align: center;
            text-decoration: none;
            font-size: 16px;
            font-weight: 500;
            border-radius: 50px;
            cursor: pointer;
            transition: var(--transition);
            display: flex;
            align-items: center;
            gap: 10px;
            box-shadow: 0 4px 8px rgba(247, 37, 133, 0.2);
            width: auto;
        }

        .logout-button:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 15px rgba(247, 37, 133, 0.3);
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
            .dashboard-container {
                width: 95%;
                padding: 30px 20px;
            }

            .welcome-message h1 {
                font-size: 26px;
            }

            .button-container {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<div class="dashboard-container">
    <div class="floating-books book-1"></div>
    <div class="floating-books book-2"></div>

    <div class="welcome-message">
        <h1>Welcome, ${username}</h1>
        <p>You have successfully logged in to Pahana Edu Bookshop Admin Panel</p>
    </div>

    <div class="button-container">
        <a href="customer?action=add" class="dashboard-button">
            <i class="fas fa-user-plus"></i>
            Add Customer
            <span>Create new customer records</span>
        </a>
        <a href="customer?action=list" class="dashboard-button">
            <i class="fas fa-users"></i>
            List Customers
            <span>View all customer information</span>
        </a>
        <a href="items?action=new" class="dashboard-button">
            <i class="fas fa-book-medical"></i>
            Add Item
            <span>Add new books to inventory</span>
        </a>
        <a href="items?action=list" class="dashboard-button">
            <i class="fas fa-book-open"></i>
            List Items
            <span>Browse all available books</span>
        </a>
        <a href="bill?action=generate" class="dashboard-button">
            <i class="fas fa-file-invoice-dollar"></i>
            Add Bill
            <span>Create new invoices</span>
        </a>
        <a href="bill?action=list" class="dashboard-button">
            <i class="fas fa-receipt"></i>
            List Bills
            <span>View all transactions</span>
        </a>

        <!-- New Guide Me Button -->
        <a href="guideMe.jsp" class="dashboard-button">
            <i class="fas fa-question-circle"></i>
            Guide Me
            <span>System usage instructions</span>
        </a>

    </div>

    <div class="logout-container">
        <a href="logout" class="logout-button">
            <i class="fas fa-sign-out-alt"></i> Logout
        </a>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/js/all.min.js"></script>
</body>
</html>