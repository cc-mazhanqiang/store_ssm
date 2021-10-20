package com.whoops.store.dao;

import com.whoops.store.bean.Cart;
import org.apache.ibatis.annotations.Param;

import java.math.BigDecimal;
import java.util.List;

/**
 * @author: whoops
 * @date: 2021/10/18
 */
public interface CartMapper {
    Cart findCartByGoodId(@Param("goodId")Integer goodId);

    int addCartGoods(@Param("goodId")Integer goodId, @Param("goodName")String goodName, @Param("price") BigDecimal price, @Param("count")Integer count, @Param("userId")Integer userId);

    int updateCount(@Param("goodId")Integer goodId, @Param("count")Integer count);

    List<Cart> findCartByUserId(@Param("userId") Integer userId);

    Cart findCartByCartId(@Param("cartId") Integer cartId);

    int removeAllCart(@Param("userId")Integer userId);

    int delCartById(@Param("cartId")Integer cartId);
}
