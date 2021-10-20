package com.whoops.store.controller;

import com.whoops.store.bean.Address;
import com.whoops.store.bean.Goods;
import com.whoops.store.bean.GoodsType;
import com.whoops.store.bean.ViewsUser;
import com.whoops.store.service.ViewsUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY;

/**
 * @author: whoops
 * @date: 2021/10/8
 */
@RestController
public class HomeController {
    @Autowired
    ViewsUserService viewsUserService;

    @PostMapping("/views/login")
    public Map<String,Object> login(HttpServletRequest request,
                                    @RequestParam("username")String username,
                                    @RequestParam("password")String password,
                                    @RequestParam("code")String code){
        Map<String,Object> map = new HashMap<>();
        try {
            //获取session域中的验证码
            String token = (String) request.getSession().getAttribute(KAPTCHA_SESSION_KEY);
            //删除验证码，保证只使用一次
            request.getSession().removeAttribute(KAPTCHA_SESSION_KEY);
            //检查验证码是否正确
            if (token != null && code.equalsIgnoreCase(token)){
                ViewsUser viewsUser = viewsUserService.login(username,password);
                if (viewsUser == null)throw new Exception("账号不存在");
                HttpSession session = request.getSession();
                session.setAttribute("home_user",viewsUser.getUsername());
                session.setAttribute("userId",viewsUser.getId());
                map.put("success",true);
            }else {
                map.put("success",false);
                map.put("msg","登录失败！验证码错误！");
            }
        } catch (Exception e) {
            map.put("success",false);
            map.put("exc",e.toString());
        }
        return map;
    }

    /**
     * 校验用户名是否可用
     * @param username
     * @return
     */
    @GetMapping("/views/checkUserName")
    public Map<String,Object> checkUserName(@RequestParam("username")String username){
        Map<String,Object> map = new HashMap<>();
        try {
            ViewsUser viewsUser = viewsUserService.checkUserName(username);
            if (viewsUser == null){
                map.put("success",true);
                map.put("msg","用户名可用");
            }else {
                throw new Exception("账号已经存在");
            }
        } catch (Exception e) {
            map.put("success",false);
            map.put("exc",e.toString());
        }
        return map;
    }
    /**
     * 校验手机号是否可用
     * @param phoneNum
     * @return
     */
    @GetMapping("/views/checkPhoneNum")
    public Map<String,Object> checkPhoneNum(@RequestParam("phoneNum")String phoneNum){
        Map<String,Object> map = new HashMap<>();
        try {
            ViewsUser viewsUser = viewsUserService.checkPhoneNum(phoneNum);
            if (viewsUser == null){
                map.put("success",true);
                map.put("msg","手机号可用");
            }else {
                throw new Exception("该手机号已经存在");
            }
        } catch (Exception e) {
            map.put("success",false);
            map.put("exc",e.toString());
        }
        return map;
    }
    /**
     * 校验邮箱是否可用
     * @param email
     * @return
     */
    @GetMapping("/views/checkEmail")
    public Map<String,Object> checkEmail(@RequestParam("email")String email){
        Map<String,Object> map = new HashMap<>();
        try {
            ViewsUser viewsUser = viewsUserService.checkEmail(email);
            if (viewsUser == null){
                map.put("success",true);
                map.put("msg","该邮箱可以使用");
            }else {
                throw new Exception("该邮箱已经被使用了");
            }
        } catch (Exception e) {
            map.put("success",false);
            map.put("exc",e.toString());
        }
        return map;
    }

    @PostMapping("/views/register")
    public Map<String,Object> register(HttpServletRequest request,ViewsUser viewsUser){
        Map<String,Object> map = new HashMap<>();
        try {
            if (viewsUser.getUsername()==null || viewsUser.getPassword()==null ||
            viewsUser.getPhoneNum()==null || viewsUser.getEmail()==null ||
            viewsUser.getGender() == null){
                throw new Exception("注册失败,某一项为空！");
            }else{
                int register = viewsUserService.register(viewsUser);
                if (register == 0){
                    map.put("success",false);
                    map.put("msg","注册失败");
                }
                ViewsUser registerName = viewsUserService.checkUserName(viewsUser.getUsername());
                request.getSession().setAttribute("registerName",registerName.getUsername());
                map.put("success",true);
                map.put("msg","注册成功");
            }
        } catch (Exception e) {
            map.put("success",false);
            map.put("exc",e.toString());
        }
        return map;
    }

    @GetMapping("/view/getUser")
    public Map<String,Object> getUserById(HttpSession session){
        Map<String,Object> map = new HashMap<>();
        try {
            Integer userId = (Integer) session.getAttribute("userId");
            System.out.println(userId);
            ViewsUser viewUsers = viewsUserService.getUserById(userId);
            if (viewUsers == null)throw new Exception("没有查到相关用户信息！");
            map.put("user",viewUsers);
            map.put("success",true);
            map.put("msg","查询用户成功！");
        } catch (Exception e) {
            map.put("success",false);
            map.put("msg","没有查到相关用户信息 ！");
            map.put("exc",e.toString());
        }
        return map;
    }

    /**
     * 根据用户id修改信息
     * @param viewsUser
     * @param userId
     * @return
     */
    @PutMapping("/views/updateUser/{userId}")
    public Map<String,Object> updateUser(ViewsUser viewsUser,@PathVariable("userId")Integer userId){
        Map<String,Object> map = new HashMap<>();
        try {
            int count = viewsUserService.updateUser(viewsUser,userId);
            if (count == 0)throw new Exception("修改用户信息失败！");
            map.put("success",true);
            map.put("msg","修改用户信息成功！");
        } catch (Exception e) {
            map.put("success",false);
            map.put("msg","修改用户信息失败！");
            map.put("exc",e.toString());
        }
        return map;
    }

    /**
     * 获取用户地址
     * @param id
     * @return
     */
    @GetMapping("/views/getAddr")
    public Map<String,Object> getAddr(@RequestParam("id")Integer id){
        Map<String,Object> map = new HashMap<>();
        try {
            List<Address> addressList = viewsUserService.getAddr(id);
            if (addressList == null || addressList.size() == 0)throw new Exception("没有查询到相关信息！");
            map.put("addr",addressList);
            map.put("success",true);
            map.put("msg","查询信息成功！");
        } catch (Exception e) {
            map.put("success",false);
            map.put("msg","没有查询到相关信息！");
            map.put("exc",e.toString());
        }
        return map;
    }

    /**
     * 删除用户地址
     * @param id
     * @return
     */
    @PostMapping("/views/delAddr")
    public Map<String,Object> delAddr(@RequestParam("id")Integer id){
        Map<String,Object> map = new HashMap<>();
        try {
            int count = viewsUserService.delAddr(id);
            if (count == 0)throw new Exception("删除用户地址失败！");
            map.put("success",true);
            map.put("msg","删除用户地址成功！");
        } catch (Exception e) {
            map.put("success",false);
            map.put("msg","删除用户地址失败！");
            map.put("exc",e.toString());
        }
        return map;
    }

    /**
     * 修改用户地址
     * @param
     * @return
     */
    @PostMapping("/views/updateAddr")
    public Map<String,Object> updateAddr(@RequestParam("address")String address,
                                         @RequestParam("addrPhone")String addrPhone,
                                         @RequestParam("addrName")String addrName,
                                         @RequestParam("id")Integer id){
        Map<String,Object> map = new HashMap<>();
        try {
            int count = viewsUserService.updateAddr(addrName,addrPhone,address,id);
            if (count == 0)throw new Exception("修改用户地址失败！");
            map.put("success",true);
            map.put("msg","修改用户地址成功！");
        } catch (Exception e) {
            map.put("success",false);
            map.put("msg","修改用户地址失败！");
            map.put("exc",e.toString());
        }
        return map;
    }

    /**
     * 添加收获地址
     * @param address
     * @return
     */
    @PostMapping("/views/addAddress")
    public Map<String,Object> addAddress(HttpSession session,Address address){
        Map<String,Object> map = new HashMap<>();
        try {
            //处理地址状态
            address.setStatus(0);//添加地址默认为0
            //处理用户ID
            Integer userId = (Integer) session.getAttribute("userId");
            address.setUserId(userId);
            int count = viewsUserService.addAddress(address);
            if (count == 0)throw new Exception("添加收货地址失败！");
            map.put("success",true);
            map.put("msg","添加收货地址成功！");
        } catch (Exception e) {
            map.put("success",false);
            map.put("msg","添加收货地址失败！");
            map.put("exc",e.toString());
        }
        return map;
    }

    /**
     * 把收获地址设置为默认
     * @param addrId
     * @return
     */
    @PostMapping("/views/makeDefault")
    public Map<String,Object> makeDefault(HttpSession session,@RequestParam("addrId")Integer addrId){
        Map<String,Object> map = new HashMap<>();
        try {
            Integer userId = (Integer) session.getAttribute("userId");
            Address address = new Address();
            address.setStatus(0);
            address.setUserId(userId);
            //先把状态全部设置为初始状态0
            int flag = viewsUserService.makeStatus(address);
            if (flag != 0){
                address.setStatus(1);
                int count = viewsUserService.makeDefault(address,addrId);
                if (count == 0)throw new Exception("默认地址设置失败！");
                map.put("success",true);
                map.put("msg","默认地址设置成功！");
            }else {
                throw new Exception("初始状态设置失败！");
            }
        } catch (Exception e) {
            map.put("success",false);
            map.put("msg","默认地址设置失败！");
            map.put("exc",e.toString());
        }
        return map;
    }

    /**
     * 查询用户id所有的地址
     * @return
     */
    @GetMapping("/views/getAddressName")
    public Map<String,Object> getAddressName(HttpSession session){
        Map<String,Object> map = new HashMap<>();
        try {
            Integer userId = (Integer) session.getAttribute("userId");
            List<Address> addressList = viewsUserService.findAddress(userId);
            if (addressList == null || addressList.size() == 0)throw new Exception("没有相关的收获地址！");
            map.put("addressList",addressList);
            map.put("success",true);
            map.put("msg","查询用户收获地址成功！");
        } catch (Exception e) {
            map.put("success",false);
            map.put("msg","查询用户收获地址失败！");
            map.put("exc",e.toString());
        }
        return map;
    }

    /**
     * 查询商品类别
     * @return
     */
    @GetMapping("views/findgoodsType")
    public Map<String,Object> findgoodsType(){
        Map<String,Object> map = new HashMap<>();
        try {
            List<GoodsType> goodsTypeList = viewsUserService.findgoodsType();
            if (goodsTypeList == null || goodsTypeList.size() == 0)throw new Exception("没有查询到相关商品信息!");
            map.put("list",goodsTypeList);
            map.put("success",true);
            map.put("msg","查询商品类别成功！");
        } catch (Exception e) {
            map.put("success",false);
            map.put("exc",e.toString());
            map.put("msg","查询商品类别失败！");
        }
        return map;
    }

    /**
     * 查询商品评分大于等于7的商品
     * @return
     */
    @GetMapping("/views/goodsMore")
    public Map<String,Object> getGoodsMore(){
        Map<String,Object> map = new HashMap<>();
        List<Goods> list = new ArrayList<>();
        try {
            List<Goods> goodsList = viewsUserService.findGoodsMore();
            if (goodsList == null || goodsList.size() == 0)throw new Exception("没有查询到相关的商品！");
            for (Goods goods : goodsList) {
                if (goods.getStar() >= 7){
                    list.add(goods);
                }
            }
            map.put("starList",list);
            map.put("success",true);
            map.put("msg","查询商品成功！");
        } catch (Exception e) {
            map.put("success",false);
            map.put("msg","查询商品失败！");
            map.put("exc",e.toString());
        }
        return map;
    }


}
