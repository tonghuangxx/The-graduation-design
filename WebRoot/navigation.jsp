 <%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%@ include file="/taglibs.jsp" %> 
 <!--Logo区域开始-->
        <div id="header">
            <img src="<%=request.getContextPath() %>/images/logo.png" alt="logo" class="left"/>
            <span>当前账号：<b><s:property value="#session.userinfo.admin_code"/></b></span>
            <a href="../login/loginOut">[退出]</a>
        </div>
        <!--Logo区域结束-->
<!--导航区域开始-->
<div id="navi">
	<ul id="menu">
		<li><a href="<%=request.getContextPath() %>/admin/main" class="index_on"></a></li>
        <li><a href="../control/roleListControl?m.id=1&operation=r" class="role_off"></a></li>
        <li><a href="<%=request.getContextPath() %>/user/list" class="admin_off"></a></li>
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