package com.icbt.servlet;

import com.icbt.model.Customer;
import com.icbt.service.CustomerService;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/customer")
public class CustomerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CustomerService customerService;

    public void init() {
        customerService = new CustomerService();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            switch (action) {
                case "new":
                    showNewForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "list":
                default:
                    listCustomers(request, response);
                    break;
            }
        } catch (Exception e) {
            handleError(request, response, e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            switch (action) {
                case "insert":
                    insertCustomer(request, response);
                    break;
                case "update":
                    updateCustomer(request, response);
                    break;
                default:
                    listCustomers(request, response);
                    break;
            }
        } catch (Exception e) {
            handleError(request, response, e);
        }
    }

    private void listCustomers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Customer> listCustomer = customerService.getAllCustomers();
        request.setAttribute("listCustomer", listCustomer);
        request.getRequestDispatcher("listCustomers.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("addCustomer.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accountNumber = request.getParameter("accountNumber");
        Customer existingCustomer = customerService.getCustomer(accountNumber);
        request.setAttribute("customer", existingCustomer);
        request.getRequestDispatcher("editCustomer.jsp").forward(request, response);
    }

    private void insertCustomer(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        String accountNumber = request.getParameter("accountNumber");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String telephone = request.getParameter("telephone");
        int unitsConsumed = Integer.parseInt(request.getParameter("unitsConsumed"));

        Customer newCustomer = new Customer(accountNumber, name, address, telephone, unitsConsumed);
        customerService.addCustomer(newCustomer);
        response.sendRedirect("customer?action=list");
    }

    private void updateCustomer(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        String accountNumber = request.getParameter("accountNumber");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String telephone = request.getParameter("telephone");
        int unitsConsumed = Integer.parseInt(request.getParameter("unitsConsumed"));

        Customer customer = new Customer(accountNumber, name, address, telephone, unitsConsumed);
        customerService.updateCustomer(customer);
        response.sendRedirect("customer?action=list");
    }

    private void handleError(HttpServletRequest request, HttpServletResponse response, Exception e)
            throws ServletException, IOException {
        request.setAttribute("errorMessage", "Error: " + e.getMessage());
        listCustomers(request, response);
    }
}
