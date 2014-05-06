<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>电信计费系统</title>
        <link type="text/css" rel="stylesheet" media="all" href="../styles/global.css" />
        <link type="text/css" rel="stylesheet" media="all" href="../styles/global_color.css" /> 
        	<script type="text/javascript" src="../js/jquery-1.4.3.js">
</script>
        <script language="javascript" type="text/javascript" src="../js/adminlist.js">
        </script>       
    </head>
    <body onload="message();">
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
            <form  method="post" id="mainform">
                <!--查询-->
                <div class="search_add">
                    <div>
                        角色：
                        <select id="selModules" class="select_search">
                            <option value="-1">全部</option>
                            <option value="1">超级管理员</option>
                            <option value="2">角色管理</option>
                            <option value="8">管理员管理</option>
                            <option value="3">资费管理</option>
                            <option value="4">账务账号</option>
                            <option value="5">业务账号</option>
                            <option value="6">账单管理</option>
                            <option value="7">报表</option>
                        </select>
                    </div>
                    <div>登录名：<input type="text" value="" class="text_search width200" id="searchAdmin_code"/></div>
                    <div><input type="button" value="搜索" class="btn_search" id="search"/></div>
                    <input type="button" value="密码重置" class="btn_add" onclick="resetPwd();" />
                    <input type="button" value="增加" class="btn_add" onclick="location.href='../control/adminAddControl?m.id=7&operation=c';" />
                </div>
                <!--删除和密码重置的操作提示-->
                <div id="operate_result_info" class="operate_fail" >
                    <img src="../images/close.png" onclick="this.parentNode.style.display='none';" />
                    <span id='msg' ><s:property value="addMsg"/></span>
                </div> 
                <!--数据区域：用表格展示数据-->     
                <div id="data">            
                    <table id="datalist">
                        <tr>
                            <th class="th_select_all">
                                <input type="checkbox" onclick="selectAdmins(this);" />
                                <span>全选</span>
                            </th>
                            <th>序号</th>
                            <th>姓名</th>
                            <th>登录名</th>
                            <th>电话</th>
                            <th>电子邮件</th>
                            <th>授权日期</th>
                            <th class="width100">拥有角色</th>
                            <th></th>
                        </tr>                      
                        <s:iterator value="dataList" var="l" status="st">
                        <tr>
                            <td><input type="checkbox" name="adminId" value="<s:property value="#l.id"/>"/></td>
                            <td><s:property value="#st.count"/> </td>
                            <td><s:property value="#l.name"/></td>
                            <td><s:property value="#l.admin_code"/> </td>
                            <td><s:property value="#l.telephone"/> </td>
                            <td><s:property value="#l.email"/> </td>
                            <td><s:date name="#l.enrolldate" format="yyyy-MM-dd HH:mm:ss"/> </td>
                            <td>
                                <a class="summary"  onmouseover="showDetail(true,this);" onmouseout="showDetail(false,this);">管理员管理</a>
                                <!--浮动的详细信息-->
                                <div class="detail_info">
                                <s:iterator value="#l.roleList" var="r">
                                    <s:property value="#r.role_name"/>
                                </s:iterator>
                                </div>
                            </td>
                            <td class="td_modi">
                                <input type="button" value="修改" class="btn_modify" onclick="location.href='../control/adminUpdateControl?m.id=7&operation=u&adminId=';" />
                                <input type="button" value="删除" class="btn_delete" onclick="deleteAdmin();" />
                            </td>
                        </tr>
                          </s:iterator>
                    </table>
                </div>
                <!--分页-->
                <div id="pages">
        	        <s:if test="pageNum>1"><a href="<%=request.getContextPath() %>/user/list?pageNum=${pageNum-1}">上一页</a></s:if>
                <s:else>上一页</s:else>
        	        <s:iterator value="new int[pageCount]" status="i">
        	        <s:if test="#i.count==pageNum">
        	           <a href="<%=request.getContextPath() %>/user/list?pageNum=<s:property value='#i.count'/>" class="current_page"><s:property value="#i.count"/></a>
        	        </s:if>
        	        <s:else>
        	          <a href="<%=request.getContextPath() %>/user/list?pageNum=<s:property value='#i.count'/>"><s:property value="#i.count"/> </a>
        	        </s:else>
        	        </s:iterator>
        	        <s:if test="pageNum<pageCount">
        	        <a href="<%=request.getContextPath() %>/user/list?pageNum=${pageNum+1}">下一页</a>
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
               	<script type="text/javascript" src="../js/jquery-1.4.3.js">
</script>
    </body>
</html>
