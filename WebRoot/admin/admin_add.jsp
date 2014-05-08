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
        <script type="text/javascript" src="<%=request.getContextPath() %>/js/adminadd.js"></script>
        <style type="text/css">
        .displayOK{
        color:green;
        }
        </style>
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
            <form action="<%=request.getContextPath() %>/user/addDo" method="post" class="main_form" id="mainform">
                    <div class="text_info clearfix"><span>姓名：</span></div>
                    <div class="input_info">
                        <input type="text" name="adminInfo.name" value="" id="name"/>
                        <span class="required">*</span>
                        <div class="validate_msg_long" id="nameLabel">2-20长度的汉字、字母、数字的组合</div>
                    </div>
                    <div class="text_info clearfix"><span>管理员账号：</span></div>
                    <div class="input_info">
                        <input type="text"  name="adminInfo.admin_code" value="" id="admin_code"/>
                        <span class="required">*</span>
                        <div class="validate_msg_long" id="adminCodeLabel">4-20长度的字母、数字和下划线的组合</div>
                    </div>
                    <div class="text_info clearfix"><span>密码：</span></div>
                    <div class="input_info">
                        <input type="password"  name="adminInfo.password" value="" id="pwd"/>
                        <span class="required">*</span>
                        <div class="validate_msg_long" id="pwdLabel">4-8长度的字母、数字和下划线的组合</div>
                    </div>
                    <div class="text_info clearfix"><span>重复密码：</span></div>
                    <div class="input_info">
                        <input type="password"  value="" id="rpwd" />
                        <span class="required">*</span>
                        <div class="validate_msg_long" id="rpwdLabel">两次密码必须相同</div>
                    </div>      
                    <div class="text_info clearfix"><span>电话：</span></div>
                    <div class="input_info">
                        <input type="text" class="width200" id="telphone" name="adminInfo.telephone" value=""/>
                        <span class="required">*</span>
                        <div class="validate_msg_medium" id="telphoneLabel">正确的电话号码格式：手机或固话</div>
                    </div>
                    <div class="text_info clearfix"><span>Email：</span></div>
                    <div class="input_info">
                        <input type="text" class="width200" name="adminInfo.email" value="" id="email"/>
                        <span class="required">*</span>
                        <div class="validate_msg_medium" id="emailLabel">50长度以内，正确的 email 格式</div>
                    </div>
                    <div class="text_info clearfix"><span>角色：</span></div>
                    <div class="input_info_high">
                        <div class="input_info_scroll">
                            <ul>
                            <s:iterator value="rList">
                            	<li><input type="checkbox" name="rid" value="${id }"/>${role_name }</li>
                            </s:iterator>
                            </ul>
                        </div>
                        <span class="required">*</span>
                        <div class="validate_msg_tiny" id="roleLabel">至少选择一个</div>
                    </div>
                    <div class="button_info clearfix">
                        <input type="submit" value="保存" class="btn_save" id="send"/>
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
    </body>
</html>
