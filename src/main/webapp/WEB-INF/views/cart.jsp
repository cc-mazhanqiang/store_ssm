<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<%
		pageContext.setAttribute("PATH",request.getContextPath());
	%>
	<title>xyz-购物车</title>
	<link href="${PATH}/static/bootstrap-3.4.1-dist/css/bootstrap.min.css" rel="stylesheet"/>
	<link rel="stylesheet" href="${PATH}/static/bootstrap-3.4.1-dist/css/main.css"/>
	<script type="text/javascript" src="${PATH}/static/js/jquery-3.3.1.js"></script>
	<script type="text/javascript" src="${PATH}/static/js/js/jquery.min.js"></script>
	<script type="text/javascript">
		$(function(){
			$('#con').load('head');
			$("#con1").load('foot');
			getCart();
		});

		function getCart() {
			$.ajax({
				url:"${PATH}/views/getCart",
				type:"GET",
				success:function (data) {
					console.log(data);
					if (data.success === true){
						showCarts(data);
					}else{
						commonUtil.alert(data.msg,"danger");
					}
				}
			})
		}

		function showCarts(data) {
			$("#cartGoods").empty();
			var carts = data.cartList;
			var total = 0;
			var all = "";
			$.each(carts,function () {
				var tr = $("<tr></tr>");
				var cartId = $("<td style='text-align: center'></td>").append(this.cartId);
				var goodName = $("<td style='text-align: center'></td>").append(this.goodName);
				var tdDiv = $("<td width='100px' style='text-align: center'></td>");
				var div = $("<div class='input-group'></div>");
				var span1 = $("<span class='input-group-btn'></span>").append($("<button type='button' class='btn btn-default reduce_btn'></button>").attr("cart_id",this.cartId).append("-"));
				var input = $("<input type='text' class='form-control inputCount' readonly='readonly' style='margin-top: 0px;width: 50px'></input>").val(this.count);
				var span2 = $("<span class='input-group-btn'></span>").append($("<button type='button' class='btn btn-default add_btn'></button>").attr("cart_id",this.cartId).append("+"));
				var price = $("<td style='text-align: center'></td>").append($("<span class='glyphicon glyphicon-yen'></span>")).append(this.price).append("元");
				var all = (this.count * this.price).toFixed(2);
				var countPrice = $("<td style='text-align: center'></td>").append(all);
				var del_btn = $("<td></td>").append($("<button type='button' class='btn btn-primary del_btn'></button>").attr("cart_id",this.cartId).append("删除"));
				div.append(span1).append(input).append(span2);
				tdDiv.append(div);
				tr.append(cartId).append(goodName).append(price).append(tdDiv).append(countPrice)
						.append(del_btn);
				tr.appendTo($("#cartGoods"));
			});
			//显示总金额
			$("#total").empty();
			$.each(carts,function () {
				var all = (this.count * this.price).toFixed(2);
				total += parseFloat(all);
			});
			var totalPrice = $("<b></b>").append($("<span class='glyphicon glyphicon-yen'></span>").append(total).append("元"));
			totalPrice.appendTo($("#total"));
		}

		//给减号绑定单击事件
		$(document).on("click",".reduce_btn",function () {
			if ($(this).parent("span").parent("div").parent("td").find("input").val() > 1){
				//需要寻找顶级父元素
				var count = $(this).parent("span").parent("div").parent("td").find("input").val();
				count = count - 1;
				$(this).parent("span").parent("div").parent("td").find("input").val(count);
				var cartId = $(this).attr("cart_id");
				//发送ajax请求更新数据
				$.ajax({
					url:"${PATH}/views/reduceCartData",
					type:"POST",
					data:"cartId="+cartId,
					success:function (data) {
						console.log(data);
						if (data.success === true){
							getCart();
						}else{
							commonUtil.message(data.msg,"danger");
						}
					}
				})
			}else{
				$(this).parent("span").parent("div").parent("td").find("input").val(1);
			}
		});
		//给加号绑定单击事件
		$(document).on("click",".add_btn",function () {
			//99999这个数量应该能满足大部分需求
			if ($(this).parent("span").parent("div").parent("td").find("input").val() < 99999){
				//需要寻找顶级父元素
				var count = parseInt($(this).parent("span").parent("div").parent("td").find("input").val());
				count = count + 1;
				$(this).parent("span").parent("div").parent("td").find("input").val(count);
				var cartId = $(this).attr("cart_id");
				//发送ajax请求更新数据
				$.ajax({
					url:"${PATH}/views/addCartData",
					type:"POST",
					data:"cartId="+cartId,
					success:function (data) {
						console.log(data);
						if (data.success === true){
							getCart();
						}else{
							commonUtil.message(data.msg,"danger");
						}
					}
				})
			}else {
				$(this).parent("span").parent("div").parent("td").find("input").val(99999);
			}
		});

		$(function () {
			$("#removeAllCart").click(function () {
				if (confirm("您还没有结算商品，确定要清空购物车吗？")){
					$.ajax({
						url:"${PATH}/views/removeAllCart",
						type:"POST",
						success:function (data) {
							console.log(data);
							if (data.success === true){
								commonUtil.message(data.msg,"success");
								$("#cartGoods").empty();
								$("#total").empty();
							}else{
								commonUtil.message(data.msg,"danger");
							}
						}
					})
				}
			});
			//给删除绑定单击事件
			$(document).on("click",".del_btn",function () {
				var cartId = $(this).attr("cart_id");
				var goodName = $(this).parents("tr").find("td:eq(1)").text();
				if (confirm("您确定要删除【"+goodName+"】商品吗？")){
					$.ajax({
						url:"${PATH}/views/delCartById",
						type:"POST",
						data:"cartId="+cartId,
						success:function (data) {
							console.log(data);
							if (data.success === true){
								commonUtil.message(data.msg,"success");
								getCart();
								$("#cartGoods").empty();
							}else{
								commonUtil.message(data.msg,"danger")
							}
						}
					})
				}
			});
			//给结算绑定单击事件
			$("#checkMoney").click(function () {
				var totalPrice = $("#total").text();
				if (confirm("总金额为：" + totalPrice + ",是否结算购物车？")){
					$.ajax({
						url:"${PATH}/views/accounts",
						type:"GET",
						success:function (data) {
							console.log(data);
							if (data.success === true){
								//清空购物车
								$("#cartGoods").empty();
								//清空总金额
								$("#total").empty();
								commonUtil.message(data.msg,"success");
							}else{
								commonUtil.message(data.msg,"danger");
							}
						}
					})
				}
			});
		});


	</script>
	<script type="text/javascript" src="${PATH}/static/bootstrap-3.4.1-dist/js/bootstrap.js"></script>
</head>
<body style="background-color:#f5f5f5">
<div id="con"></div>
<div class="container" style="background-color: white;">
	<div class="row" style="margin-left: 40px">
		<h3>我的购物车<small>温馨提示：产品是否购买成功，以最终下单为准哦，请尽快结算</small></h3>
	</div>
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
						<th style="text-align: center">操作</th>
					</tr>
 				</thead>
				<tbody id="cartGoods">
				</tbody>
			</table>
		</div>
	</div>
	<hr>
	<div class="row">
		<div class="pull-right" style="margin-right: 40px;">	
	            <div>
	            	<a id="removeAllCart" class="btn btn-default btn-lg">清空购物车</a>
	            	&nbsp;&nbsp;
	            	<a id="checkMoney" class="btn  btn-danger btn-lg">结算</a>
	            </div>
	            <br/>
	            <br/>
	            <div>
					商品金额总计：<span id="total" class="text-danger"></span>
	            </div>
		</div>
	</div>
</div>
<!-- 底部 -->
<div id="con1"></div>
</body>
</html>