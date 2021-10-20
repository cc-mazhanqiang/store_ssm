<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>xyz-订单预览</title>
	<%
		pageContext.setAttribute("PATH",request.getContextPath());
	%>
	<link href="${PATH}/static/bootstrap-3.4.1-dist/css/bootstrap.min.css" rel="stylesheet"/>
	<link rel="stylesheet" href="${PATH}/static/bootstrap-3.4.1-dist/css/main.css"/>
	<script type="text/javascript" src="${PATH}/static/js/jquery-3.3.1.js"></script>
	<script type="text/javascript" src="${PATH}/static/js/js/jquery.min.js"></script>
	<script type="text/javascript" src="${PATH}/static/bootstrap-3.4.1-dist/js/bootstrap.js"></script>
	<script type="text/javascript" src="${PATH}/static/js/viewUtils.js"></script>
	<script type="text/javascript">
		$(document).ready(function(){
			$('#con').load('head');
			$("#con1").load('foot');
			getAddress();
			getOrder();
			//给提交订单绑定单击事件
			$("#subOrder").click(function () {
				$('#payModal').modal({
					backdrop:"static"
				});
			});
			//给模态框确定绑定单击事件
			$("#payBtn").click(function () {
				var addrId = $("option:selected").attr("addr_id");
                    $.ajax({
                    url:"${PATH}/views/submitOrder",
                    type:"POST",
                    data:"addrId="+addrId,
                    success:function (data) {
                        console.log(data);
                        if (data.success === true){
                            $("#payModal").modal('hide');
                            commonUtil.message(data.msg,"success");
                            $("#total").empty();
                            getOrder();
                        }else {
                            commonUtil.message(data.msg,"danger");
                        }
                    }
                })
			});
		});

		//判断按钮是否可以点击
		function judgeBtn() {
			alert($(".total").text())
			if ($(".total").text() === "0元"){
				alert("AF");
				$("#subOrder").attr("disabled",true);
			}else {
				$("#subOrder").attr("disabled",false);
			}
		}

		function getOrder() {
			$.ajax({
				url:"${PATH}/views/findOrder",
				type:"GET",
				success:function (data) {
					console.log(data);
					if (data.success === true){
						showOrder(data)
					}else {
						commonUtil.alert(data.msg,"danger");
					}
				}
			})
		}
		function showOrder(data) {
			$("#showOrder").empty();
			var orders = data.order;
			var total = 0;
			$.each(orders,function () {
				var tr = $("<tr></tr>");
				var orderNum = $("<td style='text-align: center'></td>").append(this.orderNum);
				var goodName = $("<td style='text-align: center'></td>").append(this.goodName);
				var price = $("<td style='text-align: center'></td>").append($("<span class='glyphicon glyphicon-yen'></span>")).append(this.price).append("元");
				var count = $("<td style='text-align: center'></td>").append(this.count);
				var all = (this.count * this.price).toFixed(2);
				var countPrice = $("<td style='text-align: center'></td>").append(all);
				var orderStatus = $("<td style='text-align: center'></td>").append(this.orderStatus);
				tr.append(orderNum).append(goodName).append(price).append(count).append(countPrice)
						.append(orderStatus);
				tr.appendTo($("#showOrder"));
			});
			//显示总金额
			var totalPrice = "";
			var modalPayPrice = "";
			$.each(orders,function () {
				if (this.orderStatus === "待提交订单") {
					$(".total").empty();
					var pr = this.count * this.price;
					total += parseFloat(pr);
					totalPrice = $("<b></b>").append($("<span class='glyphicon glyphicon-yen total'></span>").append(total.toFixed(2)).append("元"));
					modalPayPrice = $("<b></b>").append($("<span class='glyphicon glyphicon-yen'></span>").append(total.toFixed(2)).append("元"));
				}else if (this.orderStatus === "待商家发货") {
					$(".total").empty();
					totalPrice = $("<b></b>").append($("<span class='glyphicon glyphicon-yen total'></span>").append(0).append("元"));
					modalPayPrice = $("<b></b>").append($("<span class='glyphicon glyphicon-yen'></span>").append(0).append("元"));
				}else {
					$(".total").empty();
					totalPrice = $("<b></b>").append($("<span class='glyphicon glyphicon-yen total'></span>").append(0).append("元"));
					modalPayPrice = $("<b></b>").append($("<span class='glyphicon glyphicon-yen'></span>").append(0).append("元"));
				}
			});
			totalPrice.appendTo($("#total"));
			modalPayPrice.appendTo($(".payPrice"));
			if ($(".total").text() === "0元"){
				$("#subOrder").attr("disabled",true);
			}else {
				$("#subOrder").attr("disabled",false);
			}
		}
		function getAddress() {
			$.ajax({
				url:"${PATH}/views/getAddressName",
				type:"GET",
				success:function (data) {
					console.log(data);
					$.each(data.addressList,function (){
						var options = $("<option></option>").append(this.address).attr("addr_id",this.id);
						if (this.status === 1){
							var options = $("<option selected='selected'></option>").append(this.address).attr("addr_id",this.id);
						}
						options.appendTo("#addressName");
					})
				}
			})
		}
	</script>
</head>
<body style="background-color:#f5f5f5">
<div id="con"></div>
<%--付款二维码--%>
<div class="modal fade" tabindex="-1" role="dialog" id="payModal">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title payPrice" style="color: orangered;text-align: center">总金额：</h4>
			</div>
			<div class="modal-body">
				<img src="${PATH}/static/image/pay.jpg" width="476" height="334" alt="" style="margin-left: 50px"/>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary" id="payBtn">已支付</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<div class="container" style="background-color: white;">
	<div class="row" style="margin-left: 40px">
		<h3>订单预览<small>温馨提示：请添加你要邮递到的地址</small></h3>
		<h4 style="margin-left: 55px;color: orange">收货地址</h4>
		<select name="aid" style="width:30%;margin-left: 55px" id="addressName" class="form-control">
		</select>
	</div>
	<form>
	<div class="row" style="margin-top: 40px;">
		<div class="col-md-10 col-md-offset-1">
			<table class="table table-bordered table-striped table-hover">
				<thead>
					<tr>
						<th style="text-align: center">序号</th>
						<th style="text-align: center">商品名称</th>
						<th style="text-align: center">价格</th>
						<th style="text-align: center">数量</th>
						<th style="text-align: center">小计</th>
						<th style="text-align: center">订单状态</th>
					</tr>
				</thead>
				<tbody id="showOrder">

				</tbody>
			</table>
		</div>
		
	</div>
	<hr>
	<div class="row">
		<div style="margin-left: 40px;">	  
	            <h4>商品金额总计：<span id="total" class="text-danger"></span></h4>
		</div>
	</div>
	<div class="row pull-right" style="margin-right: 40px;">
		 <div style="margin-bottom: 20px;">
	            <button type="button" id="subOrder" class="btn btn-danger btn-lg">提交订单</button>
	     </div>
	</div>
	</form>
</div>
<!-- 底部 -->
<div id="con1"></div>
</body>
</html>