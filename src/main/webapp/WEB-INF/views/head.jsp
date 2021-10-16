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
    <title></title>
    <script type="text/javascript">
        $(function(){
            //页面加载 就要完成商品类型的加载
            <%--$.ajax({--%>
                <%--url:"${pageContext.request.contextPath}/goodstypejson",--%>
                <%--method:"get",--%>
                <%--success:function(list){--%>
                    <%--//var list = JSON.parse(data);--%>
                    <%--for(var t in list){--%>
                        <%--var a = $("<a href='${pageContext.request.contextPath}/getGoodsListByTn?tn="+list[t].name+"'>"+list[t].name+"</a>");--%>
                        <%--$("#goodsType").append(a);--%>
                    <%--}--%>
                <%--},--%>
                <%--error:function(){--%>
                    <%--alert("失败");--%>
                <%--}--%>
            <%--})--%>
        })
    </script>
</head>
<body>
<div id="top">
    <div id="topdiv">
            <span>
                <a href="${PATH}/views/index" id="a_top">下一站购物网</a>
                <li>|</li>
                <a href="${PATH}/views/index" id="a_top">XYZ购物网网页版</a>
                <li>|</li>
                <a href="#" id="a_top">问题反馈</a>
            </span>
        <span style="float:right">
                <a id="a_top">欢迎您：${sessionScope.home_user}</a>
                <li>|</li>
                <a href="${PATH}/views/loginOut" id="a_top">注销</a>
                <li>|</li>
                <a href="${PATH}/views/order" id="a_top">我的订单</a>
       			<li>|</li>
                <a href="self_info.jsp" id="a_top">个人中心</a>
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
                <p id="goodsType" style="padding:10px;margin-left: 20px"></p>
            </td>
            <td align="right">
                <form action="selectByName" class="form-inline pull-right">
                    <div class="form-group" >
                        <input type="text" name="name" class="form-control" style="width: 300px"  placeholder="精准定位，搜索一下...">
                    </div>
                    <button type="submit" class="btn btn-warning"><span class="glyphicon glyphicon-search"></span>&nbsp;&nbsp;搜索</button>
                </form>
            </td>
        </tr>
    </table>
</div>

</body>
</html>
