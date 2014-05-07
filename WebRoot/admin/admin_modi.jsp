<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>电信计费系统</title>
         <link type="text/css" rel="stylesheet" media="all" href="<%=request.getContextPath() %>/styles/global.css" />
        <link type="text/css" rel="stylesheet" media="all" href="<%=request.getContextPath() %>/styles/global_color.css" /> 
        <script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-1.4.4.min.js"></script>
    </head>
    <body>
        <!--Logo区域开始-->
        <div id="header">
            <img src="../images/logo.png" alt="logo" class="left"/>
            <span>当前账号：<b><s:property value="#session.userinfo.admin_code"/></b></span>
            <a href="../login/loginOut">[退出]</a>         
        </div>
        <!--Logo区域结束-->
        <!--导航区域开始-->
        <jsp:include page="/navigation.jsp"></jsp:include>
        <!--导航区域结束-->
        <!--主要区域开始-->
        <div id="main">     
            <div id="save_result_info" class="save_success"><s:property value="addMsg"/></div>
            <form action="<%=request.getContextPath() %>/user/editDo" method="post" class="main_form" id="mainform">
            <input type="hidden" value="${adminInfo.id}" name="adminInfo.id"/>
                    <div class="text_info clearfix"><span>姓名：</span></div>
                    <div class="input_info">
                        <input type="text" value="${adminInfo.name}" name="adminInfo.name" id="name"/>
                        <span class="required">*</span>
                        <div class="validate_msg_long validate_msg_long1">20长度以内的汉字、字母、数字的组合</div>
                    </div>
                    <div class="text_info clearfix"><span>管理员账号：</span></div>
                    <div class="input_info"><input type="text" readonly="readonly" class="readonly" value="${adminInfo.admin_code}"  /></div>
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
                            <li><input type="checkbox" name="rid" value="1"/>超级管理员</li>
                            <li><input type="checkbox" name="rid" value="8"/>管理员</li>
                            <li><input type="checkbox" name="rid" value="2"/>角色管理员</li>
                            <li><input type="checkbox" name="rid" value="3"/>资费管理员</li>
                            <li><input type="checkbox" name="rid" value="4"/>账务管理员</li>
                            <li><input type="checkbox" name="rid" value="5"/>业务管理员</li>
                            <li><input type="checkbox" name="rid" value="6"/>账单管理员</li>
                            <li><input type="checkbox" name="rid" value="7"/>报表管理员</li>
                            </ul>
                        </div>
                        <span class="required">*</span>
                        <div class="validate_msg_tiny">至少选择一个</div>
                    </div>
                    <div class="button_info clearfix">
                        <input type="submit" value="保存" class="btn_save" id="send" />
                        <input type="button" value="取消" class="btn_save" />
                    </div>
                </form>  
        </div>
        <!--主要区域结束-->
        <div id="footer">
            <span></span>
            <br />
            <span></span>
        </div>
<script type="text/javascript">
        $(function(){
		if($('.save_success').html()==""){
      showResultDiv(false);
   }else{
       showResultDiv(true);
       window.setTimeout("showResultDiv(false);", 5000);
        }
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
    </body>
</html>
