package com.whoops.store.bean;

import java.math.BigDecimal;

/**
 * @author: whoops
 * @date: 2021/10/19
 */
public class Order {
    private Long orderNum;//订单号
    private Integer goodId;//商品id
    private String goodName;//商品名称
    private BigDecimal price;//商品价格
    private Goods goods;
    private Integer count;//商品数量
    private Integer userId;//用户id
    private Integer addrId;//收货地址id
    private String address;//收货地址
    private String orderStatus;//订单的状态
    private ViewsUser viewsUser;

    public Order() {
    }

    public Order(Long orderNum, Integer goodId, String goodName, BigDecimal price, Goods goods, Integer count, Integer userId, Integer addrId, String address, String orderStatus, ViewsUser viewsUser) {
        this.orderNum = orderNum;
        this.goodId = goodId;
        this.goodName = goodName;
        this.price = price;
        this.goods = goods;
        this.count = count;
        this.userId = userId;
        this.addrId = addrId;
        this.address = address;
        this.orderStatus = orderStatus;
        this.viewsUser = viewsUser;
    }

    public Long getOrderNum() {
        return orderNum;
    }

    public void setOrderNum(Long orderNum) {
        this.orderNum = orderNum;
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

    public Integer getAddrId() {
        return addrId;
    }

    public void setAddrId(Integer addrId) {
        this.addrId = addrId;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public ViewsUser getViewsUser() {
        return viewsUser;
    }

    public void setViewsUser(ViewsUser viewsUser) {
        this.viewsUser = viewsUser;
    }

    @Override
    public String toString() {
        return "Order{" +
                "orderNum=" + orderNum +
                ", goodId=" + goodId +
                ", goodName='" + goodName + '\'' +
                ", price=" + price +
                ", goods=" + goods +
                ", count=" + count +
                ", userId=" + userId +
                ", addrId=" + addrId +
                ", address='" + address + '\'' +
                ", orderStatus='" + orderStatus + '\'' +
                ", viewsUser=" + viewsUser +
                '}';
    }
}
