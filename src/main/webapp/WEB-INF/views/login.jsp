<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <%
        pageContext.setAttribute("PATH",request.getContextPath());
    %>
    <link href="${PATH}/static/bootstrap-3.4.1-dist/css/bootstrap.min.css" rel="stylesheet">
    <script type="text/javascript" src="${PATH}/static/js/jquery-3.3.1.js"></script>
    <link rel="stylesheet" type="text/css" href="${PATH}/static/bootstrap-3.4.1-dist/css/login.css">
    <title>XYZ-登录</title>
</head>
<body background="${PATH}/static/image/login-background.jpg">
<div class="regist" style="height: 550px">
    <div class="regist_center">
        <div class="regist_top">
            <div class="left fl"><span class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;欢迎登录</div>
            <div class="right fr">
                <a id="adminLogin">管理员</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <script type="text/javascript">
                    $(function () {
                        $("#adminLogin").click(function () {
                            window.location.href = "manager/"
                        })
                    });
                </script>
                <a>XYZ购物网</a>
            </div>
            <div class="clear"></div>
            <div class="xian center"></div>
        </div>
        <div class="center-block" style="margin-top: 80px;margin-left: 240px">
            <form class="form-horizontal" id="loginForm">
                <div class="form-group">
                    <label class="col-sm-2 control-label">用户名：</label>
                    <div class="col-sm-8" style="width: 40%">
                        <label for="username">
                            <input type="text" id="username" name="username" class="form-control col-sm-10"
                                   placeholder="请输入用户名……" value="${sessionScope.registerName}" />
                        </label>
                    </div>
                    <div class="col-sm-4">
                        <p class="text-danger"><span class="help-block " id="usernameMsg"></span></p>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">密码：</label>
                    <div class="col-sm-8" style="width: 40%">
                        <label>
                            <input type="password" name="password" id="password"
                                   class="form-control col-sm-10" placeholder="请输入密码……" />
                        </label>
                    </div>
                    <div class="col-sm-4">
                        <p class="text-danger"><span id="helpBlock" class="help-block "></span></p>
                    </div>
                </div>
                <div class="form-group">
                    <img id="img_code"  class="col-sm-4" style="float:right; margin-right:160px ;width: 125px;height: 32px"
                         onclick="changeCode(this)" src="${PATH}/kaptcha.jpg">
                    <label class="col-sm-2 control-label">验证码：</label>
                    <div class="col-sm-10" style="width: 40%">
                        <label>
                            <input type="text" name="code" id="code"
                                   class="form-control" placeholder="请输入验证码……" />
                        </label>
                    </div>
                    <%--<div class="col-sm-4">--%>
                        <%--<p class="text-danger"><span id="" class="help-block "></span></p>--%>
                    <%--</div>--%>
                </div>
                <hr>
            </form>
            <div class="form-group">
                <div class="col-sm-7 col-sm-push-2">
                    <input id="loginBtn" type="button" value="登录" class="btn btn-primary  btn-md"/>
                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                    <input type="button" id="registerBtn" value="注册" class="btn btn-default  btn-md"/>
                    <script type="text/javascript">
                        $(function () {
                            $("#registerBtn").click(function () {
                                location.href = "views/goRegister";
                            });
                            $("#loginBtn").click(function () {
                                // alert($("#loginForm").serialize())
                                //验证验证码
                                var code = $("#code").val();
                                //去掉验证码前后的空格
                                var codeTrim = $.trim(code);
                                if (codeTrim == null || codeTrim === ""){
                                    alert("验证码不能为空！");
                                    return false;
                                }
                                $.ajax({
                                    url:"${PATH}/views/login",
                                    type:"POST",
                                    data:$("#loginForm").serialize(),
                                    success:function (data) {
                                        console.log(data);
                                        if (data.success === true){
                                            location.href = "views/index";
                                            $("#username").val("");
                                            $("#password").val("");
                                            $("#code").val("");
                                            //提交之后验证码更新
                                            $("#img_code").click();
                                        }else{
                                            if (data.msg != null) {
                                                alert(data.msg);
                                                $("#username").val("");
                                                $("#password").val("");
                                                $("#code").val("");
                                                //提交之后验证码更新
                                                $("#img_code").click();
                                            }else{
                                                // var str = data.exc;
                                                // // console.log(str);
                                                // //获取用户名和密码不存在的异常
                                                // var message = str.substring(str.lastIndexOf("\:")+1,str.length);
                                                // // console.log(message);
                                                alert("账号不存在，请检查账号或者密码！");
                                                $("#username").val("");
                                                $("#password").val("");
                                                $("#code").val("");
                                                //提交之后验证码更新
                                                $("#img_code").click();
                                            }
                                        }
                                    }
                                })
                            });
                        });
                        //点击更换验证码
                        function changeCode(img) {
                            img.src = "${PATH}/kaptcha.jpg?" + Math.floor(Math.random()*100);
                        }
                    </script>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
