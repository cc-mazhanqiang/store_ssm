package com.whoops.store.service.impl;

import com.whoops.store.bean.Goods;
import com.whoops.store.bean.GoodsType;
import com.whoops.store.bean.ManagerUser;
import com.whoops.store.bean.ViewsUser;
import com.whoops.store.dao.ManagerUserMapper;
import com.whoops.store.service.ManagerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @author: whoops
 * @date: 2021/10/8
 */
@Service
public class ManagerServiceImpl implements ManagerService {
    @Autowired
    ManagerUserMapper managerUserMapper;

    @Override
    public ManagerUser findManagerByUserNameAndPassword(String username, String password) {
        return managerUserMapper.selectByUserNameAndPassword(username,password);
    }

    @Override
    public List<ViewsUser> findAllUser() {
        return managerUserMapper.findAllUser();
    }

    @Transactional
    @Override
    public int delUser(Integer id) {
        return managerUserMapper.delUser(id);
    }

    @Override
    public ViewsUser findAllUserByUserNameAndGender(String username) {
        return managerUserMapper.findAllUserByUserNameAndGender(username);
    }

    @Transactional
    @Override
    public int addGoodsType(GoodsType goodsType) {
        return managerUserMapper.addGoodsType(goodsType);
    }

    @Override
    public List<GoodsType> findGoodsTypeName() {
        return managerUserMapper.findGoodsTypeName();
    }

    @Transactional
    @Override
    public int addGoods(Goods goods) {
        return managerUserMapper.addGoods(goods);
    }

    @Override
    public List<Goods> findAllGoods() {
        return managerUserMapper.findAllGoods();
    }

    @Transactional
    @Override
    public int delGoods(Integer goodId) {
        return managerUserMapper.delGoods(goodId);
    }

    @Override
    public Goods findGoodsById(Integer goodId) {
        return managerUserMapper.findGoodsById(goodId);
    }

    @Transactional
    @Override
    public int delBatch(List<Integer> list_ids) {
        return managerUserMapper.delBatch(list_ids);
    }

    @Override
    public Goods findGoodsByGoodNameAndTypeName(String goodName, String typeName) {
        return managerUserMapper.findGoodsByGoodNameAndTypeName(goodName,typeName);
    }

    @Override
    public List<Goods> findGoodsByGoodCondition(String condition) {
        return managerUserMapper.findGoodsByGoodCondition(condition);
    }

    @Override
    public Goods getGoodsById(Integer goodId) {
        return managerUserMapper.getGoodsById(goodId);
    }

    @Transactional
    @Override
    public int updateGoods(Goods goods, Integer goodId) {
        return managerUserMapper.updateGoods(goods,goodId);
    }
}
