<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>订单管理</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
	<%
		pageContext.setAttribute("PATH",request.getContextPath());
	%>
	<link href="${PATH}/static/bootstrap-3.4.1-dist/css/bootstrap.min.css" rel="stylesheet"/>
	<script type="text/javascript" src="${PATH}/static/js/jquery-3.3.1.js"></script>
	<script type="text/javascript" src="${PATH}/static/bootstrap-3.4.1-dist/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="${PATH}/static/js/utils.js"></script>
	<script type="text/javascript">
	$(function(){
		//发送ajax请求获取订单
		getAllOrders();
		//给发货按钮绑定单击事件
		$(document).on("click",".send_btn",function () {
			var orderNum = $(this).attr("order_num");
			$.ajax({
				url:"${PATH}/manager/sendOrders",
				type:"POST",
				data:"orderNum="+orderNum,
				success:function (data) {
					console.log(data);
					if (data.success === true){
						commonUtil.message(data.msg,"success");
                        getAllOrders();
					}else{
						commonUtil.message(data.msg,"danger");
					}
				}
			})
		});
		//给搜索绑定单击事件
		$("#search").click(function () {
			var type = $("option:selected").attr("value");
			$.ajax({
				url:"${PATH}/manager/searchOrderStatus",
				type:"GET",
				data:"type="+type,
				success:function (data) {
					console.log(data);
					if (data.success === true){
						commonUtil.message(data.msg,"success");
						showAllOrders(data);
					}else{
						commonUtil.message(data.msg,"danger");
					}
				}
			})
		});
	});
	function getAllOrders() {
		$.ajax({
			url:"${PATH}/manager/showAllOrders",
			type:"GET",
			success:function (data) {
				console.log(data);
				if (data.success === true){
					showAllOrders(data);
				}
			}
		});
	}
	function showAllOrders(data) {
		$("#showAllOrders").empty();
		var orders = data.orderList;
		$.each(orders,function () {
			var tr = $("<tr></tr>");
			var orderNum = $("<td style='text-align: center'></td>").append(this.orderNum);
			var price = $("<td  style='text-align: center'></td>").append((this.price).toFixed(2)).append("元");
			var time = "";
			$.each(data.dateList,function () {
				time = $("<td style='text-align: center'></td>").append(this.time);
			});
			var username = $("<td style='text-align: center'></td>").append(this.viewsUser.username);
			var send = $("<td style='text-align: center'></td>").append($("<button class='btn btn-primary btn-sm send_btn'></button>").attr("order_num",this.orderNum).append("发货"));
			var orderStatus = "";
			if (this.orderStatus === "待商家发货"){
				orderStatus = $("<td  style='text-align: center'></td>").append("买家已支付，等待发货...");
				tr.append(orderNum).append(price).append(orderStatus).append(time).append(username).append(send);
			}else if (this.orderStatus === "待提交订单") {
				orderStatus = $("<td  style='text-align: center'></td>").append("买家未支付...");
				tr.append(orderNum).append(price).append(orderStatus).append(time).append(username);
			}else {
				orderStatus = $("<td  style='text-align: center'></td>").append("已发货");
				tr.append(orderNum).append(price).append(orderStatus).append(time).append(username);
			}
			tr.appendTo("#showAllOrders");
		})
	}
</script>
</head>
<body>
<div class="row" style="width:98%;margin-left: 1%;margin-top: 5px;">
	<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				订单管理
			</div>
			<div class="panel-body">
				<div class="row">
					<div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">
						<div class="form-group form-inline">
							<span>订单状态</span>
							<select name="orderStatus" class="form-control">
								<option value="0">查询所有的订单</option>
								<option value="1">买家已支付，等待发货...</option>
								<option value="2">买家未支付...</option>
								<option value="3">已发货</option>
							</select>
						</div>
					</div>
					<div class="col-xs-1 col-sm-1 col-md-1 col-lg-1">
						<button type="button" class="btn btn-primary" id="search"><span class="glyphicon glyphicon-search"></span></button>
					</div>
				</div>
				<table id="tb_list" class="table table-striped table-hover table-bordered table-condensed">
					<thead>
						<tr>
							<th style='text-align: center'>订单编号</th>
							<th style='text-align: center'>总金额</th>
							<th style='text-align: center'>订单状态</th>
							<th style='text-align: center'>订单时间</th>
							<th style='text-align: center'>用户姓名</th>
							<th style='text-align: center'>操作</th>
						</tr>
					</thead>
					<tbody id="showAllOrders">

					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
</body>
</html>