package com.icbt.service;

import com.icbt.dao.ItemDAO;
import com.icbt.model.Item;
import java.util.List;

public class ItemService {
    private final ItemDAO itemDAO;

    public ItemService() {
        this.itemDAO = new ItemDAO();
    }

    public List<Item> getAllItems() {
        return itemDAO.getAllItems();
    }

    public Item getItemById(String itemId) {
        return itemDAO.getItemById(itemId);
    }

    public boolean addItem(Item item) {
        return itemDAO.addItem(item);
    }

    public boolean updateItem(Item item) {
        return itemDAO.updateItem(item);
    }

    public boolean deleteItem(String itemId) {
        return itemDAO.deleteItem(itemId);
    }

    public boolean updateStock(String itemId, int quantity) {
        return itemDAO.updateStock(itemId, quantity);
    }
}