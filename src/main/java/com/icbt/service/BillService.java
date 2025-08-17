package com.icbt.service;

import com.icbt.dao.BillDAO;
import com.icbt.model.Bill;
import com.icbt.model.BillItem;
import com.icbt.model.Item;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class BillService {
    private final BillDAO billDAO;
    private final ItemService itemService;

    public BillService() {
        this.billDAO = new BillDAO();
        this.itemService = new ItemService();
    }

    public boolean generateBill(Bill bill, List<BillItem> items) {
        try {
            // Validate inputs
            if (bill == null) {
                throw new IllegalArgumentException("Bill cannot be null");
            }
            if (items == null || items.isEmpty()) {
                throw new IllegalArgumentException("Bill items cannot be empty");
            }
            if (bill.getBillDate() == null || bill.getDueDate() == null) {
                throw new IllegalArgumentException("Dates cannot be null");
            }
            if (bill.getBillDate().after(bill.getDueDate())) {
                throw new IllegalArgumentException("Due date must be after bill date");
            }

            // Calculate total amount and set descriptions
            double totalAmount = 0.0;
            for (BillItem item : items) {
                // Get item details to set description
                Item dbItem = itemService.getItemById(item.getItemId());
                if (dbItem == null) {
                    throw new RuntimeException("Item not found: " + item.getItemId());
                }
                
                // Set description from item title
                item.setDescription(dbItem.getTitle());
                
                // Calculate amount for this item
                double itemAmount = item.getQuantity() * item.getUnitPrice();
                item.setAmount(itemAmount);
                totalAmount += itemAmount;
                
                // Check stock availability
//                if (dbItem.getQuantity() < item.getQuantity()) {
//                    throw new RuntimeException("Not enough stock for item: " + dbItem.getTitle());
//                }
            }
            
            bill.setTotalAmount(totalAmount);

            // Generate bill ID if not set
            if (bill.getBillId() == null || bill.getBillId().isEmpty()) {
                bill.setBillId("BILL-" + System.currentTimeMillis());
            }

            // Set default status if not set
            if (bill.getStatus() == null || bill.getStatus().isEmpty()) {
                bill.setStatus("Pending");
            }

            // Update stock and generate bill
            for (BillItem item : items) {
                itemService.updateStock(item.getItemId(), -item.getQuantity());
            }

            return billDAO.generateBill(bill, items);
        } catch (Exception e) {
            throw new RuntimeException("Error generating bill: " + e.getMessage(), e);
        }
    }

    public Bill generateBill(String accountNumber, List<BillItem> items, Date billDate, Date dueDate) {
        Bill bill = new Bill();
        bill.setAccountNumber(accountNumber);
        bill.setBillDate(billDate);
        bill.setDueDate(dueDate);

        if (!generateBill(bill, items)) {
            throw new RuntimeException("Failed to generate bill");
        }
        return bill;
    }

    public Bill getBillById(String billId) {
        try {
            if (billId == null || billId.isEmpty()) {
                throw new IllegalArgumentException("Bill ID cannot be empty");
            }
            Bill bill = billDAO.getBillById(billId);
            if (bill == null) {
                throw new RuntimeException("Bill not found with ID: " + billId);
            }
            return bill;
        } catch (Exception e) {
            throw new RuntimeException("Error retrieving bill: " + e.getMessage(), e);
        }
    }

    public List<Bill> getBillsByCustomer(String accountNumber) {
        try {
            if (accountNumber == null || accountNumber.isEmpty()) {
                throw new IllegalArgumentException("Account number cannot be empty");
            }
            List<Bill> bills = billDAO.getBillsByCustomer(accountNumber);
            if (bills == null) {
                return new ArrayList<>();
            }
            return bills;
        } catch (Exception e) {
            throw new RuntimeException("Error retrieving customer bills: " + e.getMessage(), e);
        }
    }

    public List<Bill> getAllBills() {
        try {
            List<Bill> bills = billDAO.getAllBills();
            if (bills == null) {
                return new ArrayList<>();
            }
            return bills;
        } catch (Exception e) {
            throw new RuntimeException("Error retrieving all bills: " + e.getMessage(), e);
        }
    }

    public boolean updateBillStatus(String billId, String status) {
        try {
            if (billId == null || billId.isEmpty()) {
                throw new IllegalArgumentException("Bill ID cannot be empty");
            }
            if (status == null || status.isEmpty()) {
                throw new IllegalArgumentException("Status cannot be empty");
            }
            return billDAO.updateBillStatus(billId, status);
        } catch (Exception e) {
            throw new RuntimeException("Error updating bill status: " + e.getMessage(), e);
        }
    }

    public void markBillAsPaid(String billId) {
        updateBillStatus(billId, "PAID");
    }
}