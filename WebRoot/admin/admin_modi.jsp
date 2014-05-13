<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<div id="save_result_info" class="save_success" style="display:none"></div>
            <form action="<%=request.getContextPath() %>/user/editDo" method="post" class="main_form" id="userEditForm">
            <input type="hidden" value="${adminInfo.id}" name="adminInfo.id"/>
            <input type="hidden" value="${adminInfo.enrolldate}" name="adminInfo.enrolldate"/>
            <input type="hidden" value="${adminInfo.password}" name="adminInfo.password"/>
                    <div class="text_info clearfix"><span>姓名：</span></div>
                    <div class="input_info">
                        <input type="text" value="${adminInfo.name}" name="adminInfo.name" id="name"/>
                        <span class="required">*</span>
                        <div class="validate_msg_long validate_msg_long1">20长度以内的汉字、字母、数字的组合</div>
                    </div>
                    <div class="text_info clearfix"><span>管理员账号：</span></div>
                    <div class="input_info"><input type="text" readonly="readonly" class="readonly" value="${adminInfo.admin_code}"  name="adminInfo.admin_code"/></div>
                    <div class="text_info clearfix"><span>电话：</span></div>
                    <div class="input_info">
                        <input type="text" value="${adminInfo.telephone}"  name="adminInfo.telephone" id="telphone"/>
                        <span class="required">*</span>
                        <div class="validate_msg_long validate_msg_long2">正确的电话号码格式：手机或固话</div>
                    </div>
                    <div class="text_info clearfix"><span>Email：</span></div>
                    <div class="input_info">
                        <input type="text" class="width200" value="${adminInfo.email}" name="adminInfo.email" id="email"/>
                        <span class="required">*</span>
                        <div class="validate_msg_medium validate_msg_long3">50长度以内，正确的 email 格式</div>
                    </div>
                    <div class="text_info clearfix"><span>角色：</span></div>
                    <div class="input_info_high">
                        <div class="input_info_scroll">
                            <ul>
                            <s:iterator value="roleMap" var="rm">
                            	<li><input type="checkbox" name="rid"  value="<s:property value="key.id"/>" <s:if test="value==1">checked="checked"</s:if>/><s:property value="key.role_name"/></li>
                            </s:iterator>
                            </ul>
                        </div>
                        <span class="required">*</span>
                        <div class="validate_msg_tiny">至少选择一个</div>
                    </div>
                    <div class="button_info clearfix">
                        <input type="button" value="保存" class="btn_save" id="send" onclick="modifyUser();"/>
                        <input type="button" value="取消" class="btn_save" onclick="cancel();" />
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
	var j = 0; // 判断是否有checkbox选中
	var inputArray = document.getElementById("userEditForm").getElementsByTagName(
			"input");
	for ( var i = 1; i < inputArray.length; i++) {
		if (inputArray[i].type == "checkbox") {
			if (inputArray[i].checked) {
				j++;
			}
		}
	}
	// 如果没有选中就不能提交表单
	if (j == 0) {
		$('.validate_msg_tiny').addClass("error_msg");
		return false;
	} else {
		$('.validate_msg_tiny').removeClass("error_msg");
		if ($('form div').hasClass('error_msg')) {
			return false;
		}
		AT.postFrm("#userEditForm", editUserCall_function);
	}

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
function cancel(){
	var href="../user/listData";
	$.post(href,function(data){
		$("#main").html(data);
	});
}
</script>
