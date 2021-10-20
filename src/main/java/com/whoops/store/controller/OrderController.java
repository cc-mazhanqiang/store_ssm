package com.whoops.store.controller;

import com.whoops.store.bean.Address;
import com.whoops.store.bean.Order;
import com.whoops.store.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author: whoops
 * @date: 2021/10/19
 */
@RestController
public class OrderController {
    @Autowired
    OrderService orderService;

    /**
     * 查询订单
     * @param session
     * @return
     */
    @GetMapping("/views/findOrder")
    public Map<String,Object> findOrder(HttpSession session){
        Map<String,Object> map = new HashMap<>();
        try {
            Integer userId = (Integer) session.getAttribute("userId");
            List<Order> orderList = orderService.findOrdersByUserId(userId);
            if (orderList == null || orderList.size() == 0)throw new Exception("没有您的相关订单信息！");
            map.put("order",orderList);
            map.put("success",true);
            map.put("msg","查询订单成功！");
        } catch (Exception e) {
            map.put("success",false);
            map.put("msg","没有查询到您的相关订单！");
            map.put("exc",e.toString());
        }
        return map;
    }

    /**
     * 提交订单
     * @return
     */
    @PostMapping("/views/submitOrder")
    public Map<String,Object> submitOrder(HttpSession session,@RequestParam("addrId")Integer addrId){
        Map<String,Object> map = new HashMap<>();
        try {
            Address address = orderService.findAddressByAddrId(addrId);
            if (address == null)throw new Exception("您的收货地址不存在！");
            String addresses = address.getAddress();
            Integer userId = (Integer) session.getAttribute("userId");
            List<Order> ordersByUserId = orderService.findOrdersByUserId(userId);
            if (ordersByUserId == null || ordersByUserId.size() == 0)throw new Exception("没有查询相关的订单信息！");
            for (Order order : ordersByUserId) {
                Long orderNum = order.getOrderNum();
                if (!"待商家发货".equals(order.getOrderStatus())){
                    if (!"已发货".equals(order.getOrderStatus())){
                        order.setOrderStatus("待商家发货");
                        int count = orderService.updateOrdersAddress(orderNum,addresses,addrId,order.getOrderStatus());
                        if (count == 0)throw new Exception("提交订单收货地址失败！");
                    }
                }
            }
            map.put("success",true);
            map.put("msg","下单成功！欢迎您再次购买！");
        } catch (Exception e) {
            map.put("success",false);
            map.put("msg","下单失败！请稍后重试！");
            map.put("exc",e.toString());
        }
        return map;
    }

}
