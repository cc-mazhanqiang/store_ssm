<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>XYZ购物网</title>
    <%
        pageContext.setAttribute("PATH",request.getContextPath());
    %>
    <link href="${PATH}/static/bootstrap-3.4.1-dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="stylesheet" href="${PATH}/static/bootstrap-3.4.1-dist/css/main.css"/>
    <script type="text/javascript" src="${PATH}/static/js/jquery-3.3.1.js"></script>
    <script type="text/javascript" src="${PATH}/static/js/js/jquery.min.js"></script>
    <script type="text/javascript" src="${PATH}/static/bootstrap-3.4.1-dist/js/bootstrap.js"></script>
    <script type="text/javascript">
        $(document).ready(function(){
            $('#con').load('head');
            $("#con1").load('foot')
        })
    </script>
</head>
<body>
<div id="con"></div>
<div id="thred" style="height:310px">
    <div id="myCarousel" class="carousel slide" >
        <ol class="carousel-indicators">
            <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
            <li data-target="#myCarousel" data-slide-to="1"></li>
            <li data-target="#myCarousel" data-slide-to="2"></li>
            <li data-target="#myCarousel" data-slide-to="3"></li>
        </ol>
        <div class="carousel-inner">
            <div class="item active">
                <img src="${PATH}/static/image/b1.JPG" alt="First slide">
            </div>
            <div class="item">
                <img src="${PATH}/static/image/b2.JPG" alt="Second slide">
            </div>
            <div class="item">
                <img src="${PATH}/static/image/b3.JPG" alt="Third slide">
            </div>
            <div class="item">
                <img src="${PATH}/static/image/b4.JPG" alt="Four slide">
            </div>
        </div>
        <a class="carousel-control left" href="#myCarousel" role="button"
           data-slide="prev"> <span
                class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
            <span class="sr-only">上一张</span>
        </a> <a class="right carousel-control" href="#myCarousel" role="button"
                data-slide="next"> <span
            class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
        <span class="sr-only">下一张</span>
    </a>
    </div>
</div>
<div class="fifth">
    <span class="fif_text">热销饮品</span>
</div>
<div class="sixth" id="data1">

</div>
<div class="fifth">
    <span class="fif_text">热销酒类</span>
</div>
<div class="sixth" id="data2">

</div>
<div class="fifth">
    <span class="fif_text">热销零食</span>
</div>
<div class="sixth" id="data3">

</div>
<script type="text/javascript">
    $(function() {
        <%--$.get("getGoodsIndex",null,function(arr){--%>
            <%--var s="";--%>
            <%--for(var i=0;i<arr[0].length;i++){--%>
                <%--var g=arr[0][i];--%>
                <%--s+="<span class='sindex'><a class='siximg' href='${pageContext.request.contextPath}/getGoodsById?id="+--%>
                    <%--g.id+"'><img src='./fmwimages/"+g.picture+"' width='234px' height='234px' /></a><a class='na'>"+--%>
                    <%--g.name+"</a><p class='chip'>"+g.intro+"</p><p class='pri'>￥"+g.price+"元</p></span>";--%>
            <%--}--%>
            <%--$("#data1").html(s);--%>
            <%--s="";--%>
            <%--for(var i=0;i<arr[1].length;i++){--%>
                <%--var g=arr[1][i];--%>
                <%--s+="<span class='sindex'><a class='siximg' href='${pageContext.request.contextPath}/getGoodsById?id="+--%>
                    <%--g.id+"'><img src='./fmwimages/"+g.picture+"' width='234px' height='234px' /></a><a class='na'>"+--%>
                    <%--g.name+"</a><p class='chip'>"+g.intro+"</p><p class='pri'>￥"+g.price+"元</p></span>";--%>
            <%--}--%>
            <%--$("#data2").html(s);--%>
            <%--s="";--%>
            <%--for(var i=0;i<arr[2].length;i++){--%>
                <%--var g=arr[2][i];--%>
                <%--s+="<span class='sindex'><a class='siximg' href='${pageContext.request.contextPath}/getGoodsById?id="+--%>
                    <%--g.id+"'><img src='./fmwimages/"+g.picture+"' width='234px' height='234px' /></a><a class='na'>"+--%>
                    <%--g.name+"</a><p class='chip'>"+g.intro+"</p><p class='pri'>￥"+g.price+"元</p></span>";--%>
            <%--}--%>
            <%--$("#data3").html(s);--%>

        // });
    });
</script>
<div id="con1"></div>

</body>
</html>
