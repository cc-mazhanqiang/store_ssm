<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%
        pageContext.setAttribute("PATH",request.getContextPath());
    %>
    <link href="${PATH}/static/bootstrap-3.4.1-dist/css/bootstrap.min.css" rel="stylesheet"/>
    <script type="text/javascript" src="${PATH}/static/js/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="${PATH}/static/bootstrap-3.4.1-dist/js/bootstrap.min.js"></script>

    <style>

        .bg{
            height: 720px;
            background-image:url(${PATH}/static/image/adminlogin.gif);
            background-size:cover;
        }

        .form{
            padding: 40px;
            margin-top: 200px;
            background: rgba(255,255,255,0.2);
        }

    </style>
</head>
<body>
<div class="container-fluid">
    <div class="row bg">
        <div class="col-md-offset-6 col-md-4 form">
            <div id="msg" style="text-align: center">
            </div>
            <h1 class="col-md-offset-3"><p style="color: white">后台管理系统</p></h1>
            <form class="form-horizontal" id="loginForm">
                <div class="form-group">
                    <label for="username" class="col-sm-3 control-label">账号</label>
                    <div class="col-sm-6">
                        <input type="text" name="username" class="form-control" id="username" placeholder="请输入用户名">
                    </div>
                </div>
                <div class="form-group">
                    <label for="password" class="col-sm-3 control-label">密码</label>
                    <div class="col-sm-6">
                        <input type="password" name="password" class="form-control" id="password" placeholder="请输入密码">
                    </div>
                </div>
            </form>
            <div class="col-sm-offset-3 col-sm-5">
                <button  type="button" id="adminLoginBtn" class="btn btn-success"  style="width: 50%;">登录</button>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
   $(function () {
       $("#adminLoginBtn").click(function () {
           // alert($("#loginForm").serialize());
           $.ajax({
               url:"${PATH}/manager/login",
               type:"POST",
               data:$("#loginForm").serialize(),
               success:function (data) {
                    // console.log(data)
                    console.log(data);
                   if (data.success === true){
                       location.href = "adminIndex";
                   }else{
                       // var msg = $("<p></p>").css({color:"red"}).append("登录失败！请检查用户名或密码！");
                       // msg.appendTo($("#msg"));
                       alert("登录失败！请检查用户名或密码！");
                   }
               }
           });
       });
   });
</script>
</body>
</html>
