package com.icbt.service;

import com.icbt.dao.UserDAO;
import com.icbt.model.User;

public class LoginService {
    private UserDAO userDAO = new UserDAO();

    public User login(String username, String password) {
        return userDAO.getUserByUsernameAndPassword(username, password);
    }
}
