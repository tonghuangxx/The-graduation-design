<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
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
        <div id="main">      
            <!--保存操作后的提示信息：成功或者失败-->      
            <div id="save_result_info" class="save_success"><s:property value="addMsg"/></div><!--保存失败，旧密码错误！-->
            <form action="resetPwd" method="post" class="main_form">
                <div class="text_info clearfix"><span>旧密码：</span></div>
                <div class="input_info">
                    <input type="password" class="width200"  name="oldPwd" id="oldPwd"/><span class="required">*</span>
                    <div class="validate_msg_medium validate_msg_medium1" >
                    <span style="font-size: 16px;color:red;" id='msg'><s:property value="resetPwdMsg"/></span>
                    </div>
                </div>
                <div class="text_info clearfix"><span>新密码：</span></div>
                <div class="input_info">
                    <input type="password"  class="width200" id="pwd" name="pwd"/><span class="required">*</span>
                    <div class="validate_msg_medium validate_msg_medium2" >4-8长度的字母、数字和下划线的组合</div>
                </div>
                <div class="text_info clearfix"><span>重复新密码：</span></div>
                <div class="input_info">
                    <input type="password" class="width200"  id="rpwd"/><span class="required">*</span>
                    <div class="validate_msg_medium validate_msg_medium3">4-8长度的字母、数字和下划线的组合</div>
                </div>
                <div class="button_info clearfix">
                    <input type="submit" value="保存" class="btn_save" id="send" />
                    <input type="reset" value="取消" class="btn_save" />
                </div>
            </form>  
        </div>
        <!--主要区域结束-->
        <div id="footer">
            <p>[源自北美的技术，最优秀的师资，最真实的企业环境，最适用的实战项目]</p>
            <p>版权所有(C)加拿大达内IT培训集团公司 </p>
        </div>
 <script type="text/javascript" src="../js/jquery-1.4.3.js">
</script>
<script type="text/javascript">
		     //保存结果的提示
function showResultDiv(flag) {
  var divResult = document.getElementById("save_result_info");
  if (flag){
     divResult.style.display = "block";
     }
  else{
     divResult.style.display = "none";
  	}
}

$(function(){
if($('.save_success').html()==""){
      showResultDiv(false);
   }else{
       showResultDiv(true);
       window.setTimeout("showResultDiv(false);", 5000);
        }
$('#oldPwd').blur(function(){
	if($('#oldPwd').val()==""){
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
	$('#send').click(function(){
		$(':input').trigger('blur');
		if($("form div").hasClass('error_msg')){
			return false;
		}else{
			return true;
		}
	});
});
</script>
    </body>
</html>
