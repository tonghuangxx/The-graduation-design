<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>达内－NetCTOSS</title>
        <link type="text/css" rel="stylesheet" media="all" href="../styles/global.css" />
        <link type="text/css" rel="stylesheet" media="all" href="../styles/global_color.css" />
        <script language="javascript" type="text/javascript">
            //保存结果的提示
            function showResult() {
                showResultDiv(true);
                window.setTimeout("showResultDiv(false);", 3000);
            }
            function showResultDiv(flag) {
                var divResult = document.getElementById("save_result_info");
                if (flag)
                    divResult.style.display = "block";
                else
                    divResult.style.display = "none";
            }

            //切换资费类型
            function feeTypeChange(type) {
                var inputArray = document.getElementById("main").getElementsByTagName("input");
                if (type == 1) {
                    inputArray[5].readonly = true;
                    inputArray[5].value = "";
                    inputArray[5].className += " readonly";
                    inputArray[6].readonly = false;
                    inputArray[6].className = "width100";
                    inputArray[7].readonly = true;
                    inputArray[7].className += " readonly";
                    inputArray[7].value = "";
                }
                else if (type == 2) {
                    inputArray[5].readonly = false;
                    inputArray[5].className = "width100";
                    inputArray[6].readonly = false;
                    inputArray[6].className = "width100";
                    inputArray[7].readonly = false;
                    inputArray[7].className = "width100";
                }
                else if (type == 3) {
                    inputArray[5].readonly = true;
                    inputArray[5].value = "";
                    inputArray[5].className += " readonly";
                    inputArray[6].readonly = true;
                    inputArray[6].value = "";
                    inputArray[6].className += " readonly";
                    inputArray[7].readonly = false;
                    inputArray[7].className = "width100";
                }
            }
        </script>
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
            <div id="save_result_info" class="save_success">保存成功！</div>
            <form action="../fee/feeModi" method="post" class="main_form">
                <div class="text_info clearfix"><span>资费ID：</span></div>
                <div class="input_info"><input type="text" class="readonly" readonly value="${fee.id}" name="fee.id"/></div>
                <div class="text_info clearfix"><span>资费名称：</span></div>
                <div class="input_info">
                    <input type="text" class="width300" value="${fee.name}" id="feeName" name="fee.name"/>
                    <span class="required">*</span>
                    <div class="validate_msg_short" id="nameLabel">2长度以上的字母、数字、汉字和下划线的组合</div>
                </div>
                <div class="text_info clearfix"><span>资费类型：</span></div>
                <div class="input_info fee_type">
                    <input type="radio" name="radFeeType" id="monthly" onclick="feeTypeChange(1);" />
                    <label for="monthly">包月</label>
                    <input type="radio" name="radFeeType" checked="checked" id="package" onclick="feeTypeChange(2);" />
                    <label for="package">套餐</label>
                    <input type="radio" name="radFeeType" id="timeBased" onclick="feeTypeChange(3);" />
                    <label for="timeBased">计时</label>
                </div>
                <div class="text_info clearfix"><span>基本时长：</span></div>
                <div class="input_info">
                    <input type="text" class="width100" value="${fee.base_duration}" id="base_duration" name="fee.base_duration"/>
                    <span class="info">小时</span>
                    <span class="required">*</span>
                    <div class="validate_msg_long  validate_msg_long1" style="width:300px;">1-600之间的整数</div>
                </div>
                <div class="text_info clearfix"><span>基本费用：</span></div>
                <div class="input_info">
                    <input type="text"  class="width100" value="${fee.base_cost}" id="base_cost" name="fee.base_cost"/>
                    <span class="info">元</span>
                    <span class="required">*</span>
                    <div class="validate_msg_long validate_msg_long2" style="width:300px;">0-99999.99之间的数值</div>
                </div>
                <div class="text_info clearfix"><span>单位费用：</span></div>
                <div class="input_info">
                    <input type="text" class="width100" value="${fee.unit_cost }" id="unit_cost" name="fee.unit_cost"/>
                    <span class="info">元/小时</span>
                    <span class="required">*</span>
                    <div class="validate_msg_long validate_msg_long3" style="width:300px;">0-99999.99之间的数值</div>
                </div>   
                <div class="text_info clearfix"><span>资费说明：</span></div>
                <div class="input_info_high">
                    <textarea class="width300 height70" id="descr" name="fee.descr">${fee. descr}
                    </textarea>
                    <div class="validate_msg_short"  id="desc_msg">5长度以上的字母、数字、汉字和下划线的组合</div>
                </div>                    
                <div class="button_info clearfix">
                    <input type="submit" value="保存" class="btn_save"  id="send"/>
                    <input type="reset" value="取消" class="btn_save" />
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
$(function() {
//资费名称输入框失去焦点
	$('#feeName').blur(function(){
		var feeName=$.trim($('#feeName').val());
		//检查是否为空
		if(feeName==''){
			$('#nameLabel').addClass("error_msg").html("资费名称不能为空");
			return;
		}else{
					$('#nameLabel').removeClass('error_msg').html('2长度以上的字母、数字、汉字和下划线的组合');
		}
	});
	//基本时长失去焦点
	$('#base_duration').blur(function(){
		var base_duration=$.trim($('#base_duration').val());
		if(base_duration==""){
			$('.validate_msg_long1').addClass("error_msg");
			return ;
		}
		//判断资本费用输入的值是否在1到600之间
		if(parseInt(base_duration)<1||parseInt(base_duration)>600){
			$('.validate_msg_long1').addClass("error_msg");
		}else{
			$('.validate_msg_long1').removeClass('error_msg');
		}
	});
	//基本费用失去焦点
	$('#base_cost').blur(function(){
		var base_cost=$.trim($('#base_cost').val());
		if(base_cost==""){
		$('.validate_msg_long2').addClass("error_msg");
			return ;
		}
		//判断基本费用是否在0到99999.99之间
		if(parseFloat(base_cost)<0||parseFloat(base_cost)>99999.99){
			$('.validate_msg_long2').addClass("error_msg");
		}else{
			$('.validate_msg_long2').removeClass('error_msg');
		}
	});
	//单位费用输入框失去焦点
	$('#unit_cost').blur(function(){
		var unit_cost=$.trim($('#unit_cost').val());
		if(unit_cost==""){
			$('.validate_msg_long3').addClass("error_msg");
			return;
		}
		//判断单位费用是否在0到99999.99之间
		if(parseFloat(unit_cost)<0||parseFloat(unit_cost)>99999.99){
			$('.validate_msg_long3').addClass("error_msg");
		}else{
			$('.validate_msg_long3').removeClass('error_msg');
		}
	});
	$('#descr').blur(function(){
		var descr=$.trim($('#descr').val());
		if($.trim(descr).length<5){
			$('#desc_msg').addClass('error_msg');
		}else{
			$("#desc_msg").removeClass('error_msg');
		}
	});
	$('#send').click(function(){
		        //触发所有输入框的点击事件
  $(':input').trigger('blur');
  if($('form div').hasClass("error_msg")){
     showResultDiv(true);
     window.setTimeout("showResultDiv(false);", 3000);
    	return false;
	  }else{
    showResultDiv(false);
    return true;
       	 }
	});
});
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
</script>   
    </body>
</html>
