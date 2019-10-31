package com.fh.shop.mapper.user;

import com.fh.shop.model.user.User;

import java.util.List;
import java.util.Map;

public interface UserDao {
    public List<User> queryList();
    public void add (User user);
    public void delete(Long id);
    public User queryGetId(Long id);
    public void update(User user);


    public List<User> queryUserList(Map<String,Object> map);
    public Integer queryUserCount(Map<String,Object> map);
}
