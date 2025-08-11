package com.icbt.servlet;

import com.icbt.model.Bill;
import com.icbt.model.BillItem;
import com.icbt.service.BillService;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/bill")
public class BillServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BillService billService;

    public void init() {
        billService = new BillService();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if (action == null) {
                action = "list";
            }

            switch (action) {
                case "generate":
                    showGenerateForm(request, response);
                    break;
                case "view":
                    viewBill(request, response);
                    break;
                case "customer":
                    listCustomerBills(request, response);
                    break;
                case "print":
                    printBill(request, response);
                    break;
                case "list":
                default:
                    listBills(request, response);
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
                case "generate":
                    generateBill(request, response);
                    break;
                case "updateStatus":
                    updateBillStatus(request, response);
                    break;
                case "markPaid":
                    markBillAsPaid(request, response);
                    break;
                default:
                    listBills(request, response);
                    break;
            }
        } catch (Exception e) {
            handleError(request, response, e);
        }
    }

    private void listBills(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("listBills.jsp").forward(request, response);
    }

    private void showGenerateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("generateBill.jsp").forward(request, response);
    }

    private void viewBill(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int billId = Integer.parseInt(request.getParameter("billId"));
        Bill bill = billService.getBill(billId);
        request.setAttribute("bill", bill);
        request.getRequestDispatcher("viewBill.jsp").forward(request, response);
    }

    private void printBill(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int billId = Integer.parseInt(request.getParameter("billId"));
        Bill bill = billService.getBill(billId);
        request.setAttribute("bill", bill);
        request.getRequestDispatcher("printBill.jsp").forward(request, response);
    }

    private void listCustomerBills(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accountNumber = request.getParameter("accountNumber");
        List<Bill> bills = billService.getCustomerBills(accountNumber);
        request.setAttribute("bills", bills);
        request.setAttribute("accountNumber", accountNumber);
        request.getRequestDispatcher("customerBills.jsp").forward(request, response);
    }

    private void generateBill(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ParseException {
        // Get form parameters
        String accountNumber = request.getParameter("accountNumber");
        String billDateStr = request.getParameter("billDate");
        String dueDateStr = request.getParameter("dueDate");

        // Parse dates
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date billDate = dateFormat.parse(billDateStr);
        Date dueDate = dateFormat.parse(dueDateStr);

        // Process items
        String[] descriptions = request.getParameterValues("description");
        String[] quantities = request.getParameterValues("quantity");
        String[] unitPrices = request.getParameterValues("unitPrice");

        List<BillItem> items = new ArrayList<>();
        double total = 0;

        for (int i = 0; i < descriptions.length; i++) {
            String description = descriptions[i];
            int quantity = Integer.parseInt(quantities[i]);
            double unitPrice = new Double(unitPrices[i]);
            double amount = unitPrice * quantity;

            BillItem item = new BillItem();
            item.setDescription(description);
            item.setQuantity(quantity);
            item.setUnitPrice(unitPrice);
            item.setAmount(amount);

            items.add(item);
            total +=amount;
        }

        Bill bill = new Bill();
        bill.setAccountNumber(accountNumber);
        bill.setBillDate(billDate);
        bill.setDueDate(dueDate);
        bill.setTotalAmount(total);
        bill.setItems(items);

        // Save to database through service
        Bill savedBill = billService.saveBill(bill);

        // Set attributes for JSP
        request.setAttribute("bill", savedBill);
        request.setAttribute("items", items);
        request.setAttribute("total", total);

        // Forward to print page
        request.getRequestDispatcher("printBill.jsp").forward(request, response);
    }

    private void updateBillStatus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int billId = Integer.parseInt(request.getParameter("billId"));
        String status = request.getParameter("status");

        billService.updateBillStatus(billId, status);
        response.sendRedirect("bill?action=view&billId=" + billId);
    }

    private void markBillAsPaid(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int billId = Integer.parseInt(request.getParameter("billId"));
        billService.markBillAsPaid(billId);
        response.sendRedirect("bill?action=view&billId=" + billId);
    }

    private void handleError(HttpServletRequest request, HttpServletResponse response, Exception e)
            throws ServletException, IOException {
        request.setAttribute("errorMessage", "Error: " + e.getMessage());
        listBills(request, response);
    }
}