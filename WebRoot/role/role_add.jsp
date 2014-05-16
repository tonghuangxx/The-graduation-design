<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/taglibs.jsp"%>
<div id="save_result_info" class="save_success"><s:property value="addMsg"/></div><!--信息提示-->
            <form action="../role/roleAdd" method="post" class="main_form" id="mainform">
                <div class="text_info clearfix"><span>用户名称：</span></div>
                <div class="input_info">
                    <input type="text" class="width200" name="admin_code" id="admin_code" value=""/>
                    <span class="required">*</span>
                    <div class="validate_msg_medium">不能为空，且为20长度的字母、数字和汉字的组合</div>
                </div>                    
                <div class="text_info clearfix"><span>设置权限：</span></div>
                <div class="input_info_high">
                    <div class="input_info_scroll">
                        <ul>
                        	<s:iterator value="functionList">
	                            <li><input type="checkbox" name="fid" value="8" value="<s:property value="id"/>"/><s:property value="name"/></li>
                        	</s:iterator>
                        </ul>
                    </div>
                    <span class="required">*</span>
                    <div class="validate_msg_tiny">至少选择一个权限</div>
                </div>
                <div class="button_info clearfix">
                    <input type="submit" value="保存" class="btn_save" id="send"/>
                    <input type="button" value="取消" class="btn_save" />
                </div>
</form>
<script type="text/javascript">

$(function(){
		if($('.save_success').html()==""){
      showResultDiv(false);
   }else{
       showResultDiv(true);
       window.setTimeout("showResultDiv(false);", 5000);
        }
//用户名称框的失去焦点事件
$('#admin_code').blur(function(){
var admin_code=$.trim($('#admin_code').val());
	if(admin_code==""){
		$('.validate_msg_medium').addClass("error_msg");
	}else{
		$('.validate_msg_medium').removeClass("error_msg");
	}
});
	$('#send').click(function(){
			$(':input').trigger('blur');
			var j=0;  //判断是否有checkbox选中
			var inputArray=document.getElementById("mainform").getElementsByTagName("input");
			for (var i = 1; i < inputArray.length; i++) {
         if (inputArray[i].type == "checkbox") {
            if(inputArray[i].checked){
              j++;
                    			}
                    	}
             }
             //如果没有选中就不能提交表单
			if(j==0){
					$('.validate_msg_tiny').addClass("error_msg");
					return false;
			}else{
			  	$('.validate_msg_tiny').removeClass("error_msg");
  	if($('form div').hasClass('error_msg')){
		 	return false;
	  	}
					$('#mainform').submit();
			}
	});
});
//保存成功与否的提示消息
     function showResultDiv(flag) {
         var divResult = document.getElementById("save_result_info");
         if (flag)
           divResult.style.display = "block";
         else
           divResult.style.display = "none";
            }
</script>
