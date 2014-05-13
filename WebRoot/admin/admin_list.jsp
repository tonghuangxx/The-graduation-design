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
        <script language="javascript" type="text/javascript" src="<%=request.getContextPath() %>/js/adminlist.js"></script>
        <script language="javascript" type="text/javascript" src="<%=request.getContextPath() %>/js/tool.js"></script>   
        <script language="javascript" type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.validate.js"></script>    
    </head>
    <body onload="message();">
        <!--Logo区域开始-->
        <div id="header">
            <img src="<%=request.getContextPath() %>/images/logo.png" alt="logo" class="left"/>
            <span>当前账号：<b><s:property value="#session.userinfo.admin_code"/></b></span>
            <a href="../login/loginOut">[退出]</a>
        </div>
        <!--Logo区域结束-->
        <!--导航区域开始-->
        <jsp:include page="/navigation.jsp"></jsp:include>
        <!--导航区域结束-->
        <!--主要区域开始-->
        <div id="main">
                <div class="search_add">
                    <form action="<%=request.getContextPath() %>/user/search" method="post" id="searchRorm" >
                    <input type="hidden" value="${ pageNum}" name="pageNum"/>
                    <input type="hidden" value="${numPerPage}" name="numPerPage"/>
                    <div>
                       	 角色：
                        <select id="selRole" class="select_search">
                        	<option value="">全部</option>
                            <s:iterator value="rList">
                            	<option value="${id }">${role_name }</option>
                            </s:iterator>
                        </select>
                    </div>
                    <div>登录名：<input type="text" value="" class="text_search width200" id="searchAdmin_code"/></div>
                    <div><input type="button" value="搜索" class="btn_search" id="search" onclick="search();"/></div>
                    <input type="button" value="密码重置" class="btn_add" onclick="resetPwd();" />
                    <input type="button" value="增加" class="btn_add" onclick="location.href='<%=request.getContextPath() %>/user/add';" />
                	</form>
                </div>
                <!--删除和密码重置的操作提示-->
                <div id="operate_result_info" class="operate_fail" >
                    <img src="../images/close.png" onclick="this.parentNode.style.display='none';" />
                    <span id='msg' ><s:property value="addMsg"/></span>
                </div> 
                <!--数据区域：用表格展示数据-->
                <div id="datapages">     
                    <jsp:include page="/admin/list.jsp"></jsp:include>
                </div>    
        </div>
        <!--主要区域结束-->
        <div id="footer">
            <p></p>
            <p> </p>
        </div>
    </body>
</html>
