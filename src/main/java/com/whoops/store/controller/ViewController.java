package com.whoops.store.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * @author: whoops
 * @date: 2021/10/10
 */
//负责页面的跳转
@Controller
public class ViewController {
    /**
     * 从注册页面回到登录页面
     * @return
     */
    @RequestMapping("/views/goLogin")
    public String goLogin(){
        return "login";
    }

    /**
     * 访问注册页面的请求
     * @return
     */
    @RequestMapping("/views/goRegister")
    public String register(){
        return "register";
    }

    /**
     * 加载首页的头部
     * @return
     */
    @RequestMapping("/views/head")
    public String getHead(){
        return "head";
    }

    /**
     * 加载首页的页脚
     * @return
     */
    @RequestMapping("/views/foot")
    public String getFoot(){
        return "foot";
    }

    /**
     * 登录成功之后跳转到首页
     * @return
     */
    @GetMapping("/views/index")
    public String goIndex(){
        return "index";
    }

    /**
     * 用户退出登录
     * @param request
     * @return
     */
    @GetMapping("/views/loginOut")
    public String loginOut(HttpServletRequest request){
        HttpSession session = request.getSession();
        session.removeAttribute("home_user");
        return "login";
    }

    /**
     * 购物车页面
     * @return
     */
    @GetMapping("/views/cart")
    public String goCart(){
        return "cart";
    }

    /**
     * 订单页面
     * @return
     */
    @GetMapping("/views/order")
    public String goOrder(){
        return "order";
    }
//
//    /**
//     * 个人中心页面
//     * @return
//     */
//    @GetMapping("/views/selfInfo")
//    public String goSelfInfo(){
//        return "self_info";
//    }
}
