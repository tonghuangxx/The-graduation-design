<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.validate.js"></script>
<style type="text/css">
.displayOK {
	color: green;
}
</style>
<div id="save_result_info" class="save_success" style="display:none"></div>
<form action="<%=request.getContextPath()%>/user/addDo" method="post" class="main_form" id="userAddForm" >
	<div class="text_info clearfix">
		<span>姓名：</span>
	</div>
	<div class="input_info">
		<input type="text" name="adminInfo.name" value="" id="name" />
		<span class="required">*</span>
		<div class="validate_msg_long" id="nameLabel">
			2-20长度的汉字、字母、数字的组合
		</div>
	</div>
	<div class="text_info clearfix">
		<span>管理员账号：</span>
	</div>
	<div class="input_info">
		<input type="text" name="adminInfo.admin_code" value=""
			id="admin_code" />
		<span class="required">*</span>
		<div class="validate_msg_long" id="adminCodeLabel">
			4-20长度的字母、数字和下划线的组合
		</div>
	</div>
	<div class="text_info clearfix">
		<span>密码：</span>
	</div>
	<div class="input_info">
		<input type="password" name="adminInfo.password" value="" id="pwd" />
		<span class="required">*</span>
		<div class="validate_msg_long" id="pwdLabel">
			4-8长度的字母、数字和下划线的组合
		</div>
	</div>
	<div class="text_info clearfix">
		<span>重复密码：</span>
	</div>
	<div class="input_info">
		<input type="password" value="" id="rpwd" />
		<span class="required">*</span>
		<div class="validate_msg_long" id="rpwdLabel">
			两次密码必须相同
		</div>
	</div>
	<div class="text_info clearfix">
		<span>电话：</span>
	</div>
	<div class="input_info">
		<input type="text" class="width200" id="telphone"
			name="adminInfo.telephone" value="" />
		<span class="required">*</span>
		<div class="validate_msg_medium" id="telphoneLabel">
			正确的电话号码格式：手机或固话
		</div>
	</div>
	<div class="text_info clearfix">
		<span>Email：</span>
	</div>
	<div class="input_info">
		<input type="text" class="width200" name="adminInfo.email" value=""
			id="email" />
		<span class="required">*</span>
		<div class="validate_msg_medium" id="emailLabel">
			50长度以内，正确的 email 格式
		</div>
	</div>
	<div class="text_info clearfix">
		<span>角色：</span>
	</div>
	<div class="input_info_high">
		<div class="input_info_scroll">
			<ul>
				<s:iterator value="rList" var="r">
					<s:if test="#r.role_name=='管理员管理'">
						<li>
							<input type="checkbox" name="rid" value="${id }"
								checked="checked" />
							${role_name }
						</li>
					</s:if>
					<s:else>
						<li>
							<input type="checkbox" name="rid" value="${id }" />
							${role_name }
						</li>
					</s:else>
				</s:iterator>
			</ul>
		</div>
		<span class="required">*</span>
		<div class="validate_msg_tiny" id="roleLabel">
			至少选择一个
		</div>
	</div>
	<div class="button_info clearfix">
		<input type="button" value="保存" class="btn_save" id="send" onclick="addUser();"/>
		<input type="button" value="取消" class="btn_save" onclick="cancel();" />
	</div>
</form>
<script type="text/javascript">
$('#admin_code').blur(function() {
	var admin_code = $.trim($('#admin_code').val());
	//检查是否为空
		if (admin_code == '') {
			$('#adminCodeLabel').addClass("error_msg").html("管理员帐号不能为空");
			return;
		}
		var reg = /^\w{4,20}$/;
		if (!reg.test(admin_code)) {
			$('#adminCodeLabel').addClass("error_msg").html(
					"4-20长度的字母、数字和下划线的组合");
			return;
		} else {
			$('#adminCodeLabel').removeClass("error_msg").html(
					"4-20长度的字母、数字和下划线的组合");
		}
		$.post("../user/adminCodeValidName", {
			"adminInfo.admin_code" : admin_code
		},
				function(json) {
					var data = eval('(' + json + ')'); 
					if(data.statusCode==200){
						$('#adminCodeLabel').removeClass('error_msg')
						.addClass('displayOK').html('ok');
					}else{
						$('#adminCodeLabel').addClass("error_msg ").html(data.message);
					}
					
				});
	});
//姓名失去焦点
$('#name').blur(function() {
	var name = $.trim($('#name').val());
	//检查是否为空
		if (name == '') {
			$('#nameLabel').addClass("error_msg").html("姓名不能为空");
			return;
		}
		var reg = /^([\u4e00-\u9fa5]|\w){2,20}$/;
		if (!reg.test(name)) {
			$('#nameLabel').addClass("error_msg").html(
					"2-20长度的字母、数字和下划线的组合");
			return;
		} else {
			$('#nameLabel').removeClass("error_msg").addClass('displayOK')
					.html('ok');
		}
	});
//密码失去焦点
$('#pwd')
		.blur(function() {
			var pwd = $.trim($('#pwd').val());
			//检查是否为空
				if (pwd == '') {
					$('#pwdLabel').addClass("error_msg").html("密码不能为空");
					return;
				}
				var reg = /^\w{4,8}$/;
				if (!reg.test(pwd)) {
					$('#pwdLabel').addClass("error_msg").html(
							"4-8长度的字母、数字和下划线的组合");
					return;
				} else {
					$('#pwdLabel').removeClass("error_msg").addClass(
							'displayOK').html('ok');
				}
			});
//重复密码框失去焦点
$('#rpwd').blur(
		function() {
			if ($.trim($('#rpwd').val()) == "") {
				$('#rpwdLabel').addClass("error_msg").html("不能为空");
				return;
			}
			if ($('#rpwd').val() != $('#pwd').val()) {
				$('#rpwdLabel').addClass("error_msg").html("两次密码必须相同");
			} else {
				$('#rpwdLabel').removeClass("error_msg").addClass(
						'displayOK').html('ok');
			}
		});
//电话输入框失去焦点
$('#telphone').blur(function() {
	var telphone = $.trim($('#telphone').val());
	//检查是否为空
		if (telphone == '') {
			$('#telphoneLabel').addClass("error_msg").html("电话不能为空");
			return;
		}
		var reg = /^[0-9]{4,20}$/;
		if (!reg.test(telphone)) {
			$('#telphoneLabel').addClass("error_msg").html(
					"正确的电话号码格式：手机或固话");
			return;
		} else {
			$('#telphoneLabel').removeClass("error_msg").addClass(
					'displayOK').html('ok');
		}
	});

//邮箱输入框失去焦点
$('#email').blur(function() {
	var email = $.trim($('#email').val());
	//检查是否为空
		if (email == '') {
			$('#emailLabel').addClass("error_msg").html("邮箱不能为空");
			return;
		}
		var reg = /^(\w+@{1}\w+[\.]{1}[a-zA-Z]+)$/;
		if (!reg.test(email)) {
			$('#emailLabel').addClass("error_msg").html(
					"50长度以内，正确的 email 格式");
			return;
		}
		if (email.length > 50) {
			$('#emailLabel').addClass("error_msg").html(
					"50长度以内，正确的 email 格式");
		} else {
			$('#emailLabel').removeClass("error_msg").addClass('displayOK')
					.html('ok');
		}
	});

/**
 * 点击保存后
 */
function addUser(){
	$(':input').trigger('blur');
	var j = 0; //判断是否有checkbox选中
		var inputArray = document.getElementById("userAddForm").getElementsByTagName("input");
		for ( var i = 1; i < inputArray.length; i++) {
			if (inputArray[i].type == "checkbox") {
				if (inputArray[i].checked) {
					j++;
				}
			}
		}
		//如果没有选中就不能提交表单
		if (j == 0) {
			$('.validate_msg_tiny').addClass("error_msg");
			return false;
		} else {
			$('.validate_msg_tiny').removeClass("error_msg");
			if ($('form div').hasClass('error_msg')) {
				return false;
			}
			AT.postFrm("#userAddForm", addUserCall_function);
		}
}
function addUserCall_function(json){
	var data = eval('(' + json + ')'); 
	document.getElementById("userAddForm").reset();
	showResultDiv(true,data.message);
	window.setTimeout("showResultDiv(false);", 5000);
}

/**
 * 取消
 * @return
 */
function cancel(){
	var href="../user/listData";
	$.post(href,function(data){
		$("#main").html(data);
	});
}

function showResultDiv(flag,message) {
	var divResult = document.getElementById("save_result_info");
	if (flag) {
		divResult.innerHTML=message;
		divResult.style.display = "block";
	} else {
		divResult.style.display = "none";
	}
}
</script>
