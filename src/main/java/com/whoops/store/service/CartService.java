package com.whoops.store.service;

import com.whoops.store.bean.Cart;

import java.math.BigDecimal;
import java.util.List;

/**
 * @author: whoops
 * @date: 2021/10/18
 */
public interface CartService {
    /**
     * 查找购物车信息
     * @param goodId
     * @return
     */
    Cart findCartByGoodId(Integer goodId);

    /**
     * 添加商品到购物车
     * @param goodId
     * @param goodName
     * @param price
     * @param count
     * @param userId
     * @return
     */
    int addCartGoods(Integer goodId, String goodName, BigDecimal price, Integer count, Integer userId);

    /**
     *
     * @param goodId
     * @param count
     * @return
     */
    int updateCount(Integer goodId, Integer count);

    /**
     * 查询用户的所有购物车信息
     * @param userId
     * @return
     */
    List<Cart> findCartByUserId(Integer userId);

    /**
     * 根据cartId查询购物车数据
     * @param cartId
     * @return
     */
    Cart findCartByCartId(Integer cartId);

    /**
     * 清空购物车
     * @param userId
     * @return
     */
    int removeAllCart(Integer userId);

    /**
     * 删除购物车商品
     * @param cartId
     * @return
     */
    int delCartById(Integer cartId);

}
