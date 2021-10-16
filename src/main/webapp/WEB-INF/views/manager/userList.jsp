<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	<title>会员列表</title>
	<script type="text/javascript">
	//定义一个全局变量当删除是回到当前页面
	var currentNum;
	$(function(){
		loadUser(1);
	});
	//获取用户数据
	function loadUser(pageNum){
		$.ajax({
			url:"${PATH}/manager/getUserList",
			type:"GET",
			data:"pageNum=" + pageNum,
			success:function(data){
				// console.log(data);
				showMsg(data);
				page_info(data);
				page_nav(data);
			}
		});
	}
	//显示用户信息
	function showMsg(data){
		//每次刷新清空表格数据
		$("tbody").empty();
		var viewUsers = data.page.list;
		$.each(viewUsers,function () {
			var id = $("<td></td>").append(this.id);
			var username = $("<td></td>").append(this.username);
			// var password = $("<td></td>").append(this.password);
			var phoneNum = $("<td></td>").append(this.phoneNum);
			var email = $("<td></td>").append(this.email);
			var gender = $("<td></td>").append(this.gender);
			var btn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
					.append("<span></span>").addClass("glyphicon glyphicon-trash").append("删除");
			var delBtn =$("<td></td>").append(btn);
			btn.attr("del_id",this.id);
			$("<tr></tr>").append(id).append(username).append(phoneNum)
					.append(email).append(gender).append(delBtn).appendTo($("tbody"));
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
				loadUser(data.page.pageNum - 1);
			});
			first.click(function () {
				loadUser(1);
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
					loadUser(item);
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
				loadUser(data.page.pageNum + 1);
			});
			last.click(function () {
				loadUser(data.page.pages);
			});
		}
		var nav = $("<nav></nav>").append(ul);
		nav.appendTo($("#page_nav"));
	}

	/**
	 * 弹出消息框
	 * @param msg 消息内容
	 * @param type 消息框类型（参考bootstrap的alert）
	 */
	var commonUtil = {
		alert: function (msg, type) {
			if (typeof (type) == "undefined") { // 未传入type则默认为success类型的消息框
				type = "success";
			}
			// 创建bootstrap的alert元素
			var divElement = $("<div></div>").addClass('alert').addClass('alert-' + type).addClass('alert-dismissible').addClass('col-md-4').addClass('col-md-offset-4');
			divElement.css({ // 消息框的定位样式
				"position": "absolute",
				"top": "80px",
				"left":"300px"
			});
			divElement.text(msg); // 设置消息框的内容
			// 消息框添加可以关闭按钮
			var closeBtn = $('<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>');
			$(divElement).append(closeBtn);
			// 消息框放入到页面中
			$('body').append(divElement);
			return divElement;
		},

		/**
		 * 短暂显示后上浮消失的消息框
		 * @param msg 消息内容
		 * @param type 消息框类型
		 */
		message: function (msg, type) {
			var divElement = commonUtil.alert(msg, type); // 生成Alert消息框
			var isIn = false; // 鼠标是否在消息框中

			divElement.on({ // 在setTimeout执行之前先判定鼠标是否在消息框中
				mouseover: function () {
					isIn = true;
				},
				mouseout: function () {
					isIn = false;
				}
			});

			// 短暂延时后上浮消失
			setTimeout(function () {
				var IntervalMS = 20; // 每次上浮的间隔毫秒
				var floatSpace = 60; // 上浮的空间(px)
				var nowTop = divElement.offset().top; // 获取元素当前的top值
				var stopTop = nowTop - floatSpace;    // 上浮停止时的top值
				divElement.fadeOut(IntervalMS * floatSpace); // 设置元素淡出

				var upFloat = setInterval(function () { // 开始上浮
					if (nowTop >= stopTop) { // 判断当前消息框top是否还在可上升的范围内
						divElement.css({"top": nowTop--}); // 消息框的top上升1px
					} else {
						clearInterval(upFloat); // 关闭上浮
						divElement.remove();    // 移除元素
					}
				}, IntervalMS);

				if (isIn) { // 如果鼠标在setTimeout之前已经放在的消息框中，则停止上浮
					clearInterval(upFloat);
					divElement.stop();
				}

				divElement.hover(function () { // 鼠标悬浮时停止上浮和淡出效果，过后恢复
					clearInterval(upFloat);
					divElement.stop();
				}, function () {
					divElement.fadeOut(IntervalMS * (nowTop - stopTop)); // 这里设置元素淡出的时间应该为：间隔毫秒*剩余可以上浮空间
					upFloat = setInterval(function () { // 继续上浮
						if (nowTop >= stopTop) {
							divElement.css({"top": nowTop--});
						} else {
							clearInterval(upFloat); // 关闭上浮
							divElement.remove();    // 移除元素
						}
					}, IntervalMS);
				});
			}, 1500);
		}
	};
	//条件查询
	//给查询按钮 添加 点击事件
	$(function () {
		$("#search").click(function () {
			var username = $("input[name='username']").val();
			var genders = $("input[name='gender']");
			// var gender = "";
			// //遍历取出gender的值
			// for (var i = 0; i < genders.length; i++) {
			// 	if (genders[i].checked) {
			// 		gender += genders[i].value;
			// 	}
			// }
			//发送ajax请求,只能查询到一个对象
			$.ajax({
				url:"${PATH}/manager/searchUser",
				type:"GET",
				data:"username="+username,
				success:function (data) {
					console.log(data);
					if (data.success === true){
						//清空输入框的数据
						$("input[name='username']").val("");
						//每次刷新清空表格数据
						$("tbody").empty();
						var viewUsers = data.viewsUser;
						var id = $("<td></td>").append(viewUsers.id);
						var username = $("<td></td>").append(viewUsers.username);
						// var password = $("<td></td>").append(this.password);
						var phoneNum = $("<td></td>").append(viewUsers.phoneNum);
						var email = $("<td></td>").append(viewUsers.email);
						var gender = $("<td></td>").append(viewUsers.gender);
						var btn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
								.append("<span></span>").addClass("glyphicon glyphicon-trash").append("删除");
						var delBtn =$("<td></td>").append(btn);
						btn.attr("del_id",viewUsers.id);
						$("<tr></tr>").append(id).append(username).append(phoneNum)
								.append(email).append(gender).append(delBtn).appendTo($("tbody"));
						//清空分页显示
						$("#page").remove();
					}else{
						$("input[name='username']").val("");
						commonUtil.message(data.msg,"danger");
					}
				}
			});

		});
	});
	//给删除绑定单击事件，实现删除用户
	$(document).on("click",".delete_btn",function () {
		// alert("asdaf");
		//找到父级元素中的tr中的id,username
		var id = $(this).attr("del_id");
		var username = $(this).parents("tr").find("td:eq(1)").text();
		if (confirm("确认要删除【"+ username +"】吗？")){
			$.ajax({
				url:"${PATH}/manager/delUser/"+id,
				type:"DELETE",
				success:function (data) {
					// map.put("exc","删除用户失败！请稍后再试！");
					console.log(data);
					if (data.success === true){
						//回到当前页
						loadUser(currentNum);
						commonUtil.message(data.msg);
					}else {
						commonUtil.message(data.msg,"danger");
					}
				}
			})
		}
	});
</script>
</head>
<body>
	<div class="row" style="width: 100%;">
			<div class="col-md-12">
				<div class="panel panel-default">
					<div class="panel-heading">会员列表</div>
					<div class="panel-body">
						<!-- 条件查询 -->
						<div class="row">
							<div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">
								<div class="form-group form-inline">
									<span>用户名</span>
									<input type="text" name="username" class="form-control">
								</div>
							</div>
							<%--<div class="col-xs-3 col-sm-3 col-md-3 col-lg-3">--%>
								<%--<div class="form-group form-inline">--%>
									<%--<span>性别</span>--%>
									<%--&nbsp;&nbsp;&nbsp;&nbsp;--%>
									<%--<label class="radio-inline">--%>
									  <%--<input type="radio" name="gender" value="男"> 男&nbsp;&nbsp;&nbsp;&nbsp;--%>
									<%--</label>--%>
									<%--<label class="radio-inline">--%>
									  <%--<input type="radio" name="gender" value="女"> 女--%>
									<%--</label>--%>
								<%--</div>--%>
							<%--</div>--%>
							<div class="col-xs-3 col-sm-3 col-md-3 col-lg-3" style="margin-top: 20px;">
								<button type="button" class="btn btn-primary" id="search"><span class="glyphicon glyphicon-search"></span></button>
							</div>
						</div>
						<!-- 列表显示 -->
						<table id="tb_list" class="table table-striped table-hover table-bordered">
							<thead>
								<tr class="tr_head">
									<th style="text-align: center">编号</th>
									<th style="text-align: center">姓名</th>
									<th style="text-align: center">邮箱</th>
									<th style="text-align: center">性别</th>
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
</body>
</html>