<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add New Customer - Pahana Edu Bookshop</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&family=Montserrat:wght@600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        :root {
            --primary-color: #4361ee;
            --secondary-color: #3f37c9;
            --accent-color: #4895ef;
            --danger-color: #f72585;
            --success-color: #4cc9f0;
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
            color: var(--text-color);
            line-height: 1.6;
            min-height: 100vh;
        }

        .container {
            max-width: 900px;
            margin: 40px auto;
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            overflow: hidden;
            animation: fadeInUp 0.6s ease-out;
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 25px 30px;
            position: relative;
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

        .header-content {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .header-title h1 {
            font-family: 'Montserrat', sans-serif;
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .header-title p {
            opacity: 0.9;
            font-size: 14px;
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

        .form-container {
            padding: 30px;
        }

        .error-message {
            background-color: rgba(247, 37, 133, 0.1);
            color: var(--danger-color);
            padding: 15px;
            border-radius: var(--border-radius);
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 10px;
            border-left: 4px solid var(--danger-color);
            animation: shake 0.5s ease-in-out;
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            10%, 30%, 50%, 70%, 90% { transform: translateX(-5px); }
            20%, 40%, 60%, 80% { transform: translateX(5px); }
        }

        form {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group.full-width {
            grid-column: span 2;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--text-color);
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e9ecef;
            border-radius: var(--border-radius);
            font-size: 15px;
            transition: var(--transition);
            background-color: #f8f9fa;
        }

        .form-control:focus {
            border-color: var(--accent-color);
            box-shadow: 0 0 0 3px rgba(72, 149, 239, 0.2);
            outline: none;
            background-color: white;
        }

        textarea.form-control {
            min-height: 120px;
            resize: vertical;
        }

        .form-actions {
            grid-column: span 2;
            display: flex;
            justify-content: flex-end;
            gap: 15px;
            margin-top: 20px;
        }

        .btn {
            padding: 12px 25px;
            font-size: 15px;
            font-weight: 500;
            border-radius: var(--border-radius);
            cursor: pointer;
            transition: var(--transition);
            display: inline-flex;
            align-items: center;
            gap: 8px;
            border: none;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
            color: white;
            box-shadow: 0 4px 8px rgba(67, 97, 238, 0.2);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(67, 97, 238, 0.3);
        }

        .btn-secondary {
            background: white;
            color: var(--primary-color);
            border: 2px solid var(--primary-color);
        }

        .btn-secondary:hover {
            background: rgba(67, 97, 238, 0.05);
            transform: translateY(-2px);
        }

        .btn-danger {
            background: white;
            color: var(--danger-color);
            border: 2px solid var(--danger-color);
        }

        .btn-danger:hover {
            background: rgba(247, 37, 133, 0.05);
            transform: translateY(-2px);
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

            form {
                grid-template-columns: 1fr;
            }

            .form-group.full-width {
                grid-column: span 1;
            }

            .form-actions {
                grid-column: span 1;
                flex-direction: column;
            }

            .header-content {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }

            .nav-tabs ul {
                overflow-x: auto;
                white-space: nowrap;
                padding-bottom: 5px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="floating-books book-1"></div>
    <div class="floating-books book-2"></div>

    <div class="header">
        <div class="header-content">
            <a href="dashboard.jsp" class="back-button">
                <i class="fas fa-arrow-left"></i> Back to Dashboard
            </a>
            <div class="header-title">
                <h1>Add New Customer</h1>
                <p>Pahana Edu Bookshop Management System</p>
            </div>
        </div>
    </div>

    <div class="nav-tabs">
        <ul>
            <li><a href="customer.jsp"><i class="fas fa-home"></i> Home</a></li>
            <li class="active"><a href="customer?action=add"><i class="fas fa-user-plus"></i> Add Customer</a></li>
            <li><a href="customer?action=list"><i class="fas fa-users"></i> View Customers</a></li>
        </ul>
    </div>

    <div class="form-container">
        <c:if test="${not empty errorMessage}">
            <div class="error-message">
                <i class="fas fa-exclamation-circle"></i>
                <p>${errorMessage}</p>
            </div>
        </c:if>

        <form action="customer?action=insert" method="post">
            <div class="form-group">
                <label for="accountNumber">Account Number</label>
                <input type="text" id="accountNumber" name="accountNumber" class="form-control" required placeholder="Enter account number">
            </div>

            <div class="form-group">
                <label for="name">Full Name</label>
                <input type="text" id="name" name="name" class="form-control" required placeholder="Enter customer name">
            </div>

            <div class="form-group">
                <label for="telephone">Telephone</label>
                <input type="tel" id="telephone" name="telephone" class="form-control" required placeholder="Enter phone number">
            </div>

            <div class="form-group">
                <label for="units_consumed">Units Consumed</label>
                <input type="number" id="units_consumed" name="unitsConsumed" class="form-control" required placeholder="Enter units consumed">
            </div>

            <div class="form-group full-width">
                <label for="address">Address</label>
                <textarea id="address" name="address" class="form-control" required placeholder="Enter full address"></textarea>
            </div>

            <div class="form-actions">
                <button type="reset" class="btn btn-danger">
                    <i class="fas fa-trash"></i> Clear
                </button>
                <a href="customer?action=list" class="btn btn-secondary">
                    <i class="fas fa-times"></i> Cancel
                </a>
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save"></i> Save Customer
                </button>
            </div>
        </form>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/js/all.min.js"></script>
</body>
</html>