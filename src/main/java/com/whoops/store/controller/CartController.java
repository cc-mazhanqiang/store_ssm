package com.whoops.store.controller;

import com.whoops.store.bean.Cart;
import com.whoops.store.bean.Goods;
import com.whoops.store.bean.Order;
import com.whoops.store.service.CartService;
import com.whoops.store.service.OrderService;
import com.whoops.store.service.ViewsUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author: whoops
 * @date: 2021/10/18
 */
@RestController
public class CartController {
    @Autowired
    CartService cartService;
    @Autowired
    ViewsUserService viewsUserService;
    @Autowired
    OrderService orderService;

    /**
     * 添加购物车
     * @param goodId
     * @return
     */
    @GetMapping("/views/addCart")
    public Map<String,Object> addCart(HttpSession session, @RequestParam("goodId") Integer goodId){
        Map<String,Object> map = new HashMap<>();
        try {
            //先根据商品id查询商品
            Goods goods = viewsUserService.findGoodsById(goodId);
            if (goods == null)throw new Exception("没有查询到相关的商品信息！");
            if (goodId.equals(goods.getGoodId())){
                Cart cart = cartService.findCartByGoodId(goodId);
                if (cart == null){
                    //添加商品
                    Integer userId = (Integer) session.getAttribute("userId");
                    String goodName = goods.getGoodName();
                    BigDecimal price = goods.getPrice();
                    int count = cartService.addCartGoods(goodId,goodName,price,1,userId);
                    if (count == 0)throw new Exception("添加购物车失败！");
                    goods.setTotal(goods.getTotal() - 1);
                    int flag = viewsUserService.updateTotal(goodId,goods.getTotal());
                    if (flag == 0)throw new Exception("更新商品数量失败！");
                }else {
                    cart.setCount(cart.getCount() + 1);
                    int cartCount = cartService.updateCount(goodId,cart.getCount());
                    if (cartCount == 0)throw new Exception("更新购物车商品数量失败！");
                    goods.setTotal(goods.getTotal() - 1);
                    int flag = viewsUserService.updateTotal(goodId,goods.getTotal());
                    if (flag == 0)throw new Exception("更新商品数量失败！");
                }
            }else {
                //添加商品
                Integer userId = (Integer) session.getAttribute("userId");
                String goodName = goods.getGoodName();
                BigDecimal price = goods.getPrice();
                int count = cartService.addCartGoods(goodId,goodName,price,1,userId);
                if (count == 0)throw new Exception("添加购物车失败！");
            }
            map.put("success",true);
            map.put("msg","添加商品到购物车成功！");
        } catch (Exception e) {
            map.put("success",false);
            map.put("msg","添加商品到购物车失败！");
            map.put("exc1","没有查询到相关的商品信息！");
            map.put("exc2","更新商品数量失败！");
            map.put("exc",e.toString());
        }
        return map;
    }

    /**
     * 查询用户所有的购物信息
     * @param session
     * @return
     */
    @GetMapping("/views/getCart")
    public Map<String,Object> getCart(HttpSession session){
        Map<String,Object> map = new HashMap<>();
        try {
            Integer userId = (Integer) session.getAttribute("userId");
            System.out.println(userId);
            List<Cart> cartList = cartService.findCartByUserId(userId);
            if (cartList == null || cartList.size() == 0)throw new Exception("没有查询到与您相关的购物信息！");
            map.put("cartList",cartList);
            map.put("success",true);
            map.put("msg","查询您的购物信息成功！");
        } catch (Exception e) {
            map.put("success",false);
            map.put("msg","没有查询到与您相关的购物信息！");
            map.put("exc",e.toString());
        }
        return map;
    }

    /**
     * 更新购物车数量(减少)
     * @param cartId
     * @return
     */
    @PostMapping("/views/reduceCartData")
    public Map<String,Object> reduceCartData(@RequestParam("cartId")Integer cartId){
        Map<String, Object> map = new HashMap<>();
        try {
            Cart cart = cartService.findCartByCartId(cartId);
            System.out.println(cartId);
            if (cart == null)throw new Exception("没有查询到购物车相关信息！");
            cart.setCount(cart.getCount() - 1);
            Integer goodId = cart.getGoodId();
            Goods goods = viewsUserService.findGoodsById(goodId);
            if (goods == null)throw new Exception("没有查询到商品相关信息！");
            goods.setTotal(goods.getTotal() + 1);
            int updateCount = cartService.updateCount(goodId, cart.getCount());
            if (updateCount == 0)throw new Exception("修改购物车商品数量失败！");
            int updateTotal = viewsUserService.updateTotal(goodId, goods.getTotal());
            if (updateTotal == 0)throw new Exception("修改商品总数量失败！");
            map.put("success",true);
            map.put("msg","更新成功！");
        } catch (Exception e) {
            map.put("success",false);
            map.put("msg","更新失败！");
            map.put("exc",e.toString());
        }
        return map;
    }

    /**
     * 更新购物车数量(增加)
     * @param cartId
     * @return
     */
    @PostMapping("/views/addCartData")
    public Map<String,Object> addCartData(@RequestParam("cartId")Integer cartId){
        Map<String, Object> map = new HashMap<>();
        try {
            Cart cart = cartService.findCartByCartId(cartId);
            System.out.println(cart);
            System.out.println(cartId);
            if (cart == null)throw new Exception("没有查询到购物车相关信息！");
            cart.setCount(cart.getCount() + 1);
            Integer goodId = cart.getGoodId();
            Goods goods = viewsUserService.findGoodsById(goodId);
            if (goods == null)throw new Exception("没有查询到商品相关信息！");
            goods.setTotal(goods.getTotal() - 1);
            int updateCount = cartService.updateCount(goodId, cart.getCount());
            if (updateCount == 0)throw new Exception("修改购物车商品数量失败！");
            int updateTotal = viewsUserService.updateTotal(goodId, goods.getTotal());
            if (updateTotal == 0)throw new Exception("修改商品总数量失败！");
            map.put("success",true);
            map.put("msg","更新成功！");
        } catch (Exception e) {
            map.put("success",false);
            map.put("msg","更新失败！");
            map.put("exc",e.toString());
        }
        return map;
    }

    /**
     * 清空购物车
     * @return
     */
    @PostMapping("/views/removeAllCart")
    public Map<String,Object> removeAllCart(HttpSession session){
        Map<String,Object> map = new HashMap<>();
        try {
            Integer userId = (Integer) session.getAttribute("userId");
            List<Cart> cartByUserId = cartService.findCartByUserId(userId);
            if (cartByUserId == null || cartByUserId.size() == 0)throw new Exception("没有相关数据！");
            //清空购物车的同时把数量还回去
            for (Cart cart : cartByUserId) {
                Integer goodId = cart.getGoodId();
                Integer count = cart.getCount();
                System.out.println(count);
                Goods goods = viewsUserService.findGoodsById(goodId);
                goods.setTotal(goods.getTotal() + count);
                System.out.println(goods.getTotal());
                int updateCount = viewsUserService.updateTotal(goodId, goods.getTotal());
                if (updateCount == 0)throw new Exception("数量返回失败！");
            }
            int count = cartService.removeAllCart(userId);
            if (count == 0)throw new Exception("清空购物车失败！请稍后重试！");
            map.put("success",true);
            map.put("msg","清空购物车成功！欢迎您再次选购！");
        } catch (Exception e) {
            map.put("success",false);
            map.put("msg","清空购物车失败！请稍后重试！");
            map.put("exc",e.toString());
        }
        return map;
    }

    /**
     * 删除购物车中的某个商品
     * @param session
     * @return
     */
    @PostMapping("/views/delCartById")
    public Map<String,Object> delCartById(HttpSession session,@RequestParam("cartId")Integer cartId){
        Map<String,Object> map = new HashMap<>();
        try {
            Integer userId = (Integer) session.getAttribute("userId");
            Cart cart = cartService.findCartByCartId(cartId);
            if (cart == null)throw new Exception("没有相关数据！");
            //删除购物车的商品的同时把数量还回去
            Integer goodId = cart.getGoodId();
            Integer count = cart.getCount();
            System.out.println(count);
            Goods goods = viewsUserService.findGoodsById(goodId);
            if (goods == null)throw new Exception("没有相关商品！");
            goods.setTotal(goods.getTotal() + count);
            System.out.println(goods.getTotal());
            int updateCount = viewsUserService.updateTotal(goodId, goods.getTotal());
            if (updateCount == 0)throw new Exception("数量返回失败！");
            int counts = cartService.delCartById(cartId);
            if (counts == 0)throw new Exception("删除商品失败！请稍后重试！");
            map.put("success",true);
            map.put("msg","删除商品成功！欢迎您再次选购！");
        } catch (Exception e) {
            map.put("success",false);
            map.put("msg","删除商品失败！请稍后重试！");
            map.put("exc",e.toString());
        }
        return map;
    }

    /**
     * 结算购物车
     * @return
     */
    @GetMapping("/views/accounts")
    public Map<String,Object> accounts(HttpSession session){
        Map<String,Object> map = new HashMap<>();
        try {
            Integer userId = (Integer) session.getAttribute("userId");
            List<Cart> cartList = cartService.findCartByUserId(userId);
            if (cartList == null || cartList.size() == 0)throw new Exception("购物车中还没有添加商品！");
            for (Cart cart : cartList) {
                Order order = new Order();
                Date date = new Date();
                long time = date.getTime();
                order.setOrderNum(time);
                Integer goodId = cart.getGoodId();
                order.setGoodId(goodId);
                String goodName = cart.getGoodName();
                order.setGoodName(goodName);
                BigDecimal price = cart.getPrice();
                order.setPrice(price);
                Integer count = cart.getCount();
                order.setCount(count);
                order.setUserId(userId);
                order.setOrderStatus("待提交订单");
                int cons = orderService.addOrders(order);
                if (cons == 0)throw new Exception("添加订单失败！");
            }
            int count = cartService.removeAllCart(userId);
            if (count == 0)throw new Exception("结算购物车失败！");
            map.put("success",true);
            map.put("msg","结算购物车成功！");
        } catch (Exception e) {
            map.put("success",false);
            map.put("msg","结算购物车失败！请稍后重试！");
            map.put("exc",e.toString());
        }
        return map;
    }

}
