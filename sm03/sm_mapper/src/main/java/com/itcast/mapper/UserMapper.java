package com.itcast.mapper;

import com.itcast.domain.User;

import java.util.List;
import java.util.Map;

public interface UserMapper {
    List<User> findAll(Map map);

    Integer findTotalCount(Map map);

    void addUser(User user);

    void deleteUser(String id);

    User findById(String id);

    void updateUser(User user);

    User findUser(User user);

    User findByUserName(String username);
}
