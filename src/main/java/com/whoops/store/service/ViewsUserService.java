package com.whoops.store.service;

import com.whoops.store.bean.Address;
import com.whoops.store.bean.Goods;
import com.whoops.store.bean.GoodsType;
import com.whoops.store.bean.ViewsUser;

import java.util.List;

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

    /**
     * 根据id查询用户信息
     * @param userId
     * @return
     */
    ViewsUser getUserById(Integer userId);

    /**
     * 修改用户信息
     * @param userId
     * @return
     */
    int updateUser(ViewsUser viewsUser,Integer userId);

    /**
     * 查询用户的地址
     * @param id
     * @return
     */
    List<Address> getAddr(Integer id);

    /**
     * 删除用户地址
     * @param id
     * @return
     */
    int delAddr(Integer id);

    /**
     * 修改用户地址
     * @param addrName
     * @param addrPhone
     * @param address
     * @param id
     * @return
     */
    int updateAddr(String addrName, String addrPhone, String address, Integer id);

    /**
     * 添加收获地址
     * @param address
     * @return
     */
    int addAddress(Address address);

    /**
     * 把收获地址设置为初始状态0
     * @param address
     * @return
     */
    int makeStatus(Address address);

    /**
     * 设置收获地址为默认
     * @param address
     * @param addrId
     * @return
     */
    int makeDefault(Address address, Integer addrId);

    /**
     * 查询所有的收获地址
     * @return
     */
    List<Address> findAddress(Integer userId);

    /**
     * 查询商品类别
     * @return
     */
    List<GoodsType> findgoodsType();

    /**
     * 根据商品的typeId查询商品信息
     * @param typeId
     * @return
     */
    List<Goods> showGoods(Integer typeId);

    /**
     * 查询商品的详细信息
     * @param goodId
     * @return
     */
    Goods goodsDetail(Integer goodId);

    /**
     * 查询所有评分大于等于7的商品
     * @return
     */
    List<Goods> findGoodsMore();

    /**
     * 根据商品id查询商品信息
     * @param goodId
     * @return
     */
    Goods findGoodsById(Integer goodId);

    /**
     * 更新商品数量
     * @param goodId
     * @return
     */
    int updateTotal(Integer goodId,Integer total);


}
