package com.whoops.store.bean;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.math.BigDecimal;
import java.sql.Date;

/**
 * @author: whoops
 * @date: 2021/10/13
 */
public class Goods {
    private Integer goodId;
    private Integer typeId;//商品种类Id
    private String goodName;
    private String image;
    private BigDecimal price;
    private Integer star;//商品的评分
    private Integer total;
    @JsonFormat(pattern="yyyy-MM-dd")
    private Date addTime;
    private String detail;//商品的简介
    private GoodsType goodsType;//商品种类

    public Goods() {
    }

    public Goods(Integer goodId, Integer typeId, String goodName, String image, BigDecimal price, Integer star, Integer total, Date addTime, String detail, GoodsType goodsType) {
        this.goodId = goodId;
        this.typeId = typeId;
        this.goodName = goodName;
        this.image = image;
        this.price = price;
        this.star = star;
        this.total = total;
        this.addTime = addTime;
        this.detail = detail;
        this.goodsType = goodsType;
    }

    public Integer getGoodId() {
        return goodId;
    }

    public void setGoodId(Integer goodId) {
        this.goodId = goodId;
    }

    public Integer getTypeId() {
        return typeId;
    }

    public void setTypeId(Integer typeId) {
        this.typeId = typeId;
    }

    public String getGoodName() {
        return goodName;
    }

    public void setGoodName(String goodName) {
        this.goodName = goodName;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public Integer getStar() {
        return star;
    }

    public void setStar(Integer star) {
        this.star = star;
    }

    public Integer getTotal() {
        return total;
    }

    public void setTotal(Integer total) {
        this.total = total;
    }

    public Date getAddTime() {
        return addTime;
    }

    public void setAddTime(Date addTime) {
        this.addTime = addTime;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

    public GoodsType getGoodsType() {
        return goodsType;
    }

    public void setGoodsType(GoodsType goodsType) {
        this.goodsType = goodsType;
    }

    @Override
    public String toString() {
        return "Goods{" +
                "goodId=" + goodId +
                ", typeId=" + typeId +
                ", goodName='" + goodName + '\'' +
                ", image='" + image + '\'' +
                ", price=" + price +
                ", star=" + star +
                ", total=" + total +
                ", addTime=" + addTime +
                ", detail='" + detail + '\'' +
                ", goodsType=" + goodsType +
                '}';
    }
}
