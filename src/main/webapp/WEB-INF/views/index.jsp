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
<div class="panel panel-default" style="margin: 0 auto;width: 82%;">
    <div class="panel-body">
        <!--列表开始-->
        <div class="row" style="margin: 0 auto;" id="data1">

        </div>
    </div>
</div>
<div class="fifth">
    <span class="fif_text">热销酒类</span>
</div>
<div class="panel panel-default" style="margin: 0 auto;width: 82%;">
    <div class="panel-body">
        <!--列表开始-->
        <div class="row" style="margin: 0 auto;" id="data2">

        </div>
    </div>
</div>
<div class="fifth">
    <span class="fif_text">热销零食</span>
</div>
<div class="panel panel-default" style="margin: 0 auto;width: 82%;">
    <div class="panel-body">
        <!--列表开始-->
        <div class="row" style="margin: 0 auto;" id="data3">

        </div>
    </div>
</div>
<script type="text/javascript">
    $(function() {
        $.ajax({
           url:"${PATH}/views/goodsMore",
            type:"GET",
            success:function (data) {
                console.log(data);
                if (data.success === true){
                    $.each(data.starList,function () {
                       if (this.typeId === 1){
                           var divs = $("<div class='col-sm-2'></div>");
                           var div = $("<div class='thumbnail' style='text-align: center'></div>");
                           var image = $("<a></a>").append($("<img></img>").attr("src","${PATH}/"+this.image)).attr("href","${PATH}/views/goodsDetail?goodId="+this.goodId);
                           var h4 = $("<h4></h4>").append(this.goodName);
                           var starImages = "";
                           var p = $("<p></p>").append("热销指数：");
                           //这边显示的是-7之后的star
                           for (var i = this.star; i <= 10; i++) {
                               starImages = ($("<img></img>").attr("src","${PATH}/static/image/star_red.gif"));
                               p.append(starImages);
                           }
                           var p1 = $("<p></p>").append("上架日期："+this.addTime);
                            var p2 = $("<p style='color:orange'></p>").append("价格："+this.price).append($("<span class='glyphicon glyphicon-yen'></span>"));
                            div.append(image).append(h4).append(p).append(p1).append(p2);
                            divs.append(div);
                            divs.appendTo("#data1")
                       }
                    });
                    $.each(data.starList,function () {
                        if (this.typeId === 2){
                            var divs = $("<div class='col-sm-2'></div>");
                            var div = $("<div class='thumbnail' style='text-align: center'></div>");
                            var image = $("<a></a>").append($("<img></img>").attr("src","${PATH}/"+this.image)).attr("href","${PATH}/views/goodsDetail?goodId="+this.goodId);
                            var h4 = $("<h4></h4>").append(this.goodName);
                            var starImages = "";
                            var p = $("<p></p>").append("热销指数：");
                            //这边显示的是-7之后的star
                            for (var i = this.star; i <= 10; i++) {
                                starImages = ($("<img></img>").attr("src","${PATH}/static/image/star_red.gif"));
                                p.append(starImages);
                            }
                            var p1 = $("<p></p>").append("上架日期："+this.addTime);
                            var p2 = $("<p style='color:orange'></p>").append("价格："+this.price).append($("<span class='glyphicon glyphicon-yen'></span>"));
                            div.append(image).append(h4).append(p).append(p1).append(p2);
                            divs.append(div);
                            divs.appendTo("#data2")
                        }
                    });
                    $.each(data.starList,function () {
                        if (this.typeId === 3){
                            var divs = $("<div class='col-sm-2'></div>");
                            var div = $("<div class='thumbnail' style='text-align: center'></div>");
                            var image = $("<a></a>").append($("<img></img>").attr("src","${PATH}/"+this.image)).attr("href","${PATH}/views/goodsDetail?goodId="+this.goodId);
                            var h4 = $("<h4></h4>").append(this.goodName);
                            var starImages = "";
                            var p = $("<p></p>").append("热销指数：");
                            //这边显示的是-7之后的star
                            for (var i = this.star; i <= 10; i++) {
                                starImages = ($("<img></img>").attr("src","${PATH}/static/image/star_red.gif"));
                                p.append(starImages);
                            }
                            var p1 = $("<p></p>").append("上架日期："+this.addTime);
                            var p2 = $("<p style='color:orange'></p>").append("价格："+this.price).append($("<span class='glyphicon glyphicon-yen'></span>"));
                            div.append(image).append(h4).append(p).append(p1).append(p2);
                            divs.append(div);
                            divs.appendTo("#data3")
                        }
                    })
                }
            }
        });
    });
</script>
<div id="con1"></div>

</body>
</html>
