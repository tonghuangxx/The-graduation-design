<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>达内－NetCTOSS</title>
        <link type="text/css" rel="stylesheet" media="all" href="../styles/global.css" />
        <link type="text/css" rel="stylesheet" media="all" href="../styles/global_color.css" />
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
        <div id="navi">
            <ul id="menu">
                <li><a href="../control/main" class="index_on"></a></li>
                <li><a href="../control/roleListControl?m.id=1&operation=r" class="role_off"></a></li>
                <li><a href="../control/AdminInfoListControl?m.id=7&operation=r" class="admin_off"></a></li>
                <li><a href="../control/feeListControl?m.id=2&operation=r" class="fee_off"></a></li>
                <li><a href="../control/AccountListControl?m.id=4&operation=r" class="account_off"></a></li>
                <li><a href="service/service_list.html" class="service_off"></a></li>
                <li><a href="bill/bill_list.html" class="bill_off"></a></li>
                <li><a href="report/report_list.html" class="report_off"></a></li>
                <li><a href="../user/rupdateAdminInfo" class="information_off"></a></li>
                <li><a href="../user/toResetPwd" class="password_off"></a></li>
            </ul>
        </div>
        <!--导航区域结束-->
        <!--主要区域开始-->
        <div id="main">           
            <!--保存操作后的提示信息：成功或者失败-->
            <div id="save_result_info" class="save_success"><s:property value="addMsg"/></div>
            <form action="../role/roleUpdate" method="post" class="main_form" id="mainform">
                <div class="text_info clearfix"><span>用户名称：</span></div>
                <div class="input_info">
                    <input type="text" class="width200" value="${admin_code}" name="admin_code" readonly="readonly"/>
                    <input type="hidden" value="${adminId}" name="adminId"/>
                    <span class="required">*</span>
                    <div class="validate_msg_medium">不能为空，且为20长度的字母、数字和汉字的组合</div>
                </div>                    
                <div class="text_info clearfix"><span>设置权限：</span></div>
                <div class="input_info_high">
                    <div class="input_info_scroll">
                        <ul>
                            <li><input type="checkbox" name="rid" value="8"/>管理员管理</li>
                            <li><input type="checkbox" name="rid" value="2"/>角色管理</li>
                            <li><input type="checkbox" name="rid" value="3"/>资费管理</li>
                            <li><input type="checkbox" name="rid" value="4"/>账务账号</li>
                            <li><input type="checkbox" name="rid" value="5"/>业务账号</li>
                            <li><input type="checkbox" name="rid" value="6"/>账单</li>
                            <li><input type="checkbox" name="rid" value="7"/>报表</li>
                        </ul>
                    </div>
                    <span class="required">*</span>
                    <div class="validate_msg_tiny">至少选择一个权限</div>
                </div>
                <div class="button_info clearfix">
                    <input type="submit" value="保存" class="btn_save"  id="send"/>
                    <input type="button" value="取消" class="btn_save" />
                </div>
            </form> 
        </div>
        <!--主要区域结束-->
        <div id="footer">
            <span>[源自北美的技术，最优秀的师资，最真实的企业环境，最适用的实战项目]</span>
            <br />
            <span>版权所有(C)加拿大达内IT培训集团公司 </span>
        </div>
        <script type="text/javascript" src="../js/jquery-1.4.3.js">
</script>
<script type="text/javascript">

$(function(){
		if($('.save_success').html()==""){
      showResultDiv(false);
   }else{
       showResultDiv(true);
       window.setTimeout("showResultDiv(false);", 5000);
        }
	$('#send').click(function(){
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
