<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
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
			$("#con").load('head');
			$("#con1").load('foot');
		});

	</script>
<title>xyz-商品列表页</title>
</head>
<body>
<div id="con"></div>
    <div class="panel panel-default" style="margin: 0 auto;width: 95%;">
	<div class="panel-heading">
	    <h3 class="panel-title"><span class="glyphicon glyphicon-th-list"></span>&nbsp;&nbsp;商品列表</h3>
	</div>
	<div class="panel-body">
	   	<!--列表开始-->
	    <div class="row" style="margin: 0 auto;">
	    	<c:forEach items="${list}" var="goods">
		    	<div class="col-sm-3">
				    <div class="thumbnail">
				      <img src="${PATH}/${goods.image}" width="180" height="180"  alt="" />
				      <div class="caption" style="text-align: center">
				        <h4>商品名称：<a href="${PATH}/views/goodsDetail?goodId=${goods.goodId}">${goods.goodName}</a></h4>
				        <p>热销指数：
				        	<c:forEach begin="1" end="${goods.star}">
				        		<img src="${PATH}/static/image/star_red.gif" alt="star"/>
				        	</c:forEach>
				        </p>
				         <p>上架日期：${goods.addTime}</p>
			             <p style="color:orange">价格：${goods.price} 元</p>
				      </div>
				    </div>
				  </div>
			</c:forEach>
		</div>
   	</div>
</div>
  <!-- 底部 -->
<div id="con2"></div>
</body>
</html>