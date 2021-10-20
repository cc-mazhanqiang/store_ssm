package com.whoops.store.dao;

import com.whoops.store.bean.Address;
import com.whoops.store.bean.Order;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author: whoops
 * @date: 2021/10/19
 */
public interface OrderMapper {
    int addOrders(Order order);

    List<Order> findOrdersByUserId(@Param("userId") Integer userId);

    Address findAddressByAddrId(@Param("addrId") Integer addrId);

    int updateOrdersAddress(@Param("orderNum") Long orderNum,@Param("addresses") String addresses, @Param("addrId") Integer addrId,@Param("orderStatus") String orderStatus);
}
