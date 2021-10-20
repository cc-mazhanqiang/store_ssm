package com.whoops.store.dao;

import com.whoops.store.bean.Address;
import com.whoops.store.bean.Goods;
import com.whoops.store.bean.GoodsType;
import com.whoops.store.bean.ViewsUser;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author: whoops
 * @date: 2021/10/10
 */
public interface ViewsUserMapper {
    ViewsUser selectByUserNameAndPassword(@Param("username") String username, @Param("password")String password);

    ViewsUser checkUserName(@Param("username")String username);

    ViewsUser checkPhoneNum(@Param("phoneNum")String phoneNum);

    ViewsUser checkEmail(@Param("email")String email);

    int register(ViewsUser viewsUser);

    ViewsUser getUserById(@Param("userId") Integer userId);

    int updateUser(@Param("viewsUser")ViewsUser viewsUser,@Param("userId")Integer userId);

    List<Address> getAddr(@Param("userId")Integer id);

    int delAddr(@Param("addrId")Integer id);

    int updateAddr(@Param("addrName")String addrName, @Param("addrPhone")String addrPhone, @Param("address")String address, @Param("addrId")Integer id);

    int addAddress(Address address);

    int makeStatus(Address address);

    int makeDefault(@Param("address")Address address, @Param("addrId")Integer addrId);

    List<Address> findAddress(@Param("userId") Integer userId);

    List<GoodsType> findgoodsType();

    List<Goods> showGoods(@Param("typeId") Integer typeId);

    Goods goodsDetail(@Param("goodId") Integer goodId);

    List<Goods> findGoodsMore();

    Goods findGoodsById(@Param("goodId")Integer goodId);

    int updateTotal(@Param("goodId")Integer goodId,@Param("total") Integer total);
}
