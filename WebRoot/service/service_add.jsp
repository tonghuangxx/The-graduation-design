<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/taglibs.jsp"%>
<div id="save_result_info" class="save_success"></div>
            <form action="<%=request.getContextPath() %>/service/addDo" method="post" class="main_form" id="serviceAddForm" >
                <!--内容项-->
                <div class="text_info clearfix"><span>身份证：</span></div>
                <div class="input_info">
                    <input type="text" name="service.account.idcard_no" value="" class="width180" id="idcard_no" placeholder="请输入账务账号中存在的身份证"/>
                    <input type="button" value="查询身份证" class="btn_search_large" onclick="checkIdcard_no();"  />
                    <span class="required">*</span>
                    <div class="validate_msg_short validate_info1"></div>
                </div>
                <input value="" name="service.account_id" id="account_id" type="hidden"/>
                <div class="text_info clearfix"><span>资费类型：</span></div>
                <div class="input_info">
                    <select class="width150" name="service.cost_id" id="cost_id">
						<s:iterator value="feeList" var="f">
							<option value="<s:property value="#f.id"/>"><s:property value="#f.name"/></option>
						</s:iterator>
					</select>                       
                </div> 
                <div class="text_info clearfix"><span>服务器 IP：</span></div>
                <div class="input_info">
                    <select class="width150" name="service.unix_host" id="cost_id">
						<s:iterator value="hostList" var="h">
							<option value="<s:property value="#h.id"/>"><s:property value="#h.host_ip"/></option>
						</s:iterator>
					</select> 
                </div>                   
                <div class="text_info clearfix"><span>登录 OS 账号：</span></div>
                <div class="input_info">
                    <input type="text"  name="service.os_username" id="os_username" />
                    <span class="required">*</span>
                    <div class="validate_msg_long">4-8长度的字母、数字和下划线的组合</div>
                </div>
                <div class="text_info clearfix"><span>密码：</span></div>
                <div class="input_info">
                    <input type="password"  name="service.login_passwd" id="login_passwd"/>
                    <span class="required">*</span>
                    <div class="validate_msg_long">4-16长度的字母、数字和下划线的组合</div>
                </div>
                <div class="text_info clearfix"><span>重复密码：</span></div>
                <div class="input_info">
                    <input type="password" id="com_login_passwd" />
                    <span class="required">*</span>
                    <div class="validate_msg_long">两次密码必须相同</div>
                </div>     
                <!--操作按钮-->
                <div class="button_info clearfix">
                    <input type="button" value="保存" class="btn_save" onclick="to_serviceAddDo();" />
                    <input type="button" value="取消" class="btn_save" />
                </div>
            </form>
<script language="javascript" type="text/javascript">
/*$().ready(function() {
	$("#serviceAddForm").validate({
		rules:{
			idcard_no:{required:true,remote:{url:"${pageContext.request.contextPath}/service/checkIdcard_no"}},
	        os_username:{required:true,check_os_username:true},
	        login_passwd:{required:true,check_login_passwd:true},
	        com_login_passwd:{required:true,check_com_login_passwd:true,equalTo:"#login_passwd"}
		},
		messages:{
			idcard_no:{remote:"没有此身份证号，请重新录入。"},
			os_username:{required:"4-8长度的字母、数字和下划线的组合"},
			login_passwd:{required:"4-16长度的字母、数字和下划线的组合"},
			com_login_passwd:{required:"4-16长度的字母、数字和下划线的组合"}
		},
		errorClass:"error_msg",
		errorPlacement:function (error, element){
	        error.appendTo(element.parent().children("div")); 
		},
		success:function(element){
			element.parent().children("div").removeClass("error_msg").addClass("displayOK").html("ok");
		}
	});
});
$.validator.setDefaults({
	submitHandler: function() { alert("submitted!"); }
});

//os账号的验证规则
jQuery.validator.addMethod("check_os_username",function(value,element){
	var pattern='/^\w{4,8}$/';
	if(!pattern.test(value)){
		return false;
	}
	return true;
},"4-8长度的字母、数字和下划线的组合");
//密码的验证规则
jQuery.validator.addMethod("check_login_passwd",function(value,element){
	var pattern='/^\w{4,16}$/';
	if(!pattern.test(value)){
		return false;
	}
	return true;
},"4-16长度的字母、数字和下划线的组合");
//重复密码的验证规则
jQuery.validator.addMethod("check_com_login_passwd",function(value,element){
	var pattern='/^\w{4,16}$/';
	if(!pattern.test(value)){
		return false;
	}
	return true;
},"4-16长度的字母、数字和下划线的组合");
*/

function to_serviceAddDo(){
	checkIdcard_no();
	var div=$(".input_info div");
	if(div.hasClass("error_msg")){
		return;
	}else{
		AT.postFrm("#serviceAddForm", addServiceCall_function);
	}
}
function addServiceCall_function(json){
	var data = eval('(' + json + ')'); 
	document.getElementById("serviceAddForm").reset();
	showResultDiv(true,data.message);
	window.setTimeout("showResultDiv(false);", 5000);
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

	//自动查询账务账号
	function searchAccounts(txtObj) {
		//document.getElementById("a1").innerHTML = txtObj.value;
	}

function checkIdcard_no(){
	var idcard_no=$("#idcard_no").val();
	if($.trim(idcard_no)==""){
		$(".validate_info1").addClass("error_msg").html("请输入身份证号");
		return false;
	}else{	
		var href = "${pageContext.request.contextPath}/service/checkIdcard_no";
		$.post(href,{'service.account.idcard_no':idcard_no},function(json){
			var data = eval('(' + json + ')'); 
			if(data.statusCode=="200"){
				$("#account_id").val(data.message);
				$(".validate_info1").removeClass("error_msg").addClass("displayOK").html("ok");	
				return true;
			}else{
				$(".validate_info1").addClass("error_msg").html(data.message);
				return false;
			}
		});
	}
}	
</script>
