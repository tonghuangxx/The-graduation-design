<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<!--保存操作后的提示信息：成功或者失败-->
<div id="save_result_info" class="save_success" style="display:none"></div>
<form action="<%=request.getContentType() %>/user/editDo" method="post" class="main_form" id="userEditForm">
	<input type="hidden" value="${adminInfo.id}" name="adminInfo.id" />
	<input type="hidden" value="${adminInfo.password}" name="adminInfo.password" />
	<div class="text_info clearfix">
		<span>管理员账号：</span>
	</div>
	<div class="input_info">
		<input type="text" readonly="readonly" class="readonly"  name="adminInfo.admin_code" value="${adminInfo.admin_code}" />
	</div>
	<div class="text_info clearfix">
		<span>角色：</span>
	</div>
	<div class="input_info">
		<input type="text" readonly="readonly" class="readonly width400"
			value="<s:iterator value="adminInfo.roleList" var="rl"><s:property value="#rl.role_name"/>&nbsp;</s:iterator>" />
	</div>
	<s:iterator value="adminInfo.roleList" var="rl">
		<input type="hidden" value="<s:property value="#rl.id"/>" name="rid"/>
	</s:iterator>
	<div class="text_info clearfix">
		<span>姓名：</span>
	</div>
	<div class="input_info">
		<input type="text" value="${adminInfo.name}" name="adminInfo.name" id="name"/>
		<span class="required">*</span>
		<div class="validate_msg_long validate_msg_long1">
			20长度以内的汉字、字母的组合
		</div>
	</div>
	<div class="text_info clearfix">
		<span>电话：</span>
	</div>
	<div class="input_info">
		<input type="text" class="width200" value="${adminInfo.telephone}" id="telphone"
			name="adminInfo.telephone" />
		<div class="validate_msg_medium validate_msg_long2">
			电话号码格式：手机或固话
		</div>
	</div>
	<div class="text_info clearfix">
		<span>Email：</span>
	</div>
	<div class="input_info">
		<input type="text" class="width200" value="${adminInfo.email}" id="email"
			name="adminInfo.email" />
		<div class="validate_msg_medium validate_msg_long3">
			50长度以内，符合 email 格式
		</div>
	</div>
	<div class="text_info clearfix">
		<span>创建时间：</span>
	</div>
	<div class="input_info">
		<input type="text" readonly="readonly" class="readonly" name="adminInfo.enrolldate"
			value="<s:date name="adminInfo.enrolldate" format="yyyy-MM-dd HH:mm:ss"/>" />
	</div>
	<div class="button_info clearfix">
		<input type="button" value="保存" class="btn_save" onclick="modifyUser();" />
		<input type="reset" value="取消" class="btn_save" />
	</div>
</form>
<script type="text/javascript">
//用户名称框的失去焦点事件
$('#name').blur(function(){
var name=$.trim($('#name').val());
	if(name==""){
		$('.validate_msg_long1').addClass("error_msg");
	}else{
		$('.validate_msg_long1').removeClass("error_msg");
	}
});

$('#email').blur(function(){
var email=$.trim($('#email').val());
	if(email==""){
		$('.validate_msg_long3').addClass("error_msg");
	}else{
		$('.validate_msg_long3').removeClass("error_msg");
	}
});

$('#telphone').blur(function(){
var telphone=$.trim($('#telphone').val());
	if(telphone==""){
		$('.validate_msg_long2').addClass("error_msg");
	}else{
		$('.validate_msg_long2').removeClass("error_msg");
	}
});

/**
 * 保存
 */
function modifyUser() {
	$(':input').trigger('blur');
		if ($('form div').hasClass('error_msg')) {
			return false;
		}
		AT.postFrm("#userEditForm", editUserCall_function);

}
function editUserCall_function(json){
	var data = eval('('+json+')');
	showResultDiv(true,data.message);
	window.setTimeout("showResultDiv(false);", 5000);
}

//保存成功与否的提示消息
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
