package com.whoops.store.bean;

import java.math.BigDecimal;

/**
 * @author: whoops
 * @date: 2021/10/18
 */
public class Cart {
    private Integer cartId;//购物车id
    private Integer goodId;//商品id
    private String goodName;//商品名称
    private BigDecimal price;//商品价格
    private Goods goods;
    private Integer count;//商品数量
    private Integer userId;//用户id
    private ViewsUser viewsUser;

    public Cart() {
    }

    public Cart(Integer goodId, String goodName, BigDecimal price, Integer count, Integer userId) {
        this.goodId = goodId;
        this.goodName = goodName;
        this.price = price;
        this.count = count;
        this.userId = userId;
    }

    public Cart(Integer cartId, Integer goodId, String goodName, BigDecimal price, Goods goods, Integer count, Integer userId, ViewsUser viewsUser) {
        this.cartId = cartId;
        this.goodId = goodId;
        this.goodName = goodName;
        this.price = price;
        this.goods = goods;
        this.count = count;
        this.userId = userId;
        this.viewsUser = viewsUser;
    }

    public Integer getCartId() {
        return cartId;
    }

    public void setCartId(Integer cartId) {
        this.cartId = cartId;
    }

    public Integer getGoodId() {
        return goodId;
    }

    public void setGoodId(Integer goodId) {
        this.goodId = goodId;
    }

    public String getGoodName() {
        return goodName;
    }

    public void setGoodName(String goodName) {
        this.goodName = goodName;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public Goods getGoods() {
        return goods;
    }

    public void setGoods(Goods goods) {
        this.goods = goods;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public ViewsUser getViewsUser() {
        return viewsUser;
    }

    public void setViewsUser(ViewsUser viewsUser) {
        this.viewsUser = viewsUser;
    }

    @Override
    public String toString() {
        return "Cart{" +
                "cartId=" + cartId +
                ", goodId=" + goodId +
                ", goodName='" + goodName + '\'' +
                ", price=" + price +
                ", goods=" + goods +
                ", count=" + count +
                ", userId=" + userId +
                ", viewsUser=" + viewsUser +
                '}';
    }
}
