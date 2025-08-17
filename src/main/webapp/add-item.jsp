<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Add New Book - Pahana Edu Bookshop</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
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
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
            color: var(--dark-color);
            line-height: 1.6;
        }

        .container {
            max-width: 800px;
            margin: 40px auto;
            padding: 30px;
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            animation: fadeIn 0.6s ease-in-out;
            position: relative;
            overflow: hidden;
        }

        .container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 10px;
            background: linear-gradient(90deg, var(--primary-color), var(--accent-color));
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        h1 {
            color: var(--primary-color);
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 2px solid #eee;
            position: relative;
            font-weight: 600;
            flex-grow: 1;
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

        .top-back-btn {
            background-color: white;
            color: var(--primary-color);
            border: 2px solid var(--primary-color);
            padding: 10px 20px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
            margin-right: 20px;
        }

        .top-back-btn:hover {
            background-color: #f0f4ff;
            transform: translateY(-2px);
        }

        .form-group {
            margin-bottom: 20px;
            position: relative;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--dark-color);
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            font-size: 16px;
            transition: all 0.3s ease;
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

        .btn-group {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 12px 25px;
            font-size: 16px;
            font-weight: 500;
            border-radius: 8px;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.3s ease;
            border: none;
            flex: 1;
        }

        .btn i {
            margin-right: 8px;
        }

        .btn-primary {
            background-color: var(--primary-color);
            color: white;
            box-shadow: 0 4px 6px rgba(67, 97, 238, 0.2);
        }

        .btn-primary:hover {
            background-color: var(--secondary-color);
            transform: translateY(-2px);
            box-shadow: 0 6px 8px rgba(67, 97, 238, 0.3);
        }

        .btn-back {
            background-color: white;
            color: var(--primary-color);
            border: 2px solid var(--primary-color);
        }

        .btn-back:hover {
            background-color: #f0f4ff;
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
                padding: 20px;
            }

            .header {
                flex-direction: column;
                align-items: flex-start;
            }

            .top-back-btn {
                margin-bottom: 15px;
                margin-right: 0;
                width: 100%;
                justify-content: center;
            }

            .btn-group {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="floating-books book-1"></div>
    <div class="floating-books book-2"></div>

    <div class="header">
        <a href="javascript:history.back()" class="top-back-btn">
            <i class="fas fa-arrow-left"></i> Back

        </a>
        <h1>Add New Book</h1>
    </div>

    <form action="items?action=add" method="post">
        <div class="form-group">
            <label for="itemCode">Book Code:</label>
            <input type="text" id="itemCode" name="itemCode" required class="form-control" placeholder="Enter unique book code">
        </div>

        <div class="form-group">
            <label for="title">Title:</label>
            <input type="text" id="title" name="title" required class="form-control" placeholder="Enter book title">
        </div>

        <div class="form-group">
            <label for="author">Author:</label>
            <input type="text" id="author" name="author" class="form-control" placeholder="Enter author name">
        </div>

        <div class="form-group">
            <label for="publisher">Publisher:</label>
            <input type="text" id="publisher" name="publisher" class="form-control" placeholder="Enter publisher name">
        </div>

        <div class="form-group">
            <label for="category">Category:</label>
            <input type="text" id="category" name="category" class="form-control" placeholder="Enter book category">
        </div>

        <div class="form-group">
            <label for="price">Price ($):</label>
            <input type="number" step="0.01" id="price" name="price" required class="form-control" placeholder="Enter price">
        </div>

        <div class="form-group">
            <label for="quantity">Quantity:</label>
            <input type="number" id="quantity" name="quantity" required class="form-control" placeholder="Enter quantity">
        </div>

        <div class="form-group">
            <label for="description">Description:</label>
            <textarea id="description" name="description" class="form-control" placeholder="Enter book description"></textarea>
        </div>

        <div class="btn-group">
            <button type="submit" class="btn btn-primary">
                <i class="fas fa-save"></i> Save Book
            </button>
            <a href="items" class="btn btn-back">
                <i class="fas fa-times"></i> Cancel
            </a>
        </div>
    </form>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/js/all.min.js"></script>
</body>
</html>