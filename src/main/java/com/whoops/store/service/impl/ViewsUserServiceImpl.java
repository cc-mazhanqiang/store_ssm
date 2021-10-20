package com.whoops.store.service.impl;

import com.whoops.store.bean.Address;
import com.whoops.store.bean.Goods;
import com.whoops.store.bean.GoodsType;
import com.whoops.store.bean.ViewsUser;
import com.whoops.store.dao.ViewsUserMapper;
import com.whoops.store.service.ViewsUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author: whoops
 * @date: 2021/10/10
 */
@Service
public class ViewsUserServiceImpl implements ViewsUserService {
    @Autowired
    ViewsUserMapper viewsUserMapper;

    /**
     * 登录
     * @param username
     * @param password
     * @return
     */
    @Override
    public ViewsUser login(String username, String password) {
        return viewsUserMapper.selectByUserNameAndPassword(username,password);
    }

    /**
     * 检查用户名是否已存在
     * @param username
     * @return
     */
    @Override
    public ViewsUser checkUserName(String username) {
        return viewsUserMapper.checkUserName(username);
    }

    /**
     * 检查手机号是否已存在
     * @param phoneNum
     * @return
     */
    @Override
    public ViewsUser checkPhoneNum(String phoneNum) {
        return viewsUserMapper.checkPhoneNum(phoneNum);
    }

    /**
     * 检查邮箱是否已存在
     * @param email
     * @return
     */
    @Override
    public ViewsUser checkEmail(String email) {
        return viewsUserMapper.checkEmail(email);
    }

    /**
     * 用户的注册
     * @param viewsUser
     * @return
     */
    @Override
    public int register(ViewsUser viewsUser) {
        return viewsUserMapper.register(viewsUser);
    }

    /**
     * 根据id查询用户信息
     * @param userId
     * @return
     */
    @Override
    public ViewsUser getUserById(Integer userId) {
        return viewsUserMapper.getUserById(userId);
    }

    @Override
    public int updateUser(ViewsUser viewsUser,Integer userId) {
        return viewsUserMapper.updateUser(viewsUser,userId);
    }

    @Override
    public List<Address> getAddr(Integer id) {
        return viewsUserMapper.getAddr(id);
    }

    @Override
    public int delAddr(Integer id) {
        return viewsUserMapper.delAddr(id);
    }

    @Override
    public int updateAddr(String addrName, String addrPhone, String address, Integer id) {
        return viewsUserMapper.updateAddr(addrName,addrPhone,address,id);
    }

    @Override
    public int addAddress(Address address) {
        return viewsUserMapper.addAddress(address);
    }

    @Override
    public int makeStatus(Address address) {
        return viewsUserMapper.makeStatus(address);
    }

    @Override
    public int makeDefault(Address address, Integer addrId) {
        return viewsUserMapper.makeDefault(address,addrId);
    }

    @Override
    public List<Address> findAddress(Integer userId) {
        return viewsUserMapper.findAddress(userId);
    }

    @Override
    public List<GoodsType> findgoodsType() {
        return viewsUserMapper.findgoodsType();
    }

    @Override
    public List<Goods> showGoods(Integer typeId) {
        return viewsUserMapper.showGoods(typeId);
    }

    @Override
    public Goods goodsDetail(Integer goodId) {
        return viewsUserMapper.goodsDetail(goodId);
    }

    @Override
    public List<Goods> findGoodsMore() {
        return viewsUserMapper.findGoodsMore();
    }

    @Override
    public Goods findGoodsById(Integer goodId) {
        return viewsUserMapper.findGoodsById(goodId);
    }

    @Override
    public int updateTotal(Integer goodId,Integer total) {
        return viewsUserMapper.updateTotal(goodId,total);
    }
}
