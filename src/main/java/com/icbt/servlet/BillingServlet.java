package com.icbt.servlet;

import com.icbt.service.BillingService;
import com.icbt.model.Bill;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/bill")
public class BillingServlet extends HttpServlet {
    private BillingService billingService;

    @Override
    public void init() {
        this.billingService = new BillingService();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("generate".equals(action)) {
            String accountNumber = request.getParameter("accountNumber");
            int unitsConsumed = Integer.parseInt(request.getParameter("unitsConsumed"));

            boolean success = billingService.generateBill(accountNumber, unitsConsumed);

            if (success) {
                request.setAttribute("message", "Bill generated successfully!");
            } else {
                request.setAttribute("error", "Failed to generate bill.");
            }
            request.getRequestDispatcher("calculateBill.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("view".equals(action)) {
            String accountNumber = request.getParameter("accountNumber");
            List<Bill> bills = billingService.getCustomerBills(accountNumber);

            request.setAttribute("bills", bills);
            request.getRequestDispatcher("billDetails.jsp").forward(request, response);
        } else if ("details".equals(action)) {
            int billId = Integer.parseInt(request.getParameter("billId"));
            Bill bill = billingService.getBillDetails(billId);

            if (bill != null) {
                request.setAttribute("bill", bill);
                request.getRequestDispatcher("billView.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Bill not found.");
                request.getRequestDispatcher("index.jsp").forward(request, response);
            }
        }
    }
}
