package com.icbt.servlet;

import com.icbt.model.Item;
import com.icbt.service.ItemService;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/items")
public class ItemServlet extends HttpServlet {
    private ItemService itemService;

    @Override
    public void init() {
        this.itemService = new ItemService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "new":
                    showNewForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "view":
                    viewItem(request, response);
                    break;
                case "delete":
                    deleteItem(request, response);
                    break;
                default:
                    listItems(request, response);
            }
        } catch (Exception e) {
            handleError(request, response, e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if (action == null) {
            response.sendRedirect("items");
            return;
        }

        try {
            switch (action) {
                case "add":
                    addItem(request, response);
                    break;
                case "update":
                    updateItem(request, response);
                    break;
                default:
                    response.sendRedirect("items");
            }
        } catch (Exception e) {
            handleError(request, response, e);
        }
    }

    private void listItems(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Item> items = itemService.getAllItems();
        request.setAttribute("items", items);
        request.getRequestDispatcher("item-list.jsp").forward(request, response);
    }

    private void showNewForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("add-item.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String itemId = request.getParameter("id");
        Item item = itemService.getItemById(itemId);

        if (item == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Item not found");
            return;
        }

        request.setAttribute("item", item);
        request.setAttribute("editMode", true);
        request.getRequestDispatcher("edit-item.jsp").forward(request, response);
    }

    private void viewItem(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String itemId = request.getParameter("id");
        Item item = itemService.getItemById(itemId);

        if (item == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Item not found");
            return;
        }

        request.setAttribute("item", item);
        request.getRequestDispatcher("view-item.jsp").forward(request, response);
    }

    private void addItem(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Item item = extractItemFromRequestForCreate(request);

        if (!itemService.addItem(item)) {
            request.setAttribute("error", "Failed to add item. Please try again.");
            showNewForm(request, response);
            return;
        }

        response.sendRedirect("items?success=Item added successfully");
    }

    private void updateItem(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String itemId = request.getParameter("itemId");
        Item item = extractItemFromRequestForUpdate(request);
        item.setItemId(Integer.parseInt(itemId));

        if (!itemService.updateItem(item)) {
            request.setAttribute("error", "Failed to update item. Please try again.");
            request.setAttribute("item", item);
            request.setAttribute("editMode", true);
            request.getRequestDispatcher("edit-item.jsp").forward(request, response);
            return;
        }

        response.sendRedirect("items?success=Item updated successfully");
    }

    private void deleteItem(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String itemId = request.getParameter("id");

        if (!itemService.deleteItem(itemId)) {
            response.sendRedirect("items?error=Failed to delete item");
            return;
        }

        response.sendRedirect("items?success=Item deleted successfully");
    }

    private Item extractItemFromRequestForCreate(HttpServletRequest request) {
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String publisher = request.getParameter("publisher");
        String category = request.getParameter("category");
        double price = Double.parseDouble(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String description = request.getParameter("description");

        // Auto-generate a simple integer ID (mapped to VARCHAR in DB by DAO)
        int generatedId = (int) (System.currentTimeMillis() / 1000);
        return new Item(generatedId, title, author, publisher, category, price, quantity);
    }

    private Item extractItemFromRequestForUpdate(HttpServletRequest request) {
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String publisher = request.getParameter("publisher");
        String category = request.getParameter("category");
        double price = Double.parseDouble(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String description = request.getParameter("description");

        return new Item(0, title, author, publisher, category, price, quantity);
    }

    private void handleError(HttpServletRequest request, HttpServletResponse response, Exception e)
            throws ServletException, IOException {
        e.printStackTrace();
        request.setAttribute("error", "An error occurred: " + e.getMessage());
        listItems(request, response);
    }
}