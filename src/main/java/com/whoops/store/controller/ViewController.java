package com.whoops.store.controller;

import com.whoops.store.bean.Goods;
import com.whoops.store.service.ViewsUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * @author: whoops
 * @date: 2021/10/10
 */
//负责页面的跳转
@Controller
public class ViewController {
    @Autowired
    ViewsUserService viewsUserService;
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
    @GetMapping("/loginOut")
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

    /**
     * 个人中心页面
     * @return
     */
    @GetMapping("/views/address")
    public String goSelfInfo(){
        return "address";
    }

    /**
     * 商品列表页面
     * @return
     */
    @GetMapping("/views/goodsList")
    public String goodsList(@RequestParam("typeId")Integer typeId, Model model){
        try {
            List<Goods> goodsList = viewsUserService.showGoods(typeId);
            if (goodsList == null || goodsList.size() == 0)throw new Exception("没有查询到相关的商品信息！");
            System.out.println(goodsList);
            model.addAttribute("list",goodsList);
            model.addAttribute("success",true);
            model.addAttribute("msg","查询商品列表成功！");
            System.out.println(model);
        } catch (Exception e) {
            model.addAttribute("success",false);
            model.addAttribute("msg","查询商品列表失败！");
            model.addAttribute("exc",e.toString());
        }
        return "goodsList";
    }

    @GetMapping("/views/goodsDetail")
    public String goodsDetail(@RequestParam("goodId")Integer goodId, Model model){
        try {
            Goods goods = viewsUserService.goodsDetail(goodId);
            if (goods == null)throw new Exception("没有查询到相关的商品信息！");
            System.out.println(goods);
            model.addAttribute("goods",goods);
            model.addAttribute("success",true);
            model.addAttribute("msg","查询商品列表成功！");
            System.out.println(model);
        } catch (Exception e) {
            model.addAttribute("success",false);
            model.addAttribute("msg","查询商品列表失败！");
            model.addAttribute("exc",e.toString());
        }
        return "goodsDetail";
    }
}
