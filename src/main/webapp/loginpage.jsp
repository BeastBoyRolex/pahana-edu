<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pahana Edu - Login</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&family=Montserrat:wght@600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        :root {
            --primary-color: #4361ee;
            --secondary-color: #3f37c9;
            --accent-color: #4895ef;
            --light-color: #f8f9fa;
            --dark-color: #212529;
            --error-color: #f72585;
            --success-color: #4cc9f0;
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
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            color: var(--text-color);
            line-height: 1.6;
        }

        .login-container {
            background-color: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            width: 420px;
            padding: 50px;
            text-align: center;
            position: relative;
            overflow: hidden;
            animation: fadeInUp 0.6s ease-out;
            transform-style: preserve-3d;
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .login-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 8px;
            background: linear-gradient(90deg, var(--primary-color), var(--accent-color));
        }

        .login-header {
            margin-bottom: 40px;
            position: relative;
        }

        .login-header h1 {
            font-family: 'Montserrat', sans-serif;
            color: var(--primary-color);
            font-size: 28px;
            margin: 20px 0 10px;
            font-weight: 700;
            letter-spacing: -0.5px;
        }

        .login-header p {
            color: #7f8c8d;
            font-size: 15px;
            margin: 0;
        }

        .logo {
            width: 80px;
            height: 80px;
            margin: 0 auto;
            background-color: rgba(67, 97, 238, 0.1);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary-color);
            font-size: 32px;
            border: 2px dashed rgba(67, 97, 238, 0.3);
        }

        .login-form {
            text-align: left;
        }

        .form-group {
            margin-bottom: 25px;
            position: relative;
        }

        .form-group label {
            display: block;
            margin-bottom: 10px;
            font-weight: 500;
            color: var(--text-color);
            font-size: 14px;
        }

        .form-group input {
            width: 100%;
            padding: 14px 20px;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            font-size: 15px;
            transition: var(--transition);
            background-color: #f8f9fa;
            box-sizing: border-box;
        }

        .form-group input:focus {
            border-color: var(--accent-color);
            box-shadow: 0 0 0 3px rgba(72, 149, 239, 0.2);
            outline: none;
            background-color: white;
        }

        .form-group i {
            position: absolute;
            right: 15px;
            top: 42px;
            color: #95a5a6;
            font-size: 16px;
        }

        .btn-login {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, var(--primary-color), var(--accent-color));
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            margin-top: 10px;
            box-shadow: 0 4px 6px rgba(67, 97, 238, 0.2);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(67, 97, 238, 0.25);
        }

        .btn-login:active {
            transform: translateY(0);
        }


        .alert {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 25px;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 10px;
            animation: shake 0.5s ease-in-out;
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            10%, 30%, 50%, 70%, 90% { transform: translateX(-5px); }
            20%, 40%, 60%, 80% { transform: translateX(5px); }
        }

        .alert-error {
            background-color: rgba(247, 37, 133, 0.1);
            color: var(--error-color);
            border: 1px solid rgba(247, 37, 133, 0.3);
        }

        .alert i {
            font-size: 18px;
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

        @media (max-width: 480px) {
            .login-container {
                width: 90%;
                padding: 30px;
            }

            .login-header h1 {
                font-size: 24px;
            }
        }
    </style>
</head>
<body>
<div class="login-container">
    <div class="floating-books book-1"></div>
    <div class="floating-books book-2"></div>

    <div class="login-header">
        <div class="logo">
            <i class="fas fa-book-open"></i>
        </div>
        <h1>Pahana Edu Bookshop</h1>
        <p>Colombo City's Leading Bookshop</p>
    </div>

    <%-- Display error message if authentication failed --%>
    <% if (error != null) { %>
    <div class="alert alert-error">
        <i class="fas fa-exclamation-circle"></i>
        <span><%= error %></span>
    </div>
    <% } %>

    <form action="${pageContext.request.contextPath}/login" method="post" class="login-form">
        <div class="form-group">
            <label for="username">Username</label>
            <input type="text" id="username" name="username" required placeholder="Enter your username">
            <i class="fas fa-user"></i>
        </div>

        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" required placeholder="Enter your password">
            <i class="fas fa-lock"></i>
        </div>

        <button type="submit" class="btn-login">
            <i class="fas fa-sign-in-alt"></i> Login
        </button>
    </form>


</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/js/all.min.js"></script>
</body>
</html>