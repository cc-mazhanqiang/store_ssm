<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
	<%
		pageContext.setAttribute("PATH",request.getContextPath());
	%>
	<link href="${PATH}/static/bootstrap-3.4.1-dist/css/bootstrap.min.css" rel="stylesheet"/>
	<script type="text/javascript" src="${PATH}/static/js/jquery-3.3.1.js"></script>
	<script type="text/javascript" src="${PATH}/static/bootstrap-3.4.1-dist/js/bootstrap.min.js"></script>
<title>XYZ-后台主页</title>
<style>
@media ( min-width :768px ) {
	#left_tab {
		width: 250px;
		position: absolute;
		z-index: 1;
		height: 640px;
	}
	.mysearch {
		margin: 10px;
	}
	.page_main {
		margin-left: 255px;
	}
	.dv_content{
		width: 100%;
		height: 500px;
	}
}
</style>
</head>
<body>
	<!--导航 -->
	<div style="width: 80%;margin-left: 10%;">
		<nav class="navbar navbar-default navbar-static-top">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#left_tab,#top_right">
				<span class="icon-bar"></span> 
				<span class="icon-bar"></span> 
				<span class="icon-bar"></span>
			</button>
			<a href="#" class="navbar-brand">网站后台管理</a>
		</div>
		<ul id="top_right" class="collapse navbar-collapse nav navbar-nav navbar-right"	style="margin-right: 20px;">
			<li>
				<a href="#">
					<span class="badge"	style="background-color: red;"></span>
				</a>
			</li>
			<li>
				<a href="${PATH}/manager/adminLoginOut">
					<span class="glyphicon glyphicon-off"></span>注销
				</a>
			</li>
		</ul>
		<!--左侧边栏 -->
		<div id="left_tab" style="margin-top: 70px;" class="collapse navbar-default navbar-collapse">
			<ul class="nav panel-group" id="myPanel" style="margin-bottom: 0">
				<!--栏目-->
				<li class="panel" style="margin-bottom: 20px">
					<a href="#sub1" data-toggle="collapse" data-parent="#myPanel"> 用户管理
						<span class="glyphicon glyphicon-triangle-bottom pull-right"></span>
					</a>
					<ul id="sub1" class="nav collapse panel-collapse">
						<li>
							<a href="#" id="showUser"> 
								<span class="glyphicon glyphicon-user"></span>&nbsp;&nbsp;<b>会员管理</b>
							</a>
						</li>
					</ul>
				</li>
				<li class="panel" style="margin-bottom: 20px">
					<a href="#sub2" data-toggle="collapse" data-parent="#myPanel"> 商品类型管理
						<span class="glyphicon glyphicon-triangle-bottom pull-right"></span>
					</a>
					<ul id="sub2" class="nav panel-collapse collapse">
						<li>
							<a href="#" id="addGoodsType">
								<span class="glyphicon glyphicon-plus"></span>&nbsp;&nbsp;添加商品分类
							</a>
						</li>
					</ul>
				</li>
				<li class="panel" style="margin-bottom: 20px">
					<a href="#sub3" data-toggle="collapse" data-parent="#myPanel"> 商品管理
						<span class="glyphicon glyphicon-triangle-bottom pull-right"></span>
					</a>
					<ul id="sub3" class="nav panel-collapse collapse">
						<li>
							<a href="#" id="showGoods" > 
								<span class="glyphicon glyphicon-record"></span>&nbsp;&nbsp;查看商品
							</a>
						</li>
						<li>
							<a href="#" id="addGoods"> 
								<span class="glyphicon glyphicon-plus"></span>&nbsp;&nbsp;添加商品
							</a>
						</li>
					</ul>
				</li>
				<li class="panel" style="margin-bottom: 20px">
					<a href="#sub4" data-toggle="collapse" data-parent="#myPanel"> 订单管理
						<span class="glyphicon glyphicon-triangle-bottom pull-right"></span>
					</a>
					<ul id="sub4" class="nav panel-collapse collapse">
						<li>
							<a href="#" id="showOrder"> 
								<span class="glyphicon glyphicon-record"></span>&nbsp;&nbsp;查看订单
							</a>
						</li>
					</ul>
				</li>
			</ul>
		</div>
		</nav>
		<!--右侧部分-->
		<div class="page_main">
			<script type="text/javascript">
				$("#showUser").click(function(){
					$(".dv_content").attr("src","${PATH}/manager/userList");
				});
				$("#addGoodsType").click(function(){
					$(".dv_content").attr("src","${PATH}/manager/addGoodsType");
				});
				$("#showGoods").click(function(){
					$(".dv_content").attr("src","${PATH}/manager/showGoods");
				});
				$("#addGoods").click(function(){
					$(".dv_content").attr("src","${PATH}/manager/addGoods");
				});
				$("#showOrder").click(function(){
					$(".dv_content").attr("src","${PATH}/manager/showAllOrder");
				});
			</script>
			<iframe class="dv_content" frameborder="0" scrolling="no"></iframe>
		</div>
	</div>
</body>
</html>