package com.whoops.store.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * @author: whoops
 * @date: 2021/10/12
 */
@Controller
public class ViewManagerController {
    /**
     * 登录成功跳转到后台首页
     * @return
     */
    @RequestMapping("/manager/adminIndex")
    public String get(){
        return "manager/adminIndex";
    }

    /**
     * 管理员退出登录
     * @param request
     * @return
     */
    @RequestMapping("/manager/adminLoginOut")
    public String adminLoginOut(HttpServletRequest request){
        HttpSession session = request.getSession();
        session.removeAttribute("admin_user");
        return "manager/adminLogin";
    }

    /**
     * 跳转用户管理页面
     * @return
     */
    @RequestMapping("/manager/userList")
    public String getUserList(){
        return "manager/userList";
    }

    /**
     * 跳转到添加商品种类页面
     * @return
     */
    @RequestMapping("/manager/addGoodsType")
    public String addGoodsType(){
        return "manager/addGoodsType";
    }

    /**
     * 跳转查看商品种类页面
     * @return
     */
    @RequestMapping("/manager/showGoodsType")
    public String getGoodsType(){
        return "manager/showGoodsType";
    }

    /**
     * 跳转到添加商品页面
     * @return
     */
    @RequestMapping("/manager/addGoods")
    public String addGoods(){
        return "manager/addGoods";
    }

    /**
     * 跳转查看商品页面
     * @return
     */
    @RequestMapping("/manager/showGoods")
    public String getGoods(){
        return "manager/showGoods";
    }

    /**
     * 跳转查看订单页面
     * @return
     */
    @RequestMapping("/manager/showAllOrder")
    public String getAllOrder(){
        return "manager/showAllOrder";
    }



}
