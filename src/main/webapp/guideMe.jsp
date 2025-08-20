<%--
  Created by IntelliJ IDEA.
  User: LENOVO
  Date: 8/21/2025
  Time: 1:47 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Guide - Pahana Edu Bookshop</title>
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

        .guide-container {
            width: 90%;
            max-width: 1000px;
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

        .guide-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 8px;
            background: linear-gradient(90deg, var(--info-color), #7209b7);
        }

        .guide-header {
            text-align: center;
            margin-bottom: 40px;
            position: relative;
            padding-bottom: 20px;
        }

        .guide-header h1 {
            font-family: 'Montserrat', sans-serif;
            color: var(--info-color);
            font-size: 32px;
            margin-bottom: 10px;
            font-weight: 700;
        }

        .guide-header p {
            color: #7f8c8d;
            font-size: 16px;
        }

        .guide-header::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 3px;
            background: linear-gradient(90deg, var(--info-color), #7209b7);
            border-radius: 3px;
        }

        .guide-section {
            margin-bottom: 30px;
            padding: 20px;
            background: var(--light-color);
            border-radius: var(--border-radius);
            border-left: 4px solid var(--info-color);
        }

        .guide-section h2 {
            color: var(--info-color);
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .guide-section h2 i {
            font-size: 24px;
        }

        .guide-step {
            margin-bottom: 15px;
            padding-left: 25px;
            position: relative;
        }

        .guide-step::before {
            content: '•';
            position: absolute;
            left: 10px;
            color: var(--info-color);
            font-weight: bold;
            font-size: 18px;
        }

        .feature-card {
            background: white;
            padding: 15px;
            border-radius: var(--border-radius);
            margin: 10px 0;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            border: 1px solid #e9ecef;
        }

        .feature-card h3 {
            color: var(--primary-color);
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .feature-card h3 i {
            font-size: 18px;
        }

        .back-container {
            display: flex;
            justify-content: center;
            margin-top: 40px;
        }

        .back-button {
            background: linear-gradient(135deg, var(--info-color), #7209b7);
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
            box-shadow: 0 4px 8px rgba(86, 11, 173, 0.2);
        }

        .back-button:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 15px rgba(86, 11, 173, 0.3);
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
            background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="%23560bad"><path d="M18 2H6c-1.1 0-2 .9-2 2v16c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2zM6 4h5v8l-2.5-1.5L6 12V4z"/></svg>') no-repeat;
        }

        .book-2 {
            bottom: 20px;
            left: 20px;
            background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="%23560bad"><path d="M18 2H6c-1.1 0-2 .9-2 2v16c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2zM6 4h5v8l-2.5-1.5L6 12V4z"/></svg>') no-repeat;
        }

        @media (max-width: 768px) {
            .guide-container {
                width: 95%;
                padding: 30px 20px;
            }

            .guide-header h1 {
                font-size: 26px;
            }
        }
    </style>
</head>
<body>
<div class="guide-container">
    <div class="floating-books book-1"></div>
    <div class="floating-books book-2"></div>

    <div class="guide-header">
        <h1><i class="fas fa-question-circle"></i> System User Guide</h1>
        <p>Comprehensive instructions for using Pahana Edu Bookshop Management System</p>
    </div>

    <div class="guide-section">
        <h2><i class="fas fa-user-plus"></i> Customer Management</h2>
        <div class="guide-step">Click "Add Customer" to register new customers with their details</div>
        <div class="guide-step">Use "List Customers" to view, edit, or search existing customers</div>
        <div class="guide-step">Each customer receives a unique account number automatically</div>

        <div class="feature-card">
            <h3><i class="fas fa-lightbulb"></i> Pro Tip</h3>
            <p>Always verify customer telephone numbers and addresses during registration to ensure accurate billing.</p>
        </div>
    </div>

    <div class="guide-section">
        <h2><i class="fas fa-book"></i> Inventory Management</h2>
        <div class="guide-step">Add new books/items using "Add Item" with complete details</div>
        <div class="guide-step">View current inventory through "List Items"</div>
        <div class="guide-step">Update stock levels and prices as needed</div>
        <div class="guide-step">Set reorder levels to receive stock alerts</div>

        <div class="feature-card">
            <h3><i class="fas fa-lightbulb"></i> Pro Tip</h3>
            <p>Regularly update item descriptions and categories to make searching easier for your staff.</p>
        </div>
    </div>

    <div class="guide-section">
        <h2><i class="fas fa-file-invoice-dollar"></i> Billing System</h2>
        <div class="guide-step">Generate new bills by selecting "Add Bill"</div>
        <div class="guide-step">Select customer and add items with quantities</div>
        <div class="guide-step">System automatically calculates totals with tiered pricing</div>
        <div class="guide-step">View all transactions through "List Bills"</div>
        <div class="guide-step">Mark bills as paid when payment is received</div>

        <div class="feature-card">
            <h3><i class="fas fa-lightbulb"></i> Pro Tip</h3>
            <p>Use the bill search feature to quickly find transactions by customer name, date, or bill number.</p>
        </div>
    </div>

    <div class="guide-section">
        <h2><i class="fas fa-chart-bar"></i> Reports & Analytics</h2>
        <div class="guide-step">Access daily sales reports from the dashboard</div>
        <div class="guide-step">Generate customer statements for account activity</div>
        <div class="guide-step">Monitor inventory levels and low stock alerts</div>
        <div class="guide-step">Export reports to PDF or Excel format</div>
    </div>

    <div class="guide-section">
        <h2><i class="fas fa-shield-alt"></i> Security Features</h2>
        <div class="guide-step">Role-based access control (Admin/Staff permissions)</div>
        <div class="guide-step">Automatic session timeout for security</div>
        <div class="guide-step">Password encryption and protection</div>
        <div class="guide-step">Audit logging of all system activities</div>
    </div>

    <div class="guide-section">
        <h2><i class="fas fa-tools"></i> Troubleshooting</h2>
        <div class="guide-step">If you encounter errors, check your internet connection first</div>
        <div class="guide-step">Ensure all required fields are filled before submitting forms</div>
        <div class="guide-step">Contact system administrator for persistent issues</div>
        <div class="guide-step">Regularly save your work to prevent data loss</div>
    </div>

    <div class="back-container">
        <a href="dashboard.jsp" class="back-button">
            <i class="fas fa-arrow-left"></i> Back to Dashboard
        </a>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/js/all.min.js"></script>
</body>
</html>
