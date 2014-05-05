<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>达内－NetCTOSS</title>
        <link type="text/css" rel="stylesheet" media="all" href="../styles/global.css" />
        <link type="text/css" rel="stylesheet" media="all" href="../styles/global_color.css" />
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
            <div id="save_result_info" class="save_success"><s:property value="addMsg"/></div>
            <form action="../role/adminAdd" method="post" class="main_form" id="mainform">
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
                        <input type="text" class="width200" id="telphone" name="adminInfo.telphone" value=""/>
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
                            <li><input type="checkbox" name="rid" value="1"/>超级管理员</li>
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
            <span>[源自北美的技术，最优秀的师资，最真实的企业环境，最适用的实战项目]</span>
            <br />
            <span>版权所有(C)加拿大达内IT培训集团公司 </span>
        </div>
        	<script type="text/javascript" src="../js/jquery-1.4.3.js">
</script>
		<script type="text/javascript" src="../js/adminadd.js">
</script>
    </body>
</html>
