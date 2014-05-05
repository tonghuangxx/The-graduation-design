<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
            <a href="../loginOut">[退出]</a>            
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
                <!--排序-->
                <div class="search_add">
                    <div>
                    <s:if test="rentSort=='desc'">
                        <input type="button" value="月租" class="sort_desc" onclick="sort(this);" id="rent"/>
                    </s:if>
                    <s:else>
                    			<input type="button" value="月租" class="sort_asc" onclick="sort(this);" id="rent"/>
                    </s:else>
                    <s:if test="base_costSort=='desc'">
                        <input type="button" value="基费" class="sort_desc" onclick="sort(this);" id="base_cost"/>
                    </s:if>
                    <s:else>
                        <input type="button" value="基费" class="sort_asc" onclick="sort(this);" id="base_cost"/>
                    </s:else>
                    <s:if test="base_durationSort=='desc'">
                        <input type="button" value="时长" class="sort_desc" onclick="sort(this);" id="base_duration"/>
                    </s:if>
                    <s:else>
                        <input type="button" value="时长" class="sort_asc" onclick="sort(this);" id="base_duration"/>
                    </s:else>
                    </div>
                    <input type="button" value="增加" class="btn_add" onclick="location.href='../control/feeAddControl?m.id=2&operation=c';"  />
                </div> 
                <!--启用操作的操作提示-->
                <div id="operate_result_info" class="operate_success">
                    <img src="../images/close.png" onclick="this.parentNode.style.display='none';" />
                  <span id='msg' ><s:property value="msg"/></span>
                </div>    
                <!--数据区域：用表格展示数据-->     
                <div id="data">            
                    <table id="datalist">
                        <tr>
                            <th>资费ID</th>
                            <th class="width100">资费名称</th>
                            <th>基本时长</th>
                            <th>基本费用</th>
                            <th>单位费用</th>
                            <th>创建时间</th>
                            <th>开通时间</th>
                            <th class="width50">状态</th>
                            <th class="width200"></th>
                        </tr> 
                        	<c:forEach items='${feeList}' var='fee'>                    
                        <tr>
                            <td>${fee.id}</td>
                            <td><a href="feeDetail?feeId=${fee.id}">${fee.name}</a></td>
                            <td>${fee.base_duration } 小时</td>
                            <td>${fee.base_cost } 元</td>
                            <td>${fee.unit_cost } 元/小时</td>
                            <td>${fee.creatime}</td>
                            <td>${fee.startime}</td>
                            <td>
                            <c:if test="${fee.status==0}">开通</c:if>
                            <c:if test="${fee.status==1}">暂停</c:if>
                            <c:if test="${fee.status==2}">删除</c:if>
                            </td>
                            <td>
                            <c:if test="${fee.status!=0}">                                
                                <input type="button" value="启用" class="btn_start" onclick="startFee(${fee.id});" />
                                <input type="button" value="修改" class="btn_modify" onclick="location.href='../control/feeModiControl?m.id=2&operation=u&feeId=${fee.id}';" />
                                <input type="button" value="删除" class="btn_delete" onclick="deleteFee(${fee.id});" />
                            </c:if>
                            </td>
                        </tr>
                       </c:forEach> 
                    </table>
                    <p>业务说明：<br />
                    1、创建资费时，状态为暂停，记载创建时间；<br />
                    2、暂停状态下，可修改，可删除；<br />
                    3、开通后，记载开通时间，且开通后不能修改、不能再停用、也不能删除；<br />
                    4、业务账号修改资费时，在下月底统一触发，修改其关联的资费ID（此触发动作由程序处理）
                    </p>
                </div>
                <!--分页-->
                <div id="pages">
                <c:choose>
                <c:when test="${page>1}"><a href="feeList?page=${page-1}">上一页</a></c:when>
                <c:otherwise>上一页</c:otherwise>
                </c:choose>
                <c:forEach begin='1'	end='${totalPages}' var='p'>
                <c:choose>
                <c:when test="${page==p}">
                			<a href="feeList?page=${p}" class="current_page">${p}</a>
                </c:when>
                <c:otherwise>
                			<a href="feeList?page=${p}">${p }</a>
                </c:otherwise>
                </c:choose>
                </c:forEach>
                <c:choose>
                <c:when test="${page<totalPages}">
                 <a href="feeList.action?page=${page+1}">下一页</a>
                </c:when>
                <c:otherwise>
                								下一页
                </c:otherwise>
                </c:choose>
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
		<script type="text/javascript" src="../js/feelist.js">
</script>        
    </body>
</html>
