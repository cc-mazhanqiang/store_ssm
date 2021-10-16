package com.whoops.store.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.whoops.store.bean.Goods;
import com.whoops.store.bean.GoodsType;
import com.whoops.store.bean.ManagerUser;
import com.whoops.store.bean.ViewsUser;
import com.whoops.store.service.ManagerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.*;

/**
 * @author: whoops
 * @date: 2021/10/8
 */
@Controller
public class ManagerController {

    @Autowired
    ManagerService managerService;

    /**
     *  管理员登录的方法
     * @param username
     * @param password
     * @return
     */
    @ResponseBody
    @PostMapping("/manager/login")
    public Map<String,Object> managerLogin(HttpServletRequest request,@RequestParam("username")String username,
                                           @RequestParam("password")String password){
        Map<String,Object> map = new HashMap<>();
        try {
            ManagerUser managerUser =  managerService.findManagerByUserNameAndPassword(username,password);
            if (managerUser == null)throw new Exception("账号不存在");
            HttpSession session = request.getSession();
            session.setAttribute("admin_user",managerUser.getUsername());
            map.put("success",true);
            map.put("msg","登录成功！");
        } catch (Exception e) {
            map.put("success",false);
            map.put("msg",e.toString());
        }
        return map;
    }

    @ResponseBody
    @GetMapping("/manager/getUserList")
    public Map<String,Object> getUserList(@RequestParam(value = "pageNum",defaultValue = "1")Integer pageNum){
        Map<String,Object> map = new HashMap<>();
        try {
            //分页查询，一页显示5条数据
            PageHelper.startPage(pageNum,5);
            List<ViewsUser> viewsUsersList = managerService.findAllUser();
            //navigatePage:分页导航条的显示
            PageInfo pageInfo = new PageInfo(viewsUsersList,5);
            System.out.println(pageInfo);
            map.put("page",pageInfo);
            map.put("success",true);
        }catch (Exception e){
            map.put("success",false);
            map.put("exc",e.toString());
        }
        return map;
    }

    /**
     * 删除用户，采用的是rest风格的请求方式
     * @param id
     * @return
     */
    @ResponseBody
    @DeleteMapping("/manager/delUser/{id}")
    public Map<String,Object> delUser(@PathVariable("id") Integer id){
        Map<String,Object> map = new HashMap<>();
        try {
            int count = managerService.delUser(id);
            if (count == 0){
                throw new Exception("删除用户失败！");
            }
            map.put("success",true);
            map.put("msg","删除成功！");
        } catch (Exception e) {
            map.put("success",false);
             map.put("msg","删除用户失败！请稍后再试！");
            map.put("exc",e.toString());
        }
        return map;
    }

    /**
     * 查询用户信息
     * @param username
     * @return
     */
    @ResponseBody
    @GetMapping("/manager/searchUser")
    public Map<String,Object> searchUser(@RequestParam("username")String username){
        Map<String,Object> map = new HashMap<>();
        try {
            ViewsUser viewsUser = managerService.findAllUserByUserNameAndGender(username);
            if (viewsUser == null) throw new Exception("没有查询到相关用户！");
            System.out.println(viewsUser);
            map.put("viewsUser",viewsUser);
            map.put("success",true);
        }catch (Exception e){
            map.put("success",false);
            map.put("msg","没有查询到相关用户！");
            map.put("exc",e.toString());
        }
        return map;
    }

    /**
     * 添加商品种类
     * @param goodsType
     * @return
     */
    @ResponseBody
    @PostMapping("/manager/addGoodsType")
    public Map<String,Object> addGoodsType(GoodsType goodsType){
        Map<String,Object> map = new HashMap<>();
        try {
            int count = managerService.addGoodsType(goodsType);
            if (count == 0)throw new Exception("添加商品种类失败！");
            map.put("success",true);
            map.put("msg","添加商品种类成功！");
        } catch (Exception e) {
            map.put("success",false);
            map.put("exc",e.toString());
            map.put("msg","添加商品种类失败！请稍后尝试！");
        }
        return  map;
    }

    /**
     * 获取商品种类
     * @return
     */
    @ResponseBody
    @GetMapping("/manager/getGoodsTypeName")
    public Map<String,Object> getGoodsTypeName(){
        Map<String,Object> map = new HashMap<>();
        try {
            List<GoodsType> goodsTypeList =  managerService.findGoodsTypeName();
            if (goodsTypeList == null || goodsTypeList.size() == 0)throw new Exception("没有查到相关数据！");
            map.put("goodsType",goodsTypeList);
            map.put("success",true);
        } catch (Exception e) {
            map.put("success",false);
            map.put("msg","没有查到相关数据！");
            map.put("exc",e.toString());
        }
        return map;
    }

    /**
     * 添加商品信息
     * @param session
     * @param goods
     * @param file
     * @return
     */
    @ResponseBody
    @PostMapping("/manager/addGoods")
    public Map<String,Object> addGoods(HttpSession session,Goods goods,@RequestParam(value = "img")MultipartFile file){
        Map<String,Object> map = new HashMap<>();
        try {
            //获取上传的文件名
            String filename = file.getOriginalFilename();
            if (filename == null)throw new Exception("您还没有选择要上传的图片！请选择！");
            //判断是否为图片文件
            if (!filename.matches("^.*(gif|jpg|jpeg|png|GIF|JPG|PNG)$"))throw new Exception("您上传的不是图片文件！");
            //处理文件重名问题
            //获取上传文件的后缀名 substring():截取从什么开始到末尾的字符串
            //lastIndexOf():获取最后出现 " . " 的索引位置
            String suffixName = filename.substring(filename.lastIndexOf("."));
            //将UUID作为文件名 replaceAll():把文件名中出现的 "-" 替换成空字符串
            String uuId = UUID.randomUUID().toString().replaceAll("-", "");
            //将uuId和后缀名拼接后的结果作为最终的文件名
            filename = uuId +suffixName;
            //获取服务器中的存储图片的路径
            ServletContext servletContext = session.getServletContext();
            String realPath = servletContext.getRealPath("/static/image");
            File files = new File(realPath);
            if (!files.exists()){
                files.mkdir();
            }
            String finalPath = realPath +File.separator + filename;
            file.transferTo(new File(finalPath));
            //把图片保存在数据库中
            String imgUrl = "static/image/"+filename;
            System.out.println(imgUrl);
            goods.setImage(imgUrl);
            System.out.println(goods);
            if (goods.getTypeId() == null || goods.getGoodName() == null || goods.getAddTime() == null
                || goods.getImage() == null || goods.getPrice() == null || goods.getStar() == null || goods.getDetail() == null)throw new Exception("内容不能为空！");
            int count = managerService.addGoods(goods);
            if (count == 0)throw new Exception("添加商品失败！");
            map.put("success",true);
            map.put("msg","添加商品成功！");
        } catch (Exception e) {
            map.put("success",false);
            map.put("exc1","您还没有选择要上传的图片！请选择！");
            map.put("exc2","您上传的不是图片文件！");
            map.put("exc3","内容不能为空！");
            map.put("msg","添加商品失败！");
        }
        return map;
    }

    /**
     * 获取所有的商品
     * @param pageNum
     * @return
     */
    @ResponseBody
    @GetMapping("/manager/getGoods")
    public Map<String,Object> getGoods(@RequestParam(value = "pageNum",defaultValue = "1")Integer pageNum){
        Map<String,Object> map = new HashMap<>();
        try {
            //分页查询，一页显示5条数据
            PageHelper.startPage(pageNum,5);
            List<Goods> goodsList = managerService.findAllGoods();
            //navigatePage:分页导航条的显示
            PageInfo pageInfo = new PageInfo(goodsList,5);
            System.out.println(pageInfo);
            map.put("page",pageInfo);
            map.put("success",true);
        } catch (Exception e) {
            map.put("success",false);
            map.put("exc",e.toString());
        }
        return map;
    }

    /**
     * 删除商品
     * @param goodIds
     * @return
     */
    @ResponseBody
    @DeleteMapping("/manager/delGoods/{goodIds}")
    public Map<String,Object> delGoods(HttpSession session,@PathVariable("goodIds")String goodIds){
        Map<String,Object> map = new HashMap<>();
        try {
            if (goodIds.contains("-")){
                //批量删除
                List<Integer> list_ids = new ArrayList<>();
                String[] split_ids = goodIds.split("-");
                for (String id : split_ids) {
                    Integer goodId = Integer.valueOf(id);
                    System.out.println(goodId);
                    //遍历删除图片
                    Goods goods = managerService.findGoodsById(goodId);
                    if (goods == null)throw new Exception("您查找的商品信息不存在!");
                    String image = goods.getImage();
                    System.out.println(image);
                    String subPath = image.substring(image.lastIndexOf("/"));
                    System.out.println(subPath);
                    ServletContext servletContext = session.getServletContext();
                    String path = servletContext.getRealPath("/static/image");
                    String realPath = path + subPath;
                    File file = new File(realPath);
                    if (file.exists() && file.isFile()){
                        file.delete();
                    }else {
                        throw new Exception("图片文件删除失败！");
                    }
                    //把gooId添加到list集合中
                    list_ids.add(goodId);
                }
                System.out.println(list_ids);
                int count = managerService.delBatch(list_ids);
                if (count == 0)throw new Exception("批量删除失败！");
                map.put("success",true);
                map.put("msg","批量删除成功！");
            }else{
                //单个删除
                //查询商品图片信息
                Integer goodId = Integer.valueOf(goodIds);
                Goods goods = managerService.findGoodsById(goodId);
                if (goods == null)throw new Exception("您查找的商品信息不存在!");
                String image = goods.getImage();
                System.out.println(image);
                String subPath = image.substring(image.lastIndexOf("/"));
                System.out.println(subPath);
                ServletContext servletContext = session.getServletContext();
                String path = servletContext.getRealPath("/static/image");
                String realPath = path + subPath;
                File file = new File(realPath);
                if (file.exists() && file.isFile()){
                    file.delete();
                }else {
                    throw new Exception("图片文件删除失败！");
                }
                int count = managerService.delGoods(goodId);
                if (count == 0){
                    throw new Exception("删除商品失败！");
                }
                map.put("success",true);
                map.put("msg","删除成功！");
            }

        } catch (Exception e) {
            map.put("success",false);
            map.put("msg","删除商品失败！请稍后再试！");
            map.put("exc1","您查找的商品信息不存在!");
            map.put("exc2","图片文件删除失败!");
            map.put("exc",e.toString());
        }
        return map;
    }

    /**
     * 条件查询
     * @param condition
     * @return
     */
    @ResponseBody
    @GetMapping("/manager/searchGoods")
    public Map<String,Object> searchGoods(@RequestParam(value = "pageNum",defaultValue = "1")Integer pageNum,@RequestParam("condition")String condition){
        Map<String,Object> map = new HashMap<>();
        try {
            if (condition.contains(",")){
                //多条件查询adasd,2021-10-05
                String[] str_cons = condition.split(",");
                String goodName = null;
                String typeName = null;
                for (int i = 0; i < str_cons.length; i++) {
                    goodName = str_cons[0];
                    typeName = str_cons[1];
                }
                System.out.println(goodName+","+typeName);
                Goods goods = managerService.findGoodsByGoodNameAndTypeName(goodName,typeName);
                if (goods == null)throw new Exception("没有查询到相关的商品！");
                map.put("goods",goods);
                map.put("success",true);
                map.put("msg","查询商品成功！");
            }else{
                //单条件查询
                //分页查询，一页显示5条数据
                PageHelper.startPage(pageNum,5);
                List<Goods> goodsList = managerService.findGoodsByGoodCondition(condition);
                if (goodsList == null || goodsList.size() == 0)throw new Exception("没有查询到相关的商品！");
                //navigatePage:分页导航条的显示
                PageInfo pageInfo = new PageInfo(goodsList,5);
                System.out.println(pageInfo);
                map.put("page",pageInfo);
                map.put("success",true);
                map.put("msg","查询商品成功！");
            }
        } catch (Exception e) {
            map.put("success",false);
            map.put("msg","查询商品失败！");
            map.put("exc",e.toString());
            map.put("exc1","没有查询到相关的商品！");
        }
        return map;
    }

    /**
     * 查询商品的image、price、total、star、detail
     * @param goodId
     * @return
     */
    @ResponseBody
    @GetMapping("/manager/getGoodsAndUpdate")
    public Map<String,Object> getGoodsAndUpdate(@RequestParam("goodId")Integer goodId){
        Map<String,Object> map = new HashMap<>();
        try {
            Goods goods = managerService.getGoodsById(goodId);
            if (goods == null)throw new Exception("没有查到商品的相关信息！");
            map.put("goods",goods);
            map.put("success",true);
            map.put("msg","查询商品成功！");
        } catch (Exception e) {
            map.put("success",false);
            map.put("msg","没有查到商品的相关信息！");
            map.put("exc",e.toString());
        }
        return map;
    }

    /**
     * 更新商品的信息
     * @param goodId
     * @param goods
     * @return
     */
    @ResponseBody
    @PutMapping("/manager/updateGoods/{goodId}")
    public Map<String,Object> updateGoods(@PathVariable("goodId")Integer goodId,Goods goods){
        Map<String,Object> map = new HashMap<>();
        try {
            int count = managerService.updateGoods(goods,goodId);
            if (count == 0)throw new Exception("修改商品信息失败！");
            map.put("success",true);
            map.put("msg","修改商品信息成功！");
        } catch (Exception e) {
            map.put("success",false);
            map.put("msg","修改商品信息失败！");
            map.put("exc",e.toString());
        }
        return map;
    }
}


