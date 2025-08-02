package com.icbt.service;

import com.icbt.dao.CustomerDAO;
import com.icbt.model.Customer;
import java.util.List;

public class CustomerService  {
    private CustomerDAO customerDAO;

    public CustomerService() {
        this.customerDAO = new CustomerDAO();
    }

    public void addCustomer(Customer customer) {
        try {
            if (customer.getAccountNumber() == null || customer.getAccountNumber().isEmpty()) {
                throw new IllegalArgumentException("Account number cannot be empty");
            }
            customerDAO.addCustomer(customer);
        } catch (Exception e) {
            throw new RuntimeException("Error adding customer: " + e.getMessage(), e);
        }
    }

    public boolean updateCustomer(Customer customer) {
        try {
            if (customer.getAccountNumber() == null || customer.getAccountNumber().isEmpty()) {
                throw new IllegalArgumentException("Account number cannot be empty");
            }
            return customerDAO.updateCustomer(customer);
        } catch (Exception e) {
            throw new RuntimeException("Error updating customer: " + e.getMessage(), e);
        }
    }

    public Customer getCustomer(String accountNumber) {
        try {
            if (accountNumber == null || accountNumber.isEmpty()) {
                throw new IllegalArgumentException("Account number cannot be empty");
            }
            return customerDAO.getCustomerByAccountNumber(accountNumber);
        } catch (Exception e) {
            throw new RuntimeException("Error retrieving customer: " + e.getMessage(), e);
        }
    }

    public List<Customer> getAllCustomers() {
        try {
            return customerDAO.getAllCustomers();
        } catch (Exception e) {
            throw new RuntimeException("Error retrieving all customers: " + e.getMessage(), e);
        }
    }
}
