package com.itcast.service.impl;

import com.itcast.domain.PageBean;
import com.itcast.domain.User;
import com.itcast.mapper.UserMapper;
import com.itcast.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;

    public PageBean findByPage(Map map) {
        int currentPage = Integer.parseInt((String) map.get("currentPage"));
        int rows = Integer.parseInt((String) map.get("rows"));
        int begin = (currentPage - 1) * rows;
        map.put("begin",begin);
        map.put("rows",rows);
        PageBean pageBean = new PageBean();
        Integer totalCount = userMapper.findTotalCount(map);
        pageBean.setTotalCount(totalCount);
        List<User> list = userMapper.findAll(map);
        pageBean.setList(list);
        int totalPage = totalCount%rows == 0 ? totalCount/rows : totalCount/rows + 1;
        pageBean.setCurrentPage(currentPage);
        pageBean.setRows(rows);
        pageBean.setTotalPage(totalPage);
        return pageBean;
    }

    public void addUser(User user) {
        userMapper.addUser(user);
    }

    public void deleteUser(String id) {
        userMapper.deleteUser(id);
    }

    public User findById(String id) {
        return userMapper.findById(id);
    }

    public void updateUser(User user) {
        userMapper.updateUser(user);
    }

    public User findUser(User user) {
        return userMapper.findUser(user);
    }

    public boolean findByUserName(String username) {
        User user = userMapper.findByUserName(username);

        return user==null;
    }
}
