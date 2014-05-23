<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>电信计费系统</title>
       <link type="text/css" rel="stylesheet" media="all" href="<%=request.getContextPath()%>/styles/global.css" />
        <link type="text/css" rel="stylesheet" media="all" href="<%=request.getContextPath()%>/styles/global_color.css" />
        <script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.9.0.min.js"></script>
        <script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/js/tool.js"></script>  
        <script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.validate.js"></script> 
		<style type="text/css">
			.displayOK {
				color: green;
			}
		</style>
	</head>
    <body >
    	<input name="indexList" value="${indexList }" id="indexList" type="hidden"/>
		<!--Logo区域开始-->
		<div id="header">
			<img src="<%=request.getContextPath()%>/images/logo.png" alt="logo" class="left" />
			<span>当前账号：<b><s:property value="#session.user" /> </b> </span>
			<a href="<%=request.getContextPath() %>/login/loginOut">[退出]</a>
		</div>
		<!--Logo区域结束-->
		<!--导航区域开始-->
		<div id="navi">
			<ul id="menu">
				<li>
					<a href="<%=request.getContextPath()%>/user/index" class="index_on"></a>
				</li>
				<s:iterator value="#session.moduleList" var="m">
					<li><a href="javascript:void(0);" class="<s:property value="#m.menucode"/>" onclick="menuChange('<s:property value="#m.url"/>')"></a></li>
				</s:iterator>
<%--				<li>--%>
<%--					<a href="../control/roleListControl?m.id=1&operation=r" class="role_off"></a>--%>
<%--				</li>--%>
<%--				<li>--%>
<%--					<a href="javascript:void(0);" class="admin_off" onclick="menuChange('/user/listData');"></a>--%>
<%--				</li>--%>
<%--				<li>--%>
<%--					<a href="javascript:void(0);" class="fee_off" onclick="menuChange('/fee/listData');"></a>--%>
<%--				</li>--%>
<%--				<li>--%>
<%--					<a href="../control/AccountListControl?m.id=4&operation=r" class="account_off"></a>--%>
<%--				</li>--%>
<%--				<li>--%>
<%--					<a href="service/service_list.html" class="service_off"></a>--%>
<%--				</li>--%>
<%--				<li>--%>
<%--					<a href="bill/bill_list.html" class="bill_off"></a>--%>
<%--				</li>--%>
<%--				<li>--%>
<%--					<a href="report/report_list.html" class="report_off"></a>--%>
<%--				</li>--%>
<%--				<li>--%>
<%--					<a href="javascript:void(0);" class="information_off" onclick="menuChange('/user/updateInfo');"></a>--%>
<%--				</li>--%>
<%--				<li>--%>
<%--					<a href="javascript:void(0);" class="password_off" onclick="menuChange('/user/updatePwd');"></a>--%>
<%--				</li>--%>
			</ul>
		</div>
		<!--导航区域结束-->
		<div id="main" >
<%--			<jsp:include page="/admin/admin_list.jsp"></jsp:include>--%>
		</div>
		<!--主要区域结束-->
        <div id="footer">
            <p></p>
            <p></p>
        </div>
     <script type="text/javascript">

        function menuChange(url){
            $("#main").css("background","#e8f3f8").css("border","5px solid #8ac1db");
        	var href = "<%=request.getContextPath()%>"+url;
			$.post(href,function(data){
				$("#main").html(data);
			});
        }

     </script>   
    </body>
</html>
