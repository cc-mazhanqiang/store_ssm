package com.whoops.store.service;

import com.whoops.store.bean.ViewsUser;

/**
 * @author: whoops
 * @date: 2021/10/10
 */
public interface ViewsUserService {
    ViewsUser login(String username, String password);

    ViewsUser checkUserName(String username);

    ViewsUser checkPhoneNum(String phoneNum);

    ViewsUser checkEmail(String email);

    int register(ViewsUser viewsUser);
}
