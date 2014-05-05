<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>达内－NetCTOSS</title>
        <link type="text/css" rel="stylesheet" media="all" href="../styles/global.css" />
        <link type="text/css" rel="stylesheet" media="all" href="../styles/global_color.css" /> 
        	<script type="text/javascript" src="../js/jquery-1.4.3.js">
</script>
        <script language="javascript" type="text/javascript">
            function deleteRole(id) {
                var r = window.confirm("确定要删除此角色吗？");
                if(r){
                			location.href='../control/roleDelControl?m.id=1&operation=d&adminId='+id;
                document.getElementById("operate_result_info").style.display = "block";
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
            <form action="" method="post">
                <!--查询-->
                <div class="search_add">
                    <input type="button" value="增加" class="btn_add" onclick="location.href='../control/roleAddControl?m.id=1&operation=c';" />
                </div>  
                <!--删除的操作提示-->
                <div id="operate_result_info" class="operate_success">
                    <img src="../images/close.png" onclick="this.parentNode.style.display='none';" />
                    删除成功！
                </div> <!--删除错误！该角色被使用，不能删除。-->
                <!--数据区域：用表格展示数据-->     
                <div id="data">                      
                    <table id="datalist">
                        <tr>                            
                            <th>用户 ID</th>
                            <th>用户名称</th>
                            <th class="width600">拥有的角色</th>
                            <th class="td_modi"></th>
                        </tr> 
                        <s:iterator value="roleList" var="c">
                        <tr>
                            <td><s:property value="#c.adminInfo.id"/> </td>
                            <td><s:property value="#c.adminInfo.admin_code"/> </td>
                            <td>
                            <s:iterator value="#c.role">
                            <s:property value="role_name"/>
                            </s:iterator>
                            </td>
                            <td>
                                <input type="button" value="修改" class="btn_modify" onclick="location.href='../control/roleUpdateControl?m.id=1&operation=u&adminId=${c.adminInfo.id}';"/>
                                <input type="button" value="删除" class="btn_delete" onclick="deleteRole(${c.adminInfo.id});" />
                            </td>
                        </tr>
                        </s:iterator>                     
                    </table>
                </div> 
                <!--分页-->
                <div id="pages">
        	        <s:if test="pageNo>1"><a href="roleList?pageNo=${pageNo-1}">上一页</a></s:if>
                <s:else>上一页</s:else>
        	        <s:iterator value="new int[totalPages]" status="i">
        	        <s:if test="#i.count==pageNo">
        	           <a href="roleList?pageNo=<s:property value='#i.count'/>" class="current_page"><s:property value="#i.count"/></a>
        	        </s:if>
        	        <s:else>
        	          <a href="roleList?pageNo=<s:property value='#i.count'/>"><s:property value="#i.count"/> </a>
        	        </s:else>
        	        </s:iterator>
        	        <s:if test="pageNo<totalPages">
        	        <a href="roleList?pageNo=${pageNo+1}">下一页</a>
        	        </s:if>
        	        <s:else>下一页</s:else>
                </div>
            </form>
        </div>
        <!--主要区域结束-->
        <div id="footer">
            <p>[源自北美的技术，最优秀的师资，最真实的企业环境，最适用的实战项目]</p>
            <p>版权所有(C)加拿大达内IT培训集团公司 </p>
        </div>
    </body>
</html>
