package com.whoops.store.service;

import com.whoops.store.bean.Address;
import com.whoops.store.bean.Order;

import java.util.List;

/**
 * @author: whoops
 * @date: 2021/10/19
 */
public interface OrderService {
    /**
     * 添加订单
     * @param order
     * @return
     */
    int addOrders(Order order);

    /**
     * 查询订单
     * @param userId
     * @return
     */
    List<Order> findOrdersByUserId(Integer userId);

    /**
     * 查询收货地址
     * @param addrId
     * @return
     */
    Address findAddressByAddrId(Integer addrId);

    /**
     *  添加收货地址
     * @param addresses
     * @param addrId
     * @return
     */
    int updateOrdersAddress(Long orderNum,String addresses, Integer addrId,String orderStatus);
}
