package com.icbt.service;

import com.icbt.dao.BillingDAO;
import com.icbt.model.Bill;
import java.util.Date;
import java.util.List;

public class BillingService {
    private BillingDAO billingDAO;

    public BillingService() {
        this.billingDAO = new BillingDAO();
    }

    public boolean generateBill(String accountNumber, int unitsConsumed) {
        double amount = calculateBillAmount(unitsConsumed);
        Bill bill = new Bill(accountNumber, new Date(), unitsConsumed, amount, "Unpaid");
        return billingDAO.addBill(bill);
    }

    public List<Bill> getCustomerBills(String accountNumber) {
        return billingDAO.getBillsByAccount(accountNumber);
    }

    public Bill getBillDetails(int billId) {
        return billingDAO.getBill(billId);
    }

    private double calculateBillAmount(int unitsConsumed) {
        // Implement your billing calculation logic here
        // For example:
        double amount = 0;

        if (unitsConsumed <= 50) {
            amount = unitsConsumed * 10;
        } else if (unitsConsumed <= 100) {
            amount = 50 * 10 + (unitsConsumed - 50) * 15;
        } else {
            amount = 50 * 10 + 50 * 15 + (unitsConsumed - 100) * 20;
        }

        return amount;
    }
}