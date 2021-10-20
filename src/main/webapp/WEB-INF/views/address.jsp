<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="utf-8"%>
<html>
<head>
	<%
		pageContext.setAttribute("PATH",request.getContextPath());
	%>
	<link href="${PATH}/static/bootstrap-3.4.1-dist/css/bootstrap.min.css" rel="stylesheet"/>
	<link rel="stylesheet" href="${PATH}/static/bootstrap-3.4.1-dist/css/main.css"/>
	<script type="text/javascript" src="${PATH}/static/js/jquery-3.3.1.js"></script>
	<script type="text/javascript" src="${PATH}/static/js/js/jquery.min.js"></script>
	<script type="text/javascript" src="${PATH}/static/bootstrap-3.4.1-dist/js/bootstrap.js"></script>
	<script type="text/javascript" src="${PATH}/static/js/viewUtils.js"></script>
	<title>xyz-个人中心</title>
	<script type="text/javascript">
	$(function(){
		$("#con1").load('foot')
	});
	$(function () {
		getUser();

		//给个人中心绑定单击事件
		$(".self").click(function () {
			$('#mySelfModal').modal({
				backdrop:"static"
			});
			getUser();
		});

		//给用户修改按钮绑定单击事件
		$(".update_btn").click(function () {
			var userId = $(".update_btn").attr("userId");
			// alert($("#selfForm").serialize())
			if (confirm("您确定要修改您的信息吗？")){
				$.ajax({
					url:"${PATH}/views/updateUser/" + userId,
					type:"PUT",
					data:$("#selfForm").serialize(),
					success:function (data) {
						console.log(data);
						if (data.success === true){
							commonUtil.message(data.msg,"success");
							$('#mySelfModal').modal('hide');
						}else{
							commonUtil.message(data.msg,"danger");
						}
					}
				})
			}
		});
	});

	function getUser(){
		$.ajax({
			url:"${PATH}/view/getUser",
			type:"GET",
			success:function (data) {
				console.log(data);
				if (data.success === true){
					showUserInfo(data);
					getAddr();
				}
			}
		})
	}

	function showUserInfo(data) {
		var username = data.user.username;
		$("#userName").val(username);
		var password = data.user.password;
		$("#password").val(password);
		var phoneNum = data.user.phoneNum;
		$("#phoneNum").val(phoneNum);
		var email = data.user.email;
		$("#email").val(email);
		var gender = data.user.gender;
		$("#gender").val(gender);
		var userId = data.user.id;
		$(".update_btn").attr("userId", userId);
		$(".addr").attr("user_id", userId);
	}

	//获取用户收货地址
	function getAddr() {
		var userId = $(".addr").attr("user_id");
		$.ajax({
			url:"${PATH}/views/getAddr",
			type:"GET",
			data:"id=" + userId,
			success:function (data) {
				console.log(data);
				if (data.success === true){
					showAddr(data);
				}
			}
		})
	}

	//显示用户收获地址
	function showAddr(data) {
		$("#addr").empty();
		var addrs = data.addr;
		$.each(addrs,function () {
		    if (this.status === 1){
                var tr = $("<tr></tr>");
                var id = $("<td></td>").append(this.id);
                var addrName = $("<td></td>").append(this.addrName);
                var addrPhone = $("<td></td>").append(this.addrPhone);
                var address = $("<td></td>").append(this.address);
                var del_btn = $("<button></button>").addClass("btn btn-danger btn-sm del_btn").append("删除");
                del_btn.attr("addr_id",this.id);
                var update = $("<button></button>").addClass("btn btn-default btn-sm update_addr").append("修改");
                update.attr("addr_id",this.id);
                // var add = $("<button></button>").addClass("btn btn-default btn-sm add_btn").append("添加");
                // <span class="badge" style="background-color:red;">默认</span>
                //     <span class="badge">普通</span>
                var defaults = $("<span style='background-color: red;'></span>").addClass("badge").append("默认");
                var btn =$("<td></td>").append(del_btn).append(" ").append(update).append(" ").append(design_btn).append(defaults);
                tr.append(id).append(addrName).append(addrPhone).append(address).append(btn);

                tr.appendTo($("#addr"));
            }else{
                var tr = $("<tr></tr>");
                var id = $("<td></td>").append(this.id);
                var addrName = $("<td></td>").append(this.addrName);
                var addrPhone = $("<td></td>").append(this.addrPhone);
                var address = $("<td></td>").append(this.address);
                var del_btn = $("<button></button>").addClass("btn btn-danger btn-sm del_btn").append("删除");
                del_btn.attr("addr_id",this.id);
                var update = $("<button></button>").addClass("btn btn-default btn-sm update_addr").append("修改");
                update.attr("addr_id",this.id);
                // var add = $("<button></button>").addClass("btn btn-default btn-sm add_btn").append("添加");
                var design_btn = $("<button></button>").addClass("btn btn-primary btn-sm design_btn").append("设为默认");
                design_btn.attr("addr_id",this.id);
                var primary = $("<span></span>").addClass("badge").append("普通");
                var btn =$("<td></td>").append(del_btn).append(" ").append(update).append(" ").append(design_btn).append(primary);
                tr.append(id).append(addrName).append(addrPhone).append(address).append(btn);

                tr.appendTo($("#addr"));
            }


		});
	}
	//给删除绑定单击事件
	$(document).on("click",".del_btn",function () {
		var id = $(this).attr("addr_id");
		if (confirm("你确定要删除该收货地址吗？")){
			$.ajax({
				url:"${PATH}/views/delAddr",
				type:"POST",
				data:"id=" + id,
				success:function (data) {
					console.log(data);
					if (data.success === true) {
						commonUtil.message(data.msg,"success");
						getUser();
					}else{
						commonUtil.message(data.msg,"danger");
					}
				}
			})
		}
	});

	//给添加绑定单击事件
    $(document).on("click",".add_btn",function () {
        $("#addrName1").val("");
        $("#addrPhone1").val("");
        $("#address1").val("");
        $('#addModal').modal({
            backdrop:"static"
        });
    });


	//给修改绑定单击事件
	$(document).on("click",".update_addr",function () {
        $("#addrName").val("");
        $("#addrPhone").val("");
        $("#address").val("");
		$("#updateAddr").attr("addr_id",$(this).attr("addr_id"));
		$('#addressModal').modal({
			backdrop:"static"
		});
	});

	$(function () {
		//给模态框更新按钮绑定单击事件
		$("#updateAddr").click(function () {
			// alert($("#userName1").val());
			// alert($("#password1").val());
			// alert($("#name").val());
			var addrName = $("#addrName").val();
			var addrPhone = $("#addrPhone").val();
			var address = $("#address").val();
			var id = $(this).attr("addr_id");
			$.ajax({
				url:"${PATH}/views/updateAddr",
				type:"POST",
				data:"id="+id+"&addrName="+addrName+"&addrPhone="+addrPhone+"&address="+address,
				success:function (data) {
					console.log(data);
					if (data.success === true) {
						commonUtil.message(data.msg,"success");
						$('#addressModal').modal('hide');
						getUser();
					}else{
						commonUtil.message(data.msg,"danger");
						$('#addressModal').modal('hide')
					}
				}
			})
		});
		//给添加绑定单击事件
        $("#addAddress").click(function () {
            //默认状态为0
            // var status = 0;
            var addrName = $("#addrName1").val();
            var addrPhone = $("#addrPhone1").val();
            var address = $("#address1").val();
            // alert($("#addForm").serialize())
            $.ajax({
                url:"${PATH}/views/addAddress",
                type:"POST",
                data:"addrName="+addrName+"&addrPhone="+addrPhone+"&address="+address,
                success:function (data) {
                    console.log(data);
                    if (data.success === true){
                        commonUtil.message(data.msg,"success");
                        $('#addModal').modal('hide');
                        getUser();
                    }else {
                        commonUtil.message(data.msg,"danger");
                        $('#addModal').modal('hide');
                    }
                }
            })
        });
        //给设为默认按钮绑定单击事件
        $(document).on("click",".design_btn",function () {
            var addrId = $(this).attr("addr_id");
            $.ajax({
                url:"${PATH}/views/makeDefault",
                type:"POST",
                data:"addrId="+addrId,
                success:function (data) {
                    console.log(data);
                    if (data.success === true){
                        commonUtil.message(data.msg,"success");
                        getUser();
                    }else{
                        commonUtil.message(data.msg,"danger");
                    }
                }
            })
        })



	});

</script>
</head>
<body>
<%--显示个人中心的模态框--%>
<div class="modal fade" tabindex="-1" role="dialog" id="mySelfModal">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">个人信息</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" id="selfForm">
					<div class="form-group row">
						<label class="col-sm-3 control-label" style="margin-top: 23px">用户名：</label>
						<div class="col-sm-7">
							<input type="text" class="form-control" name="username" id="userName"/>
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-3 control-label" style="margin-top: 23px">用户密码：</label>
						<div class="col-sm-7">
							<input type="text" class="form-control" name="password" id="password"/>
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-3 control-label" style="margin-top: 23px">用户手机：</label>
						<div class="col-sm-7">
							<input type="text" class="form-control" name="phoneNum" id="phoneNum"/>
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-3 control-label" style="margin-top: 23px">用户邮箱：</label>
						<div class="col-sm-7">
							<input type="text" class="form-control" name="email" id="email"/>
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-3 control-label" style="margin-top: 23px">用户性别：</label>
						<div class="col-sm-7">
							<input type="text" class="form-control" name="gender" id="gender"/>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary update_btn">修改</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->


<div id="top">
	<div id="topdiv">
            <span>
                <a href="${PATH}/views/index" id="a_top">下一站购物网</a>
                <li>|</li>
                <a href="${PATH}/views/index" id="a_top">XYZ购物网网页版</a>
                <li>|</li>
                <%--<a href="#" id="a_top">问题反馈</a>--%>
                <a href="#" id="a_top">问题反馈</a>
            </span>
		<span style="float:right">
                <%--<a id="a_top">欢迎您：${sessionScope.home_user}</a>--%>
                <a id="a_top">欢迎您：${sessionScope.home_user}</a>
                <li>|</li>
                <a href="${PATH}/loginOut" id="a_top">注销</a>
                <li>|</li>
                <a href="${PATH}/views/order" id="a_top">我的订单</a>
       			<li>|</li>
                <a id="a_top" class="self">个人中心</a>
                <li>|</li>
                <a href="${PATH}/views/address" id="a_top" class="addr">收获地址</a>
                <li>|</li>
                <a href="#" id="a_top">消息通知</a>
                <a href="${PATH}/views/cart" id="shorpcar">购物车</a>
            </span>
	</div>
</div>
<div>
	<table style="height:100px;width:86%" align="center">
		<tr>
			<td>
				<img id="logo" src="${PATH}/static/image/lg.png" width="200px" height="60px" alt=""/>
			</td>
			<td>
				<p id="goodsType" style="padding:10px;margin-left: 20px"></p>
			</td>
			<td align="right">
				<form action="selectByName" class="form-inline pull-right">
					<div class="form-group" >
						<input type="text" name="name" class="form-control" style="width: 300px"  placeholder="精准定位，搜索一下...">
					</div>
					<button type="submit" class="btn btn-warning"><span class="glyphicon glyphicon-search"></span>&nbsp;&nbsp;搜索</button>
				</form>
			</td>
		</tr>
	</table>
</div>
<%--添加地址模态框--%>
<div class="modal fade" tabindex="-1" role="dialog" id="addModal">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">添加收货地址</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="addForm">
                    <div class="form-group row">
                        <label class="col-sm-3 control-label" style="margin-top: 23px">收件人：</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control" name="addrName" id="addrName1"/>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-3 control-label" style="margin-top: 23px">电话号码：</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control" name="addrPhone" id="addrPhone1"/>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-sm-3 control-label" style="margin-top: 10px">详细地址：</label>
                        <div class="col-sm-7">
                            <textarea class="form-control" name="address" id="address1" placeholder="*详细地址"></textarea>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="addAddress">添加</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<%--修改收货地址模态框--%>
<div class="modal fade" tabindex="-1" role="dialog" id="addressModal">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title">更改收货地址</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" id="addrForm">
					<div class="form-group row">
						<label class="col-sm-3 control-label" style="margin-top: 23px">收件人：</label>
						<div class="col-sm-7">
							<input type="text" class="form-control" name="addrName" id="addrName"/>
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-3 control-label" style="margin-top: 23px">电话号码：</label>
						<div class="col-sm-7">
							<input type="text" class="form-control" name="addrPhone" id="addrPhone"/>
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-3 control-label" style="margin-top: 10px">详细地址：</label>
						<div class="col-sm-7">
							<textarea class="form-control" name="address" id="address" placeholder="*详细地址"></textarea>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				<button type="button" class="btn btn-primary" id="updateAddr">更新</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<div id="dingdanxiangqing_body">
    <div id="dingdanxiangqing_body_big">
        <div id="big_left">
               <p style="font-size:18px">个人中心</p>
               <a id="big_left_a" href="">收货地址</a><br/>
        </div>
		 <div id="big_right" style="height: 500px;overflow: scroll;">
			 <div style="margin:0 20px;">
				 <h3>收货地址</h3>
				 <hr>
				 <table class="table table-striped table-hover table-bordered">
					<thead>
						<tr>
							<th>序号</th>
							<th>收件人</th>
							<th>手机号</th>
							<th>详细地址</th>
							<th>
                                操作
                                <button class="btn btn-primary add_btn" style="float: right">添加收获地址</button>
                            </th>
						</tr>
					</thead>
					 <tbody id="addr">

					 </tbody>
				</table>
			</div>
		 </div>
	</div>
</div>
<div id="con1"></div>
</body>
</html>