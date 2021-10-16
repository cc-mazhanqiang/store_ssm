<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="utf-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
			//查询商品的种类显示在下拉菜单中
			//清空下拉菜单中的数据
			$("#typeName").empty();
			//发送ajax请求获取部门信息
			$.ajax({
				url:"${PATH}/manager/getGoodsTypeName",
				type:"GET",
				success:function (data) {
					console.log(data);
					if (data.success === true){
						// console.log(data.goodsType[0].typeName);
						//遍历请求获得的数据
						//index:表示当前的索引，item表示遍历的对象,如果不传参数的话：
						//可以使用this：表示当前遍历的对象：data.goodsType。
						$.each(data.goodsType,function (){
							var options = ($("<option></option>")).append(this.typeName).attr("value",this.typeId);
							options.appendTo("#typeName");
						})
					}else{
						commonUtil.alert(data.msg,"danger");
					}
				}
			});

			//给添加按钮绑定单击事件
			$("#add_btn").click(function () {
				//校验表单
				var flag = true;
				var tag = true;
				if ($("#img").get(0).files[0] === undefined){
					commonUtil.message("您还没有选择要上传的图片哟！","danger");
					flag = false;
					return false;
				}
				if (flag){
					var formItem = $("#addGoodsForm").serializeArray();
					$.each(formItem,function (index,item) {
						if ( item['value'] === ""){
							commonUtil.message("您还没有填写完内容哟！","danger");
							tag = false;
						}
					});
				}
				if (tag){
					var price = $("#price").val();
					//1-99999
					var regPrice = /^[1-9]\d*(.\d{1,2})?$/;
					if (!regPrice.test(price)) {
						commonUtil.message("您输入的价格不合法哟！","danger");
						return false;
					}
					var star = $("#star").val();
					//1-10
					var regStar = /^([1-9]|10)$/;
					if (!regStar.test(star)) {
						commonUtil.message("您输入的评分不合法哟！","danger");
						return false;
					}
					var total = $("#total").val();
					//1-99999
					var regTotal = /^[0-9]{1,5}$/;
					if (!regTotal.test(total)) {
						commonUtil.message("您输入的数量不合法哟！","danger");
						return false;
					}
				}

				if (tag){
					var formData = new FormData();
					formData.append("goodName",$("#goodName").val());
					// alert($("#addGoodsForm").find("option:selected").val())
					formData.append("typeId",$("#addGoodsForm").find("option:selected").val());
					formData.append("addTime",$("#addTime").val());
					formData.append("price",$("#price").val());
					formData.append("star",$("#star").val());
					formData.append("total",$("#total").val());
					formData.append("img", $("#img")[0].files[0]);
					formData.append("detail",$("#detail").val());
					$.ajax({
						url:"${PATH}/manager/addGoods",
						type:"POST",
						data:formData,
						cache:false,//上传文件不需要缓存
						processData:false,//不去处理发送的数据
						contentType:false,//不去设置Content-Type请求头
						success:function (data) {
							console.log(data);
							if (data.success === true){
								commonUtil.message(data.msg,"success");
								//清空表单数据
								$("#addGoodsForm input").not(":button, :reset").val("");
								$("#detail").val("");
							}else{
								commonUtil.message(data.msg,"danger");
								$("#addGoodsForm input").not(":button, :reset").val("");
								$("#detail").val("");
							}
						}
					})
				}
			});
		});
	</script>
<title>商品添加</title>
</head>
<body>
	<div class="row" style="margin-left: 20px;">
		<form enctype="multipart/form-data" id="addGoodsForm">
			<div>
				<h3>新增商品</h3>
			</div>
			<hr />
			<div class="row">
				<div class="col-sm-6">
					<div class="form-group form-inline">
						<label>名称:</label>
						<input type="text" name="goodName" id="goodName" class="form-control" />
					</div>
					<div class="form-group form-inline">
						<label>分类:</label>
						<select name="typeName" id="typeName" class="form-control">

						</select>
					</div>
					<div class="form-group form-inline">
						<label>时间:</label>
						<input type="date" name="addTime" id="addTime" class="form-control"/>
					</div>
				</div>
				<div class="col-sm-6">
					<div class="form-group form-inline">
						<label>价格:</label>
						<input type="text" name="price" id="price" class="form-control" /> 元
					</div>
					<div class="form-group form-inline">
						<label>评分:</label>
						<input type="text" name="star" id="star" class="form-control" />
					</div>
					<div class="form-group form-inline">
						<label>数量:</label>
						<input type="text" name="star" id="total" class="form-control" />
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-10">
					<div class="form-group form-inline">
						<label>商品图片</label>
						<input type="file" name="image" id="img" />
					</div>
					<div class="form-group ">
						<label>商品简介</label>
						<textarea  name="detail" id="detail" class="form-control" rows="5"></textarea>
					</div>
					<div class="form-group form-inline">
						<input type="button" id="add_btn" value="添加" class="btn btn-primary" />
						<input type="reset" value="重置" class="btn btn-default" />
					</div>
				</div>
			</div>
		</form>
	</div>
</body>
</html>