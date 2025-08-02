package com.icbt.servlet;

import com.icbt.model.User;
import com.icbt.service.LoginService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private final LoginService loginService = new LoginService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect(req.getContextPath() + "/loginpage.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        User user = loginService.login(username, password);
        if (user != null) {
            req.getSession().setAttribute("user", user);
            resp.sendRedirect("dashboard.jsp");
        } else {
            req.setAttribute("error", "Invalid username or password.");
            req.getRequestDispatcher("loginpage.jsp").forward(req, resp);
        }
    }
}
