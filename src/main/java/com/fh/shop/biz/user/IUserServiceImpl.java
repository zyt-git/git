package com.fh.shop.biz.user;

import com.fh.shop.mapper.user.UserDao;
import com.fh.shop.model.user.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class IUserServiceImpl implements IUserService {
    @Autowired
    private UserDao userDao;

    @Override
    public List<User> queryList() {
        return userDao.queryList();
    }

    @Override
    public void add(User user) {
        userDao.add(user);
    }

    @Override
    public void delete(Long id) {
        userDao.delete(id);
    }

    @Override
    public User queryGetId(Long id) {
        return userDao.queryGetId(id);
    }

    @Override
    public void update(User user) {
        userDao.update(user);
    }

    //datatable  服务端分页
    @Override
    public List<User> queryUserList(Map<String, Object> map) {
        return userDao.queryUserList(map);
    }

    @Override
    public Integer queryUserCount(Map<String, Object> map) {
        return userDao.queryUserCount(map);
    }
}
