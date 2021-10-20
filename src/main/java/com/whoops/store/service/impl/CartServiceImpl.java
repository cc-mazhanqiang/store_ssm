package com.whoops.store.service.impl;

import com.whoops.store.bean.Cart;
import com.whoops.store.dao.CartMapper;
import com.whoops.store.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;

/**
 * @author: whoops
 * @date: 2021/10/18
 */
@Service
public class CartServiceImpl implements CartService {
    @Autowired
    CartMapper cartMapper;

    @Override
    public Cart findCartByGoodId(Integer goodId) {
        return cartMapper.findCartByGoodId(goodId);
    }

    @Override
    public int addCartGoods(Integer goodId, String goodName, BigDecimal price, Integer count, Integer userId) {
        return cartMapper.addCartGoods(goodId,goodName,price,count,userId);
    }

    @Override
    public int updateCount(Integer goodId, Integer count) {
        return cartMapper.updateCount(goodId,count);
    }

    @Override
    public List<Cart> findCartByUserId(Integer userId) {
        return cartMapper.findCartByUserId(userId);
    }

    @Override
    public Cart findCartByCartId(Integer cartId) {
        return cartMapper.findCartByCartId(cartId);
    }

    @Override
    public int removeAllCart(Integer userId) {
        return cartMapper.removeAllCart(userId);
    }

    @Override
    public int delCartById(Integer cartId) {
        return cartMapper.delCartById(cartId);
    }
}
