<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
		$(function () {
			getGoods(1);
		});
		//获取商品信息
		function getGoods(pageNum) {
			$.ajax({
				url:"${PATH}/manager/getGoods",
				type:"GET",
				data:"pageNum="+pageNum,
				success:function (data) {
					console.log(data);
					if (data.success === true){
						showMsg(data);
						page_info(data);
						page_nav(data);
					}
				}
			})
		}

		//显示商品信息
		function showMsg(data){
			//每次刷新清空表格数据
			$("tbody").empty();
			var goods = data.page.list;
			$.each(goods,function () {
				var checkBox = $("<td><input type='checkbox' class='check_item' ></td>");
				var goodId = $("<td></td>").append(this.goodId);
				var typeName = $("<td></td>").append(this.goodsType.typeName);
				var goodName = $("<td></td>").append(this.goodName);
				var price = $("<td></td>").append(this.price);
				var star = $("<td></td>").append(this.star);
				var total = $("<td></td>").append(this.total);
				var addTime = $("<td></td>").append(this.addTime);
				<%--var img = $("<img></img>").css({width:"60px",height:"100px"}).attr("src","${PATH}/"+this.image);--%>
				<%--var image = $("<td></td>").append(img);--%>
				//查看详情的按钮
				var check = $("<button></button>").addClass("btn btn-primary btn-sm check_btn")
						.append("<span></span>").addClass("glyphicon glyphicon-tasks");
				check.attr("good_id",this.goodId);
				//删除的按钮
				var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
						.append("<span></span>").addClass("glyphicon glyphicon-trash");
				var btn =$("<td></td>").append(check).append(" ").append(delBtn);
				delBtn.attr("good_id",this.goodId);
				$("<tr></tr>").append(checkBox).append(goodId).append(typeName).append(goodName)
						.append(price).append(star).append(total).append(addTime)
						.append(btn).appendTo($("tbody"));
			});
		}

		//显示分页信息
		function page_info(data) {
			$("#page_info").empty();
			var pageInfo = data.page;
			$("#page_info").append("当前"+ pageInfo.pageNum +"页,总共"+ pageInfo.pages +"页,总共"+ pageInfo.total +"条记录");
			//给全局变量赋值
			currentNum = pageInfo.pageNum;
		}

		//显示分页导航条
		function page_nav(data) {
			//清空数据
			$("#page_nav").empty();
			var ul = $("<ul></ul>").addClass("pagination");
			var first = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
			var prePage = $("<li></li>").append($("<a></a>").append("&laquo;"));
			ul.append(first).append(prePage);
			//判断是否有上一页，如果没有则不能点击
			if (data.page.hasPreviousPage === false){
				prePage.addClass("disabled");
				first.addClass("disabled");
			}else{
				prePage.click(function () {
					getGoods(data.page.pageNum - 1);
				});
				first.click(function () {
					getGoods(1);
				});
			}
			//显示每页的数字
			$.each(data.page.navigatepageNums,function (index,item) {
				var pages = $("<li></li>").append($("<a></a>").append(item));
				ul.append(pages);
				if (data.page.pageNum === item){
					pages.addClass("active");
				}else{
					pages.click(function () {
						getGoods(item);
					});
				}
			});
			var nextPage = $("<li></li>").append($("<a></a>").append("&raquo;"));
			var last = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
			ul.append(nextPage).append(last);
			//判断是否有下一页，如果没有则不能点击
			if (data.page.hasNextPage === false){
				nextPage.addClass("disabled");
				last.addClass("disabled");
			} else{
				nextPage.click(function () {
					getGoods(data.page.pageNum + 1);
				});
				last.click(function () {
					getGoods(data.page.pages);
				});
			}
			var nav = $("<nav></nav>").append(ul);
			nav.appendTo($("#page_nav"));
		}

		//给删除绑定单击事件，实现删除商品
		$(document).on("click",".delete_btn",function () {
			// alert("asdaf");
			//找到父级元素中的tr中的id,username
			var goodId = $(this).attr("good_id");
			var goodName = $(this).parents("tr").find("td:eq(3)").text();
			if (confirm("确认要删除【"+ goodName +"】吗？")){
				$.ajax({
					url:"${PATH}/manager/delGoods/"+goodId,
					type:"DELETE",
					success:function (data) {
						// map.put("exc","删除用户失败！请稍后再试！");
						console.log(data);
						if (data.success === true){
							//回到当前页
							getGoods(currentNum);
							commonUtil.message(data.msg);
						}else {
							commonUtil.message(data.msg,"danger");
						}
					}
				})
			}
		});

		$(function () {
			//选中不选中功能
			$("#check_all").click(function () {
				//attr获取checked是undefined
				//使用prop修改和读取
				// alert($(this).prop("checked"))
				$(".check_item").prop("checked",$(this).prop("checked"));
			});
			//给check_item添加点击事件,因为是后面添加的
			$(document).on("click",".check_item",function () {
				//判断当前选择中的元素
				var flag = $(".check_item:checked").length === $(".check_item").length;
				$("#check_all").prop("checked",flag);
			});
			//给批量删除绑定单击按钮
			$("#delBatch").click(function () {
				var goodName = "";
				var goodIds = "";
				//遍历选中的数据
				$.each($(".check_item:checked"),function () {
					// alert($(this).parents("tr").find("td:eq(1)").text())
					goodIds += $(this).parents("tr").find("td:eq(1)").text() + "-";
					// alert($(this).parents("tr").find("td:eq(3)").text())
					goodName += $(this).parents("tr").find("td:eq(3)").text()+",";
				});
				// alert(goodIds);
				//处理后面多余的	，和-
				goodIds = goodIds.substring(0,goodIds.length-1);
				goodName = goodName.substring(0,goodName.length-1);
				if (confirm("确认删除【"+ goodName +"】吗？")){
					$.ajax({
						url:"${PATH}/manager/delGoods/"+goodIds,
						type:"DELETE",
						success:function (data) {
							console.log(data);
							if (data.success === true){
								commonUtil.message(data.msg,"success");
								getGoods(currentNum);
							}else{
								commonUtil.message(data.msg,"danger");
								getGoods(currentNum);
							}
						}
					})
				}
			});
			//条件查询
			$("#search").click(function () {
				// alert($("#goodName").val());
				// alert($("#addTime").val());
				// var pageNum = 1;
				searchWithCondition(1);

			});

			//条件查询
			function searchWithCondition(pageNum){
				var goodName = $("#goodName").val();
				var typeName = $("#typeName").val();
				var condition = "";
				if (goodName !== "" && typeName !== "") {
					condition = goodName + "," + typeName;
				}else{
					condition = goodName + typeName;
				}
				$.ajax({
					url:"${PATH}/manager/searchGoods",
					type:"GET",
					data:"condition=" + condition+"&pageNum="+pageNum,
					success:function (data) {
						console.log(data);//每次刷新清空表格数据
						if (data.success ===true){
							showMsg(data);
							page_info1(data);
							page_nav2(data);
						}else {
							commonUtil.message(data.exc1,"danger");
						}
					}
				})
			}
			//显示分页信息
			function page_info1(data) {
				$("#page_info").empty();
				var pageInfo = data.page;
				$("#page_info").append("当前"+ pageInfo.pageNum +"页,总共"+ pageInfo.pages +"页,总共"+ pageInfo.total +"条记录");
				//给全局变量赋值
				currentNum = pageInfo.pageNum;
			}

			//显示分页导航条
			function page_nav2(data) {
				//清空数据
				$("#page_nav").empty();
				var ul = $("<ul></ul>").addClass("pagination");
				var first = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
				var prePage = $("<li></li>").append($("<a></a>").append("&laquo;"));
				ul.append(first).append(prePage);
				//判断是否有上一页，如果没有则不能点击
				if (data.page.hasPreviousPage === false){
					prePage.addClass("disabled");
					first.addClass("disabled");
				}else{
					prePage.click(function () {
						searchWithCondition(data.page.pageNum - 1);
					});
					first.click(function () {
						searchWithCondition(1);
					});
				}
				//显示每页的数字
				$.each(data.page.navigatepageNums,function (index,item) {
					var pages = $("<li></li>").append($("<a></a>").append(item));
					ul.append(pages);
					if (data.page.pageNum === item){
						pages.addClass("active");
					}else{
						pages.click(function () {
							searchWithCondition(item);
						});
					}
				});
				var nextPage = $("<li></li>").append($("<a></a>").append("&raquo;"));
				var last = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
				ul.append(nextPage).append(last);
				//判断是否有下一页，如果没有则不能点击
				if (data.page.hasNextPage === false){
					nextPage.addClass("disabled");
					last.addClass("disabled");
				} else{
					nextPage.click(function () {
						searchWithCondition(data.page.pageNum + 1);
					});
					last.click(function () {
						searchWithCondition(data.page.pages);
					});
				}
				var nav = $("<nav></nav>").append(ul);
				nav.appendTo($("#page_nav"));
			}

			//给check_btn绑定单击事件 查看商品的详细信息
			$(document).on("click",".check_btn",function () {
				var goodId = $(this).attr("good_id");
				$("#showGoods").modal({
					backdrop:"static"
				});
				$.ajax({
					url:"${PATH}/manager/getGoodsAndUpdate",
					type:"GET",
					data:"goodId=" + goodId,
					success:function (data) {
						console.log(data);
						if (data.success === true){
							$("#save").attr("good_id",data.goods.goodId);
							showImageAndDetail(data,$("#showImage"),
									$("#showDetail"),$("#price"),$("#total"),$("#star"));
						}else{
							commonUtil.message(data.msg,"danger");
						}
					}
				})
			});

			function showImageAndDetail(data,ele1,ele2,ele3,ele4,ele5){
				$(ele1).empty();
				$(ele2).empty();
				var goods = data.goods;
				var image = $("<img class='img-rounded'></img>").css({width:"230px",height:"230px"}).attr("src","${PATH}/"+goods.image);
				image.appendTo(ele1);
				var span = $("<span></span>").append(goods.detail);
				span.appendTo(ele2);

				$("#price").val(goods.price);
				$("#total").val(goods.total);
				$("#star").val(goods.star);
			}

			//给减号绑定单击事件
			$("#priceReduce").click(function () {
				if ($("#price").val() > 0) {
					var price = $("#price").val();
					price = price - 1;
					$("#price").val(price);
				}else {
					$("#price").val(0);
				}
			});
			$("#totalReduce").click(function () {
				if ($("#total").val() > 0) {
					var total = $("#total").val();
					total = total - 1;
					$("#total").val(total);
				}else {
					$("#total").val(0);
				}
			});
			$("#starReduce").click(function () {
				if ($("#star").val() > 0) {
					var star = $("#star").val();
					star = star - 1;
					$("#star").val(star);
				}else {
					$("#star").val(0);
				}
			});
			//给加号绑定单击事件
			$("#priceAdd").click(function () {
				if ($("#price").val() < 99999) {
					//转换为int整数
					var price = parseInt($("#price").val());
					price = price + 1;
					$("#price").val(price);
				}else {
					$("#price").val(99999);
				}
			});
			$("#totalAdd").click(function () {
				if ($("#total").val() < 99999) {
					var total = parseInt($("#total").val());
					total = total + 1;
					$("#total").val(total);
				}else {
					$("#total").val(99999);
				}
			});
			$("#starAdd").click(function () {
				if ($("#star").val() < 10) {
					var star = parseInt($("#star").val());
					star = star + 1;
					$("#star").val(star);
				}else {
					$("#star").val(10);
				}
			});

			//给保存添加单击事件
			$("#save").click(function () {
				var goodId = $("#save").attr("good_id");
				// alert(goodId);
				// alert($("form").serialize());
				$.ajax({
					url:"${PATH}/manager/updateGoods/"+goodId,
					type:"PUT",
					data:$("form").serialize(),
					success:function (data) {
						console.log(data);
						if (data.success === true){
							commonUtil.message(data.msg,"success");
							//关闭模态窗
							$('#showGoods').modal('hide');
							//回到当前页
							getGoods(currentNum);
						}else{
							commonUtil.message(data.msg,"danger");
						}
					}
				})
			});
		});
	</script>
<title>商品列表</title>
</head>
<body>
<%--商品信息的展示模态框--%>
<div class="modal fade" tabindex="-1" role="dialog" id="showGoods">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">商品的详细信息</h4>
			</div>
			<div class="modal-body">
				<div class="media">
					<div class="media-left media-middle">
						<a href="#" id="showImage">
						</a>
					</div>
					<div class="media-body">
						<form class="form-horizontal">
							<div class="form-group">
								<label class="col-sm-3 control-label">价格：</label>
								<div class="col-sm-6">
									<div class="input-group">
										 <span class="input-group-btn">
										   <button class="btn btn-default" type="button" id="priceReduce">-</button>
										 </span>
										<input type="text" class="form-control" name="price" id="price">
										 <span class="input-group-btn">
										   <button class="btn btn-default" type="button" id="priceAdd">+</button>
										 </span>
									</div>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-3 control-label">数量：</label>
								<div class="col-sm-6">
									<div class="input-group">
										 <span class="input-group-btn">
										   <button class="btn btn-default" type="button" id="totalReduce">-</button>
										 </span>
										<input type="text" class="form-control" name="total" id="total">
										<span class="input-group-btn">
										   <button class="btn btn-default" type="button" id="totalAdd">+</button>
										 </span>
									</div>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-3 control-label">评分：</label>
								<div class="col-sm-6">
									<div class="input-group">
										 <span class="input-group-btn">
										   <button class="btn btn-default" type="button" id="starReduce">-</button>
										 </span>
										<input type="text" class="form-control" name="star" id="star">
										<span class="input-group-btn">
										   <button class="btn btn-default" type="button" id="starAdd">+</button>
										 </span>
									</div>
								</div>
							</div>
						</form>
						<div class="panel-group col-md-6" id="accordion" role="tablist" aria-multiselectable="true">
							<div class="panel panel-default">
									<div class="panel-heading" role="tab" id="headingOne">
										<h4 class="panel-title" style="text-align: center">
											<a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="false" aria-controls="collapseOne">
												商品描述
											</a>
										</h4>
									</div>
									<div id="collapseOne" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
										<div class="panel-body" id="showDetail" style="word-wrap: break-word;word-break: break-all">

										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary" id="save">保存</button>
			</div>
		</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<div class="row" style="width:98%;margin-left: 1%;">
	<div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				商品列表
			</div>
			<div class="panel-body">
				<div class="row">
					<div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">
						<div class="form-group form-inline">
							<span>商品名称</span>
							<input type="text" name="goodName" id="goodName" class="form-control">
						</div>
					</div>
					<div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">
						<div class="form-group form-inline">
							<span>商品类型</span>
							<input type="text" name="typeName" id="typeName" class="form-control">
						</div>
					</div>
					<div class="col-xs-1 col-sm-1 col-md-1 col-lg-1">
						<button type="button" class="btn btn-primary" id="search"><span class="glyphicon glyphicon-search"></span></button>
					</div>
					<div class="col-xs-2 col-sm-2 col-md-2 col-lg-2" style="margin-left: 50px">
						<button type="button" class="btn btn-danger" id="delBatch"><span class="glyphicon glyphicon-trash">批量删除</span></button>
					</div>
				</div>
				<div style="height: 400px;overflow: scroll;">
					<table id="tb_list" class="table table-striped table-hover table-bordered">
						<thead >
							<tr>
								<th style="text-align: center"><input type="checkbox" id="check_all"/></th>
								<th style="text-align: center">#</th>
								<th style="text-align: center">类型</th>
								<th style="text-align: center">商品名称</th>
								<th style="text-align: center">价格</th>
								<th style="text-align: center">评分</th>
								<th style="text-align: center">数量</th>
								<th style="text-align: center">上架时间</th>
								<%--<td>图片</td>--%>
								<th style="text-align: center">操作</th>
							</tr>
						</thead>
						<tbody style="text-align: center">

						</tbody>
					</table>
					<div class="row" id="page">
						<div class="col-md-6" id="page_info">
							<%--当前页,总共页,总条记录--%>
						</div>
						<div class="col-md-6" id="page_nav" style="float: right;margin-right: 100px;">

						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>