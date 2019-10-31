package com.fh.shop.controller.user;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.fh.shop.biz.user.IUserService;
import com.fh.shop.model.user.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;


import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value="user",produces = "text/html;charset=UTF-8"   )
public class UserController {
    @Autowired
    private IUserService userService;

    @RequestMapping("/totable")
    public String totable(){
        return "/user/usertable";
    }

    @RequestMapping("/queryListJson")
    @ResponseBody
    public String queryListJson(){
        List<User> list=userService.queryList();
        return JSON.toJSONString(list);
    }
    @RequestMapping("/totable1")
    public String totable1(){
        return "/user/usertable1";
    }
    @RequestMapping("/queryListJson1")
    @ResponseBody
    public String queryListJson1(Integer start,Integer length,Integer draw,String realName,String userName){
        Map<String,Object> map=new HashMap<String,Object>();
        map.put("start",start);
        map.put("length",length);
        map.put("realName",realName);
        map.put("userName",userName);
        List<User> list = userService.queryUserList(map);
        Integer count= userService.queryUserCount(map);
        Map<String,Object> map1=new HashMap<String,Object>();
        map1.put("draw", draw);
        map1.put("recordsTotal", count);
        map1.put("recordsFiltered", count);
        map1.put("data", list);
        String string = JSONArray.toJSONString(map1);
        return string;
    }


    @RequestMapping("/add")
    public String add(User user){
        userService.add(user);
        return "redirect:/user/totable1.do";
    }

    @RequestMapping("/del")
    public String del(Long id){
        userService.delete(id);
        return "redirect:/user/totable1.do";
    }

    @RequestMapping("/update")
    public String update(User user){
        userService.update(user);
        return "redirect:/user/totable1.do";
    }



}
