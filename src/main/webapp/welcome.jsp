<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.icbt.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Welcome</title>
</head>
<body>
<h2>Welcome, <%= user.getUsername() %>!</h2>
<p>Email: <%= user.getEmail() %></p>
<p>Created At: <%= user.getCreatedAt() %></p>
<a href="logout">Logout</a>
</body>
</html>
