<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<%
		pageContext.setAttribute("PATH",request.getContextPath());
	%>
	<link href="${PATH}/static/bootstrap-3.4.1-dist/css/bootstrap.min.css" rel="stylesheet"/>
	<link rel="stylesheet" href="${PATH}/static/bootstrap-3.4.1-dist/css/main.css"/>
	<script type="text/javascript" src="${PATH}/static/js/jquery-3.3.1.js"></script>
	<script type="text/javascript" src="${PATH}/static/js/js/jquery.min.js"></script>
	<script type="text/javascript" src="${PATH}/static/bootstrap-3.4.1-dist/js/bootstrap.js"></script>
	<title>xyz-商品详情页</title>
	<script type="text/javascript">
		$(document).ready(function(){
			$('#con').load('head');
			$("#con1").load('foot')
		})
	</script>
</head>
<body>
<div id="con"></div>
	<div style="margin: 0 auto; width: 90%;">
		<ol class="breadcrumb">
			<li><a href="#">古月购物网网</a></li>
			<li class="active"><a
				href="getGoodsListByTn?tn=${goods.typeName}">${goods.typeName}</a></li>
		</ol>
	</div>
	<div class="container">
		<div class="row">
			<div class="col-xs-6 col-md-6">
				<a href="#" class="thumbnail"> <img
					src="./fmwimages/${goods.picture}" width="560" height="560"
					alt="${goods.name}" />
				</a>
			</div>
			<div class="col-xs-6 col-md-6">
				<div class="panel panel-default" style="height: 560px">
					<div class="panel-heading">商品详情</div>
					<div class="panel-body">
						<h3>
							产品名称:<small>${goods.name}</small>
						</h3>
						<div style="margin-left: 10px;">

							<p>
								市场价格:&nbsp;&nbsp;&nbsp;<span class="text-danger"
									style="font-size: 15px;">${goods.price}</span>&nbsp;&nbsp;&nbsp;<span
									class="glyphicon glyphicon-yen"></span>
							</p>
							<p>上市时间:&nbsp;&nbsp;&nbsp;${goods.pubdate}</p>
							<p>
								热销指数:&nbsp;&nbsp;&nbsp;
								<c:forEach begin="1" end="${goods.star}">
									<img src="image/star_red.gif" alt="star" />
								</c:forEach>
							</p>
							<p>详细介绍:</p>
							<p>&nbsp;&nbsp;${goods.intro }</p>
							<a
								href="${pageContext.request.contextPath}/addCart?gid=${goods.id}&price=${goods.price}"
								class="btn btn-warning">加入购物车&nbsp;&nbsp;&nbsp;<span
								class="glyphicon glyphicon-shopping-cart"></span></a>&nbsp;&nbsp;&nbsp;
							<a
								href="${pageContext.request.contextPath}/getDirectOrder?id=${goods.id}&price=${goods.price}&name=${goods.name}"
								class="btn btn-warning">直接购买&nbsp;&nbsp;&nbsp;<span
								class="glyphicon glyphicon-shopping-cart"></span></a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 底部 -->
<div id="con2"></div>
</body>
</html>