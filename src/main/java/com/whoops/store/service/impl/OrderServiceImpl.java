package com.whoops.store.service.impl;

import com.whoops.store.bean.Address;
import com.whoops.store.bean.Order;
import com.whoops.store.dao.OrderMapper;
import com.whoops.store.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author: whoops
 * @date: 2021/10/19
 */
@Service
public class OrderServiceImpl implements OrderService {
    @Autowired
    OrderMapper orderMapper;
    @Override
    public int addOrders(Order order) {
        return orderMapper.addOrders(order);
    }

    @Override
    public List<Order> findOrdersByUserId(Integer userId) {
        return orderMapper.findOrdersByUserId(userId);
    }

    @Override
    public Address findAddressByAddrId(Integer addrId) {
        return orderMapper.findAddressByAddrId(addrId);
    }

    @Override
    public int updateOrdersAddress(Long orderNum,String addresses, Integer addrId,String orderStatus) {
        return orderMapper.updateOrdersAddress(orderNum,addresses,addrId,orderStatus);
    }
}
