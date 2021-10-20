package com.whoops.store.bean;

/**
 * @author: whoops
 * @date: 2021/10/16
 */
public class Address {
    private Integer id;
    private String address;//收货地址
    private Integer status;//1表示默认地址
    private String addrName;//收件人
    private String addrPhone;//收件人手机号
    private Integer userId;
    private ViewsUser viewsUser;

    public Address() {
    }

    public Address(Integer id, String address, Integer status, String addrName, String addrPhone, Integer userId, ViewsUser viewsUser) {
        this.id = id;
        this.address = address;
        this.status = status;
        this.addrName = addrName;
        this.addrPhone = addrPhone;
        this.userId = userId;
        this.viewsUser = viewsUser;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getAddrName() {
        return addrName;
    }

    public void setAddrName(String addrName) {
        this.addrName = addrName;
    }

    public String getAddrPhone() {
        return addrPhone;
    }

    public void setAddrPhone(String addrPhone) {
        this.addrPhone = addrPhone;
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
        return "Address{" +
                "id=" + id +
                ", address='" + address + '\'' +
                ", status=" + status +
                ", addrName='" + addrName + '\'' +
                ", addrPhone='" + addrPhone + '\'' +
                ", userId=" + userId +
                ", viewsUser=" + viewsUser +
                '}';
    }
}
