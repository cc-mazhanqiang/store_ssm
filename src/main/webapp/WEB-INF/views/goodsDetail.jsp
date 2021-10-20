<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
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
	<script type="text/javascript" src="${PATH}/static/js/viewUtils.js"></script>
	<title>xyz-商品详情页</title>
	<script type="text/javascript">
		$(function(){
			$('#con').load('head');
			$("#con1").load('foot');
		});
		$(function () {
			//给加入购物车绑定单击事件
			$("#addCart").click(function () {
				var goodId = $("#addCart").attr("goodId");
				// alert(goodId)
				$.ajax({
					url:"${PATH}/views/addCart",
					type:"GET",
					data:"goodId="+goodId,
					success:function (data) {
						console.log(data);
						if (data.success === true){
							//重新发送请求
							setTimeout("location.reload()",1000);
							commonUtil.message(data.msg,"success");
						}else {
							commonUtil.message(data.msg,"danger");
						}
					}
				})
			});
		});

	</script>
</head>
<body>
<div id="con"></div>
	<div style="margin: 0 auto; width: 90%;">
		<ol class="breadcrumb">
			<li><a href="${PATH}/views/index">xyz购物网</a></li>
			<li class="active"><a href="#">${goods.goodName}</a></li>
		</ol>
	</div>
	<div class="container">
		<div class="row">
			<div class="col-xs-6 col-md-6">
				<a href="#" class="thumbnail"> <img
					src="${PATH}/${goods.image}" width="560" height="560"
					alt="${goods.goodName}" />
				</a>
			</div>
			<div class="col-xs-6 col-md-6">
				<div class="panel panel-default" style="height: 560px">
					<div class="panel-heading">商品详情</div>
					<div class="panel-body">
						<h3>
							产品名称:<small>${goods.goodName}</small>
						</h3>
						<div style="margin-left: 10px;">

							<p>
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;余量：<span style="color: orange">${goods.total}</span>
							</p>
							<p>
								市场价格:&nbsp;&nbsp;&nbsp;<span class="text-danger"
									style="font-size: 15px;">${goods.price}</span>&nbsp;&nbsp;&nbsp;<span
									class="glyphicon glyphicon-yen"></span>
							</p>
							<p>上市时间:&nbsp;&nbsp;&nbsp;${goods.addTime}</p>
							<p>
								热销指数:&nbsp;&nbsp;&nbsp;
								<c:forEach begin="1" end="${goods.star}">
									<img src="${PATH}/static/image/star_red.gif" alt="star" />
								</c:forEach>
							</p>
							<p>详细介绍:</p>
							<p>&nbsp;&nbsp;${goods.detail }</p>
							<a	id="addCart" goodId="${goods.goodId}"
								class="btn btn-warning">加入购物车&nbsp;&nbsp;&nbsp;<span
								class="glyphicon glyphicon-shopping-cart"></span></a>&nbsp;&nbsp;&nbsp;
							<%--<a--%>
								<%--href="${pageContext.request.contextPath}/getDirectOrder?id=${goods.goodId}&price=${goods.price}&name=${goods.goodName}"--%>
								<%--class="btn btn-warning">直接购买&nbsp;&nbsp;&nbsp;<span--%>
								<%--class="glyphicon glyphicon-shopping-cart"></span></a>--%>
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