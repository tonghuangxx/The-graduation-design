<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
 <div id="save_result_info" class="save_success" style="display:none"></div><!--保存失败，旧密码错误！-->
            <form action="<%=request.getContextPath() %>/user/updatePwdDo" method="post" class="main_form" id="resetPwd">
               	<input type="hidden" value="${adminInfo.id }" name="adminInfo.id"/>
                <div class="text_info clearfix"><span>旧密码：</span></div>
                <div class="input_info">
                    <input type="password" class="width200"  name="oldPwd" id="oldPwd"/><span class="required">*</span>
                    <div class="validate_msg_medium validate_msg_medium1" ></div>
                </div>
                <div class="text_info clearfix"><span>新密码：</span></div>
                <div class="input_info">
                    <input type="password"  class="width200" id="pwd" name="adminInfo.password"/><span class="required">*</span>
                    <div class="validate_msg_medium validate_msg_medium2" >4-8长度的字母、数字和下划线的组合</div>
                </div>
                <div class="text_info clearfix"><span>重复新密码：</span></div>
                <div class="input_info">
                    <input type="password" class="width200"  id="rpwd"/><span class="required">*</span>
                    <div class="validate_msg_medium validate_msg_medium3">4-8长度的字母、数字和下划线的组合</div>
                </div>
                <div class="button_info clearfix">
                    <input type="button" value="保存" class="btn_save" id="send" onclick="updatePwdDo();"/>
                    <input type="reset" value="取消" class="btn_save" />
                </div>
            </form>  
<script type="text/javascript">
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

$('#oldPwd').blur(function(){
	if($.trim($('#oldPwd').val())==""){
		$('.validate_msg_medium1').addClass('error_msg').html("旧密码不能为空");
	}else{
		$('.validate_msg_medium1').removeClass('error_msg').html("");
	}
});
//新密码的失去焦点时，判断用户输入的是否合格
$('#pwd').blur(function(){
	var pwd1=$('#pwd').val();
	var pwd=$.trim($('#pwd').val());
	//判断前后是否有空格
	if(pwd1!=pwd){
		$('.validate_msg_medium2').addClass('error_msg');
		return ;
	}else{
	 	$('.validate_msg_medium2').removeClass('error_msg');
	}
	//判断长度是否为4-8
	var reg=/^\w{4,8}$/;
	if(!reg.test(pwd)){
		$('.validate_msg_medium2').addClass('error_msg');
		return;
	}else{
		$('.validate_msg_medium2').removeClass('error_msg');
	}
});
$('#rpwd').blur(function(){
	var pwd=$.trim($('#pwd').val());
	var rpwd=$('#rpwd').val();
	if(pwd==""){
	$('.validate_msg_medium3').addClass('error_msg').html("不能为空");
		return;
	}
	if(pwd!=rpwd){
		$('.validate_msg_medium3').addClass('error_msg').html("两次密码不一致");
		return;
	}
	else{
		$('.validate_msg_medium3').removeClass('error_msg').html("4-8长度的字母、数字和下划线的组合");
	}
});
function updatePwdDo(){
	$(':input').trigger('blur');
	if($("form div").hasClass('error_msg')){
		return false;
	}else{
		AT.postFrm("#resetPwd", updatePwdCall_function);
	}
}
function updatePwdCall_function(json){
	var data = eval('('+json+')');
	showResultDiv(true,data.message);
	window.setTimeout("showResultDiv(false);", 5000);
}	
</script>
