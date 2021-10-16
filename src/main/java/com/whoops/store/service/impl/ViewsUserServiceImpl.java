package com.whoops.store.service.impl;

import com.whoops.store.bean.ViewsUser;
import com.whoops.store.dao.ViewsUserMapper;
import com.whoops.store.service.ViewsUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
}
