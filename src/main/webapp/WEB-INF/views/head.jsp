<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        pageContext.setAttribute("PATH",request.getContextPath());
    %>
    <link href="${PATH}/static/bootstrap-3.4.1-dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="${PATH}/static/bootstrap-3.4.1-dist/css/main.css"/>
    <script type="text/javascript" src="${PATH}/static/js/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="${PATH}/static/js/js/jquery.min.js"></script>
    <script type="text/javascript" src="${PATH}/static/bootstrap-3.4.1-dist/js/bootstrap.js"></script>
    <script type="text/javascript" src="${PATH}/static/js/viewUtils.js"></script>
    <title></title>
    <script type="text/javascript">
        $(function(){
            getUser();
            //页面加载 就要完成商品类型的加载
            $.ajax({
                url:"${PATH}/views/findgoodsType",
                method:"GET",
                success:function(data) {
                    console.log(data);
                    if (data.success === true){
                        showGoodsType(data);
                    }
                }
            });
            function showGoodsType(data) {
                var list = data.list;
                $.each(list,function () {
                    var li = $("<li></li>").append($("<a></a>").append(this.typeName).attr("href","${PATH}/views/goodsList?typeId="+this.typeId).attr("type_id",this.typeId));
                    li.appendTo($("#goodsType"));
                })
            }

            function getUser(){
                $.ajax({
                    url:"${PATH}/view/getUser",
                    type:"GET",
                    success:function (data) {
                        console.log(data);
                        if (data.success === true){
                            showUserInfo(data);
                        }
                    }
                })
            }

            //给个人中心绑定单击事件
            $(".self").click(function () {
                $('#mySelfModal').modal({
                    backdrop:"static"
                });
                getUser();
            });

            //给用户修改按钮绑定单击事件
            $(".update_btn").click(function () {
                var userId = $(".update_btn").attr("userId");
                // alert($("#selfForm").serialize())
                if (confirm("您确定要修改您的信息吗？")){
                    $.ajax({
                        url:"${PATH}/views/updateUser/" + userId,
                        type:"PUT",
                        data:$("#selfForm").serialize(),
                        success:function (data) {
                            console.log(data);
                            if (data.success === true){
                                commonUtil.message(data.msg,"success");
                                $('#mySelfModal').modal('hide');
                            }else{
                                commonUtil.message(data.msg,"danger");
                            }
                        }
                    })
                }
            });
        });

        function showUserInfo(data){
            var username = data.user.username;
            $("#userName").val(username);
            var password = data.user.password;
            $("#password").val(password);
            var phoneNum = data.user.phoneNum;
            $("#phoneNum").val(phoneNum);
            var email = data.user.email;
            $("#email").val(email);
            var gender = data.user.gender;
            $("#gender").val(gender);
            var userId = data.user.id;
            $(".update_btn").attr("userId",userId);
            $(".addr").attr("user_id",userId);
        }




    </script>
</head>
<body>
<%--显示个人中心的模态框--%>
<div class="modal fade" tabindex="-1" role="dialog" id="mySelfModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">个人信息</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="selfForm">
                    <div class="form-group row">
                        <label class="col-sm-3 control-label" style="margin-top: 23px">用户名：</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control" name="username" id="userName"/>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-3 control-label" style="margin-top: 23px">用户密码：</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control" name="password" id="password"/>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-3 control-label" style="margin-top: 23px">用户手机：</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control" name="phoneNum" id="phoneNum"/>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-3 control-label" style="margin-top: 23px">用户邮箱：</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control" name="email" id="email"/>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-3 control-label" style="margin-top: 23px">用户性别：</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control" name="gender" id="gender"/>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary update_btn">修改</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<div id="top">
    <div id="topdiv">
            <span>
                <a href="${PATH}/views/index" id="a_top">下一站购物网</a>
                <li>|</li>
                <a href="${PATH}/views/index" id="a_top">XYZ购物网网页版</a>
                <li>|</li>
                <%--<a href="#" id="a_top">问题反馈</a>--%>
                <a href="#" id="a_top">问题反馈</a>
            </span>
        <span style="float:right">
                <%--<a id="a_top">欢迎您：${sessionScope.home_user}</a>--%>
                <a id="a_top">欢迎您：${sessionScope.home_user}</a>
                <li>|</li>
                <a href="${PATH}/loginOut" id="a_top">注销</a>
                <li>|</li>
                <a href="${PATH}/views/order" id="a_top">我的订单</a>
       			<li>|</li>
                <a id="a_top" class="self">个人中心</a>
                <li>|</li>
                <a href="${PATH}/views/address" id="a_top" class="addr">收获地址</a>
                <li>|</li>
                <a href="#" id="a_top">消息通知</a>
                <a href="${PATH}/views/cart" id="shorpcar">购物车</a>
            </span>
    </div>
</div>
<div>
    <table style="height:100px;width:86%" align="center">
        <tr>
            <td>
                <img id="logo" src="${PATH}/static/image/lg.png" width="200px" height="60px" alt=""/>
            </td>
            <td>
                <ul class="nav nav-pills" id="goodsType">
                </ul>
            </td>
            <td align="right">
                <form class="form-inline pull-right">
                    <div class="form-group" >
                        <input type="text" name="name" class="form-control" style="width: 300px"  placeholder="精准定位，搜索一下...">
                    </div>
                    <button type="button" class="btn btn-warning"><span class="glyphicon glyphicon-search"></span>&nbsp;&nbsp;搜索</button>
                </form>
            </td>
        </tr>
    </table>
</div>

</body>
</html>
