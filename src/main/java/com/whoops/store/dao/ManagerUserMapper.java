package com.whoops.store.dao;

import com.whoops.store.bean.Goods;
import com.whoops.store.bean.GoodsType;
import com.whoops.store.bean.ManagerUser;
import com.whoops.store.bean.ViewsUser;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ManagerUserMapper {

    ManagerUser selectByUserNameAndPassword(@Param("username") String username,@Param("password") String password);

    List<ViewsUser> findAllUser();

    int delUser(Integer id);

    ViewsUser findAllUserByUserNameAndGender(@Param("username") String username);

    int addGoodsType(GoodsType goodsType);

    List<GoodsType> findGoodsTypeName();

    int addGoods(Goods goods);

    List<Goods> findAllGoods();

    int delGoods(@Param("goodId")Integer goodId);

    Goods findGoodsById(@Param("goodId")Integer goodId);

    int delBatch(List<Integer> list_ids);

    Goods findGoodsByGoodNameAndTypeName(@Param("goodName") String goodName, @Param("typeName") String typeName);

    List<Goods> findGoodsByGoodCondition(@Param("condition") String condition);

    Goods getGoodsById(@Param("goodId") Integer goodId);

    int updateGoods(@Param("goods") Goods goods, @Param("goodId")Integer goodId);
}