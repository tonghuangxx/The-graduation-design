<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/taglibs.jsp"%>
<div id="save_result_info" class="save_success"><s:property value="addMsg"/></div>
            <form action="<%=request.getContextPath() %>/role/editDo" method="post" class="main_form" id="roleEditForm">
                <div class="text_info clearfix"><span>角色名称：</span></div>
                <div class="input_info">
                    <input type="text" class="width200" value="${role.role_name}" name="role.role_name" id="role_name"/>
                    <input type="hidden" value="${role.id}" name="role.id" id="role_id"/>
                    <span class="required">*</span>
                    <div class="validate_msg_medium">不能为空，且为20长度的字母、数字和汉字的组合</div>
                </div>                    
                <div class="text_info clearfix"><span>设置功能：</span></div>
                <div class="input_info_high">
                    <div class="input_info_scroll">
                    	 <ul>
                            <s:iterator value="functionMap" var="fm">
                            	<li><input type="checkbox" name="fid"  value="<s:property value="key.id"/>" <s:if test="value==1">checked="checked"</s:if>/><s:property value="key.name"/></li>
                            </s:iterator>
                         </ul>
                    </div>
                    <span class="required">*</span>
                    <div class="validate_msg_tiny">至少选择一个功能</div>
                </div>
                <div class="button_info clearfix">
                    <input type="button" value="保存" class="btn_save"  onclick="to_roleEditDo();"/>
                    <input type="button" value="取消" class="btn_save" />
                </div>
            </form> 
<script type="text/javascript">
$('#role_name').blur(function(){
	var role_name=$.trim($('#role_name').val());
	var id = $("#role_id").val();
	if(role_name==""){
		$('.validate_msg_medium').addClass("error_msg");
	}else{
		var href="../role/checkRole_name";
		$.post(href,{"role.role_name":role_name,"role.id":id},function(json){
			var data = eval('(' + json + ')')
			if(data.statusCode==200){
				$('.validate_msg_medium').removeClass("error_msg").addClass('displayOK').html('ok');
			}else{
				$('.validate_msg_medium').addClass("error_msg").html(data.message);
			}
		});
	}
});

	function to_roleEditDo() {
		$(':input').trigger('blur');
		var j = 0; // 判断是否有checkbox选中
		var inputArray = document.getElementById("roleEditForm").getElementsByTagName(
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
			AT.postFrm("#roleEditForm", eidtRoleCall_function);
		}
	}
	function eidtRoleCall_function(json){
		var data = eval('(' + json + ')'); 
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
