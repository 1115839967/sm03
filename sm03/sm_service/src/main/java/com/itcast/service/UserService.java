package com.itcast.service;

import com.itcast.domain.PageBean;
import com.itcast.domain.User;

import java.util.List;
import java.util.Map;

public interface UserService {
    PageBean findByPage(Map map);

    void addUser(User user);

    void deleteUser(String id);

    User findById(String id);

    void updateUser(User user);

    User findUser(User user);

    boolean findByUserName(String username);
}
