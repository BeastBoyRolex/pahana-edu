package com.icbt.servlet;

import com.icbt.model.Bill;
import com.icbt.model.BillItem;
import com.icbt.model.Customer;
import com.icbt.model.Item;
import com.icbt.service.BillService;
import com.icbt.service.CustomerService;
import com.icbt.service.ItemService;
import java.io.IOException;
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
    private final BillService billService = new BillService();
    private final CustomerService customerService = new CustomerService();
    private final ItemService itemService = new ItemService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if (action == null) {
                action = "list";
            }

            switch (action) {
                case "new":
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
                    processBillGeneration(request, response);
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
        try {
            List<Bill> bills = billService.getAllBills();
            request.setAttribute("bills", bills);
            request.getRequestDispatcher("listBills.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error loading bills: " + e.getMessage());
            request.getRequestDispatcher("listBills.jsp").forward(request, response);
        }
    }

    private void showGenerateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Customer> customers = customerService.getAllCustomers();
            List<Item> items = itemService.getAllItems();

            request.setAttribute("customers", customers);
            request.setAttribute("items", items);
            request.getRequestDispatcher("generateBill.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error loading form data: " + e.getMessage());
            request.getRequestDispatcher("generateBill.jsp").forward(request, response);
        }
    }

    private void viewBill(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String billId = request.getParameter("billId");
        if (billId == null || billId.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Bill ID is required");
            listBills(request, response);
            return;
        }

        try {
            Bill bill = billService.getBillById(billId);
            request.setAttribute("bill", bill);
            request.getRequestDispatcher("viewBill.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error loading bill: " + e.getMessage());
            listBills(request, response);
        }
    }

    private void printBill(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String billId = request.getParameter("billId");
        if (billId == null || billId.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Bill ID is required");
            listBills(request, response);
            return;
        }

        try {
            Bill bill = billService.getBillById(billId);
            request.setAttribute("bill", bill);
            request.getRequestDispatcher("printBill.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error loading bill: " + e.getMessage());
            listBills(request, response);
        }
    }

    private void listCustomerBills(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accountNumber = request.getParameter("accountNumber");
        if (accountNumber == null || accountNumber.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Account number is required");
            listBills(request, response);
            return;
        }

        try {
            List<Bill> bills = billService.getBillsByCustomer(accountNumber);
            request.setAttribute("bills", bills);
            request.setAttribute("accountNumber", accountNumber);
            request.getRequestDispatcher("customerBills.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error loading customer bills: " + e.getMessage());
            listBills(request, response);
        }
    }

    private void processBillGeneration(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ParseException {
        try {
            // Get form data
            String accountNumber = request.getParameter("accountNumber");
            String billDateStr = request.getParameter("billDate");
            String dueDateStr = request.getParameter("dueDate");

            // Validate required fields
            if (accountNumber == null || accountNumber.trim().isEmpty()) {
                throw new IllegalArgumentException("Customer account is required");
            }
            if (billDateStr == null || billDateStr.trim().isEmpty()) {
                throw new IllegalArgumentException("Bill date is required");
            }
            if (dueDateStr == null || dueDateStr.trim().isEmpty()) {
                throw new IllegalArgumentException("Due date is required");
            }

            // Parse dates
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date billDate = sdf.parse(billDateStr);
            Date dueDate = sdf.parse(dueDateStr);

            // Validate dates
            if (billDate.after(dueDate)) {
                throw new IllegalArgumentException("Due date must be after bill date");
            }

            // Create bill object
            Bill bill = new Bill();
            bill.setAccountNumber(accountNumber);
            bill.setBillDate(billDate);
            bill.setDueDate(dueDate);

            // Get bill items
            String[] itemIds = request.getParameterValues("itemId[]");
            String[] quantities = request.getParameterValues("quantity[]");
            String[] unitPrices = request.getParameterValues("unitPrice[]");

            if (itemIds == null || itemIds.length == 0) {
                throw new IllegalArgumentException("At least one item is required");
            }

            List<BillItem> items = new ArrayList<>();
            for (int i = 0; i < itemIds.length; i++) {
                if (itemIds[i] == null || itemIds[i].trim().isEmpty()) {
                    continue; // Skip empty rows
                }
                
                BillItem item = new BillItem();
                item.setItemId(itemIds[i]);
                item.setQuantity(Integer.parseInt(quantities[i]));
                item.setUnitPrice(Double.parseDouble(unitPrices[i]));
                items.add(item);
            }

            if (items.isEmpty()) {
                throw new IllegalArgumentException("At least one valid item is required");
            }

            // Generate bill
            boolean success = billService.generateBill(bill, items);

            if (success) {
                request.setAttribute("message", "Bill generated successfully!");
                response.sendRedirect("bill?action=list");
            } else {
                request.setAttribute("error", "Failed to generate bill. Please check stock availability.");
                showGenerateForm(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid quantity or price format");
            showGenerateForm(request, response);
        } catch (ParseException e) {
            request.setAttribute("error", "Invalid date format");
            showGenerateForm(request, response);
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            showGenerateForm(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error generating bill: " + e.getMessage());
            showGenerateForm(request, response);
        }
    }

    private void updateBillStatus(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String billId = request.getParameter("billId");
        String status = request.getParameter("status");

        if (billId == null || billId.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Bill ID is required");
            listBills(request, response);
            return;
        }

        try {
            billService.updateBillStatus(billId, status);
            request.setAttribute("message", "Bill status updated successfully");
            response.sendRedirect("bill?action=view&billId=" + billId);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error updating bill status: " + e.getMessage());
            response.sendRedirect("bill?action=view&billId=" + billId);
        }
    }

    private void markBillAsPaid(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String billId = request.getParameter("billId");
        
        if (billId == null || billId.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Bill ID is required");
            listBills(request, response);
            return;
        }

        try {
            billService.markBillAsPaid(billId);
            request.setAttribute("message", "Bill marked as paid successfully");
            response.sendRedirect("bill?action=view&billId=" + billId);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error marking bill as paid: " + e.getMessage());
            response.sendRedirect("bill?action=view&billId=" + billId);
        }
    }

    private void handleError(HttpServletRequest request, HttpServletResponse response, Exception e)
            throws ServletException, IOException {
        request.setAttribute("errorMessage", "Error: " + e.getMessage());
        listBills(request, response);
    }
}