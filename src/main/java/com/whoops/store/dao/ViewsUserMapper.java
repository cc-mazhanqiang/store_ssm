package com.whoops.store.dao;

import com.whoops.store.bean.ViewsUser;
import org.apache.ibatis.annotations.Param;

/**
 * @author: whoops
 * @date: 2021/10/10
 */
public interface ViewsUserMapper {
    ViewsUser selectByUserNameAndPassword(@Param("username") String username, @Param("password")String password);

    ViewsUser checkUserName(@Param("username")String username);

    ViewsUser checkPhoneNum(@Param("phoneNum")String phoneNum);

    ViewsUser checkEmail(String email);

    int register(ViewsUser viewsUser);
}
