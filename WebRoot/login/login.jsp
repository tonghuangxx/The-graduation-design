<%@ page contentType="text/html; charset=utf-8"%>
<%@ include file="/taglibs.jsp" %>
<%@page isELIgnored="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>电信计费系统</title>
		<link type="text/css" rel="stylesheet" media="all" href="<%=request.getContextPath() %>/styles/global.css" />
		<link type="text/css" rel="stylesheet" media="all" href="<%=request.getContextPath() %>/styles/global_color.css" />
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery-1.4.4.min.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.validate.js"></script>
		<script type="text/javascript" src="<%=request.getContextPath() %>/js/tool.js"></script>
	</head>
	<body class="index">
		<form action="login" method="post" id="mainform" onsubmit="return AT.postFrm(this,login_crdCallback)">
			<div class="login_box">
				<table>
					<tr>
						<td class="login_info">
							账号：
						</td>
						<td colspan="2">
							<input name="adminInfo.admin_code" type="text" class="width150" />
						</td>
						<td class="login_error_info">
							<span class="required">4-8长度的字母、数字和下划线</span>
						</td>
					</tr>
					<tr>
						<td class="login_info">
							密码：
						</td>
						<td colspan="2">
							<input name="adminInfo.password" type="password" class="width150" />
						</td>
						<td>
							<span class="required">4-8长度的字母、数字和下划线</span>
						</td>
					</tr>
					<tr>
						<td class="login_info">
							验证码：
						</td>
						<td class="width70">
							<input name="yzm" type="text" class="width70" id="yzm"/>
						</td>
						<td>
							<img src="<%=request.getContextPath() %>/Kaptcha.jpg" alt="验证码"  title="点击更换"  id='num' style='width:75px;height:33px;' />
						</td>
						<td>
							<span class="required" id="codemsg">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
						</td>
					</tr>
					<tr>
						<td></td>
						<td class="login_button" colspan="2">
							<a href="javascript:;" id="submit"><img src="<%=request.getContextPath() %>/images/login_btn.png" /></a>
<!--							 <input type="image" src="images/login_btn.png"/>-->
						</td>
						<td>
							<span class="required" id="login_message">${message}</span>
						</td>
					</tr>
				</table>
			</div>
		</form>
	<script type="text/javascript">
	$(function(){
	//验证码的变化
		$('#num').click(function(){
			$('#num').get(0).src="<%=request.getContextPath()%>/Kaptcha.jpg?t="+new Date().getTime();
		});
		//验证码输入框失去焦点事件
		$('#yzm').blur(function(){
		var yzm=$('#yzm').val();
		var href="<%=request.getContextPath()%>/login/code";
			$.post(href,{"yzm":yzm},function(data){
				$('#codemsg').html(data);
				return false;
			});
		});
		//点击提交触发失去焦点事件
		$('#submit').click(function(){
			$(':input').trigger('blur');
			var msg=$('#codemsg').html();
			if(msg=="验证码正确"){
				$('#mainform').submit();
			}
		});
	});
	
	function login_crdCallback(json){
		var data = eval('(' + json + ')'); 
		if(data.statusCode==200){
			window.location.href="<%=request.getContextPath()%>/user/index";
		}else{
			$("#login_message").html(data.message);
		}	
	}
	</script>	
	</body>
</html>