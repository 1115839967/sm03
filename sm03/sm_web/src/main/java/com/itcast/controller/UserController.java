package com.itcast.controller;

import com.alibaba.druid.support.json.JSONUtils;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.itcast.domain.Md5Util;
import com.itcast.domain.PageBean;
import com.itcast.domain.ResultInfo;
import com.itcast.domain.User;
import com.itcast.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;
    @RequestMapping("/login")
    public String login(){
        return "login";
    }

    //登录
    @RequestMapping("/loginUser")
    public @ResponseBody ResultInfo loginUser(Integer ck,HttpServletRequest request, HttpServletResponse response,User user,String checkeCode) throws IOException {
        String checkcode_server = (String) request.getSession().getAttribute("CHECKCODE_SERVER");
        User user1 = userService.findUser(user);
        ResultInfo info = new ResultInfo();
        if(checkeCode==null || !checkeCode.equalsIgnoreCase(checkcode_server)){
            info.setFlag(false);
            info.setErrorMsg("验证码错误");
            /*ObjectMapper mapper = new ObjectMapper();
            String json = mapper.writeValueAsString(info);
            response.setContentType("application/json;charset=utf-8");
            response.getWriter().write(json);*/
            return info;
        }
        if(user1==null){
            info.setFlag(false);
            info.setErrorMsg("用户名或密码错误");
            /*ObjectMapper mapper = new ObjectMapper();
            String json = mapper.writeValueAsString(info);
            response.setContentType("application/json;charset=utf-8");
            response.getWriter().write(json);*/
            return info;
        }
        HttpSession session = request.getSession();
        session.setAttribute("user",user);
        //有值且为1表示记住，否则不记住
        //记住用户名和密码，将用户和密码存在cookie中
        Cookie cookieName = new Cookie("username",user.getUsername());
        Cookie cookiePassword = new Cookie("password",user.getPassword());
        if(ck!=null&&ck==1){
            //2.设置Cookie存活时间
            cookieName.setMaxAge(7*24*60*60);
            cookiePassword.setMaxAge(7*24*60*60);
        }else {
            cookieName.setMaxAge(0);
            cookiePassword.setMaxAge(0);
        }
        response.addCookie(cookieName);
        response.addCookie(cookiePassword);
        cookieName.setPath("/");
        cookiePassword.setPath("/");

        info.setFlag(true);
        /*ObjectMapper mapper = new ObjectMapper();
        String json = mapper.writeValueAsString(info);
        response.setContentType("application/json;charset=utf-8");
        response.getWriter().write(json);*/

        return info;
    }

    @RequestMapping("findByPage")
    public ModelAndView findByPage(@RequestParam(value = "currentPage",defaultValue = "1")String currentPage,
                                   @RequestParam(value = "rows",defaultValue = "5")String rows,User user,Map map){
        ModelAndView mv = new ModelAndView();
        map.put("name",user.getName());
        map.put("address",user.getAddress());
        map.put("email",user.getEmail());
        map.put("currentPage",currentPage);
        map.put("rows",rows);
        mv.addObject("map",map);
        PageBean pageBean = userService.findByPage(map);
        mv.addObject("pageBean",pageBean);
        mv.setViewName("list");
        return mv;
    }

    @RequestMapping("add")
    public String add(){
        return "add";
    }

    //添加用户
    @RequestMapping("/addUser")
    public @ResponseBody ResultInfo addUser(HttpServletResponse response,User user) throws IOException {
        try {
            user.setPassword(Md5Util.encodeByMd5(user.getPassword()));
        } catch (Exception e) {
            e.printStackTrace();
        }
        boolean flag = userService.findByUserName(user.getUsername());

        ResultInfo info = new ResultInfo();
        if(flag){
            userService.addUser(user);
            info.setFlag(flag);
            /*ObjectMapper mapper = new ObjectMapper();
            String json = mapper.writeValueAsString(info);
            response.setContentType("application/json;charset=utf-8");
            response.getWriter().write(json);*/
            return info;
        }else {
            info.setFlag(flag);
            info.setErrorMsg("用户名已存在");
            /*ObjectMapper mapper = new ObjectMapper();
            String json = mapper.writeValueAsString(info);
            response.setContentType("application/json;charset=utf-8");
            response.getWriter().write(json);*/
            return info;
        }
    }

    //删除单个
    @RequestMapping("/deleteUser")
    public String deleteUser(String id){
        userService.deleteUser(id);
        return "redirect:findByPage";
    }

    //删除选中
    @RequestMapping("/deleteUserAll")
    public String deleteUserAll(String[] uid){
        for (String id : uid) {
            userService.deleteUser(id);
        }
        return "redirect:findByPage";
    }

    //修改回显
    @RequestMapping("/findById")
    public ModelAndView findById(String id){
        ModelAndView mv = new ModelAndView();
        User user = userService.findById(id);
        mv.addObject("user",user);
        mv.setViewName("update");
        return mv;
    }

    //修改
    @RequestMapping("/updateUser")
    public String updateUser(User user){
        try {
            user.setPassword(Md5Util.encodeByMd5(user.getPassword()));
        } catch (Exception e) {
            e.printStackTrace();
        }
        userService.updateUser(user);
        return "redirect:findByPage";
    }

}
