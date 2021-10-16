package com.whoops.store.controller;

import com.whoops.store.bean.ViewsUser;
import com.whoops.store.service.ViewsUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
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

}
