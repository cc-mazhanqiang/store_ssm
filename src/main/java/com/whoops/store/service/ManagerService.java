package com.whoops.store.service;

import com.whoops.store.bean.Goods;
import com.whoops.store.bean.GoodsType;
import com.whoops.store.bean.ManagerUser;
import com.whoops.store.bean.ViewsUser;

import java.util.List;

/**
 * @author: whoops
 * @date: 2021/10/8
 */
public interface ManagerService {
    /**
     * 根据管理员的用户名和密码实现登录
     * @param username
     * @param password
     * @return
     */
    ManagerUser findManagerByUserNameAndPassword(String username, String password);

    /**
     * 查询所有的用户
     * @return
     */
    List<ViewsUser> findAllUser();

    /**
     * 删除用户
     * @param id
     * @return
     */
    int delUser(Integer id);

    /**
     * 根据用户名和性别查询用户
     * @param username
     * @return
     */
    ViewsUser findAllUserByUserNameAndGender(String username);

    /**
     * 添加商品种类
     * @param goodsType
     * @return
     */
    int addGoodsType(GoodsType goodsType);

    /**
     * 查询所有的商品种类
     * @return
     */
    List<GoodsType> findGoodsTypeName();

    /**
     * 添加商品
     * @param goods
     * @return
     */
    int addGoods(Goods goods);

    /**
     * 查询商品信息
     * @return
     */
    List<Goods> findAllGoods();

    /**
     * 删除商品
     * @param goodId
     * @return
     */
    int delGoods(Integer goodId);

    /**
     * 查询单个商品的信息
     * @param goodId
     * @return
     */
    Goods findGoodsById(Integer goodId);

    /**
     * 批量删除
     * @param list_ids
     * @return
     */
    int delBatch(List<Integer> list_ids);

    /**
     * 根据条件查询商品
     * @param goodName
     * @param typeName
     * @return
     */
    Goods findGoodsByGoodNameAndTypeName(String goodName, String typeName);

    /**
     * 根据添加时间或商品名称查询
     * @param condition
     * @return
     */
    List<Goods> findGoodsByGoodCondition(String condition);

    /**
     * 根据商品ID查询图片、价格、数量、评分、detail
     * @param goodId
     * @return
     */
    Goods getGoodsById(Integer goodId);

    /**
     * 更新商品的信息
     * @param goods
     * @param goodId
     * @return
     */
    int updateGoods(Goods goods, Integer goodId);
}
