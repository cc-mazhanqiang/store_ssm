<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
			$("#add_btn").click(function () {
				var typeName = $("#inputType").val();
				var regInput = /^[\u2E80-\u9FFF]+$/;
				if (!regInput.test(typeName)){
					commonUtil.message("只能输入中文哟！","danger");
					$("#inputType").val("");
					return false;
				}
				$.ajax({
					url:"${PATH}/manager/addGoodsType",
					type:"POST",
					data:"typeName=" + typeName,
					success:function (data) {
						console.log(data);
						if (data.success === true) {
							commonUtil.message(data.msg,"success");
							$("#inputType").val("");
						}else{
							$("#inputType").val("");
							commonUtil.message(data.msg,"danger");
						}
					}
				});
			});
		});
	</script>
	<title>添加商品类型</title>
</head>
<body>
<div style="width:98%;margin-left: 1%;">
	<div class="panel panel-default">
		<div class="panel-heading">
			添加商品类型
		</div>
		<div class="panel-body">
			<form>
				<div class="row">
					<div class="form-group form-inline col-md-12">
						<span>类型名称</span>
						<input type="text" name="name" class="form-control" id="inputType" placeholder="*服装类">
						<button type="reset" class="btn btn-default">清空</button>
						<button type="button" class="btn btn-default" id="add_btn">添加</button>
					</div>
				</div>
			</form>
		</div>
	</div>
</div>
</body>
</html>