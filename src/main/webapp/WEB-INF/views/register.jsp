<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8" %>
<html>
<head>
    <%
        pageContext.setAttribute("PATH",request.getContextPath());
    %>
    <link href="${PATH}/static/bootstrap-3.4.1-dist/css/bootstrap.min.css" rel="stylesheet">
    <script type="text/javascript" src="${PATH}/static/js/jquery-3.3.1.js"></script>
    <link rel="stylesheet" type="text/css" href="${PATH}/static/bootstrap-3.4.1-dist/css/login.css">
    <title>XYZ-注册</title>
    <script type="text/javascript">
        $(function(){
            // $("#registerBtn").click(function () {
            $("#username").blur(function () {
                // 验证用户名：必须由字母，数字下划线组成，并且长度为 5 到 12 位
                var username = $("#username").val();
                var usernamePatt = /(^\w{5,12}$)|(^[\u2E80-\u9FFF]{2,5})/;
                if (!usernamePatt.test(username)) {
                    show_error_msg("#usernameMsg","用户名可以由5-12位字母，数字下划线组成或2-5位中文！");
                    $("#registerBtn").attr("username","error");
                }else{
                    // show_success_msg("#usernameMsg");
                    var username = this.value;
                    $.get({
                        url:"${PATH}/views/checkUserName",
                        data:"username=" + username,
                        success:function (data) {
                            // console.log(data);
                            if (data.success === false){
                                // alert("用户名已经存在");
                                show_error_msg("#usernameMsg","用户名已经存在！");
                                $("#registerBtn").attr("username","error");
                            }else{
                                show_success_msg("#usernameMsg","用户名可以使用！");
                                $("#registerBtn").attr("username","success");
                            }
                        }
                    })
                }
            });
            $("#password").blur(function () {
                // 验证密码：必须由字母，数字下划线组成，并且长度为 5 到 12 位
                var password = $("#password").val();
                var passwordPatt = /^\w{5,12}$/;
                if (!passwordPatt.test(password)) {
                    // alert("密码不合法！");
                    show_error_msg("#passwordMsg");
                    $("#registerBtn").attr("password","error");
                }else{
                    show_success_msg("#passwordMsg");
                    $("#registerBtn").attr("password","success");
                }
            });
            $("#checkPassword").blur(function () {
                // 验证确认密码：和密码相同
                var password = $("#password").val();
                var repwd = $("#checkPassword").val();
                if (repwd !== password || repwd === "") {
                    // alert("确认密码和密码不一致！");
                    show_error_msg("#checkPasswordMsg");
                    $("#registerBtn").attr("password","error");
                }else{
                    show_success_msg("#checkPasswordMsg");
                    $("#registerBtn").attr("password","success");
                }
            });

            $("#email").blur(function () {
                // 邮箱验证：xxxxx@xxx.com
                var email = $("#email").val();
                var emailPatt = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
                if (!emailPatt.test(email)) {
                    // alert("邮箱格式不正确！");
                    show_error_msg("#emailMsg","邮箱格式不正确!");
                    $("#registerBtn").attr("email","error");
                }else{
                    // show_success_msg("#emailMsg");
                    var email = this.value;
                    $.get({
                        url:"${PATH}/views/checkEmail",
                        data:"email=" + email,
                        success:function (data) {
                            // console.log(data);
                            if (data.success === false){
                                // alert("该邮箱已经被注册啦");
                                show_error_msg("#emailMsg","该邮箱已经被注册啦！");
                                $("#registerBtn").attr("email","error");
                            }else{
                                show_success_msg("#emailMsg","邮箱可以使用！");
                                $("#registerBtn").attr("email","success");
                            }
                        }
                    })
                }
            });
            $("#phoneNum").blur(function () {
                // ”^(\(\d{3,4}-)|\d{3.4}-)?\d{7,8}$”
                var phone = $("#phoneNum").val();
                var checkPhone=/^1[2-9]\d{9}$/;
                if (!checkPhone.test(phone)){
                    show_error_msg("#phoneMsg","该手机号格式错误！");
                    $("#registerBtn").attr("phoneNum","error");
                } else {
                    // show_success_msg("#phoneMsg");
                    var phoneNum = this.value;
                    $.get({
                        url:"${PATH}/views/checkPhoneNum",
                        data:"phoneNum=" + phoneNum,
                        success:function (data) {
                            // console.log(data);
                            if (data.success === false){
                                // alert("该手机号已经存在");
                                show_error_msg("#phoneMsg","该手机号已经被注册啦！");
                                $("#registerBtn").attr("phoneNum","error");
                            }else{
                                show_success_msg("#phoneMsg","该手机号可以使用！");
                                $("#registerBtn").attr("phoneNum","success");
                            }
                        }
                    })
                }
            });

            function show_success_msg(ele,msg){
                $(ele).html("");
                $(ele).next("p").removeClass("text-success text-danger glyphicon glyphicon-ok glyphicon glyphicon-remove");
                $("<p></p>").addClass("text-success").append("<span></span>")
                    .css("margin-top","10px").addClass("glyphicon glyphicon-ok").text(msg)
                    .appendTo(ele);
            }
            function show_error_msg(ele,msg){
                $(ele).html("");
                $("<p></p>").addClass("text-danger").append("<span></span>")
                    .css("margin-top","10px").addClass("glyphicon glyphicon-remove").text(msg)
                    .appendTo(ele);
            }

            $("#registerBtn").click(function () {
                // alert($("#registerForm").serialize())
                //如果校验失败不能发送ajax请求
                if ($(this).attr("username") === "error"){
                    // alert($(this).attr("send"));
                    alert("用户名错误！，请检查填写信息！");
                    return false;
                }else if ($(this).attr("password") === "error") {
                    alert("密码有误！，请检查填写信息！");
                    return false;
                }else if ($(this).attr("email") === "error") {
                    alert("邮箱有误！，请检查填写信息！");
                    return false;
                }else if ($(this).attr("phoneNum") === "error") {
                    alert("手机有误！，请检查填写信息！");
                    return false;
                } else {
                    $.ajax({
                        url:"${PATH}/views/register",
                        type:"POST",
                        data:$("#registerForm").serialize(),
                        success:function (data) {
                            console.log(data);
                            if (data.success === true){
                                alert("注册成功");
                                location.href = "views/goLogin";
                            }else{
                                alert("注册失败");
                                location.href = "views/goRegister";
                            }
                        }
                    })
                }
            });
        });
    </script>
</head>
<body>
<div class="regist">
    <div class="regist_center">
        <div class="regist_top">
            <div class="left fl"><span class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;加入我们</div>
            <div class="right fr">
                <a href="index.jsp" target="_black">XYZ购物网</a>
            </div>
            <div class="clear"></div>
            <div class="xian center"></div>
        </div>
        <div class="center-block" style="margin-top: 80px;">
            <form class="form-horizontal" id="registerForm">
                <div class="form-group">
                    <label class="col-sm-2 control-label">用户名：</label>
                    <div class="col-sm-8" style="width: 40%">
                        <input type="text" id="username" name="username" class="form-control col-sm-10"
                               placeholder="请输入用户名……" />
                    </div>
                    <div class="col-sm-4" id="usernameMsg">
                        <span class="glyphicon glyphicon-star" style="font-size: 12px;color: red;margin-top: 10px">:必须由字母,数字下划线或2-5位文字组成,并且长度为5到12位</span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">密码：</label>
                    <div class="col-sm-8" style="width: 40%">
                        <input type="password" name="password" id="password"
                               class="form-control col-sm-10" placeholder="请输入密码……" />
                    </div>
                    <div class="col-sm-4" id="passwordMsg">
                        <span class="glyphicon glyphicon-star" style="font-size: 12px;color: red;margin-top: 10px">:必须由字母,数字下划线组成,并且长度为5到12位</span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">确认密码：</label>
                    <div class="col-sm-8" style="width: 40%">
                        <input type="password" id="checkPassword" class="form-control col-sm-10"
                               placeholder="请确认密码……" />
                    </div>
                    <div class="col-sm-4" id="checkPasswordMsg">
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-2 control-label">邮箱：</label>
                    <div class="col-sm-8" style="width: 40%">
                        <input type="text" name="email" id="email" class="form-control col-sm-10"
                               placeholder="请输入邮箱……" />
                    </div>
                    <div class="col-sm-4" id="emailMsg">
                        <span class="glyphicon glyphicon-star" style="font-size: 12px;color: red;margin-top: 10px">:xxxxx@xxx.com</span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">手机：</label>
                    <div class="col-sm-8" style="width: 40%">
                        <input type="text" name="phoneNum" id="phoneNum" class="form-control col-sm-10"
                               placeholder="请输入手机号……" />
                    </div>
                    <div class="col-sm-4" id="phoneMsg">
                        <%--<span class="glyphicon glyphicon-star" style="font-size: 12px;color: red;margin-top: 10px">:必须由字母,数字下划线组成,并且长度为5到12位</span>--%>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">性别：</label>
                    <div class="col-sm-8" style="width: 40%">
                        <label class="radio-inline">
                            <input type="radio" id="gender" name="gender" checked="checked" value="男">男
                        </label>
                        <label class="radio-inline">
                            <input type="radio" name="gender" value="女">女
                        </label>
                    </div>
                </div>
                <hr>
                <div class="form-group">
                    <div class="col-sm-7 col-sm-push-2">
                        <input id="registerBtn" type="button" value="注册" class="btn btn-primary  btn-md"/> &nbsp; &nbsp;
                        <input type="reset" value="重置" class="btn btn-default  btn-md"/>
                        <a id="gologin" style="color: red;float: right;margin-top: 8px;margin-right: 200px">已有账号？立即登录</a>
                        <script type="text/javascript">
                            $(function () {
                               $("#gologin").click(function () {
                                   location.href = "views/goLogin"
                               });
                            });
                        </script>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>
