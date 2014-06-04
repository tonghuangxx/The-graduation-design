<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/taglibs.jsp"  %>
<form action="" method="">
                <!--查询-->
                <div class="search_add">                        
                    <div>账务账号：<span class="readonly width70">${service.account.login_name }</span></div>                            
                    <div>身份证：<span class="readonly width150">${service.account.idcard_no }</span></div>
                    <div>姓名：<span class="readonly width70">${service.account.real_name }</span></div>
                    <div>计费时间：<span class="readonly width70"><s:date name="bill.bill_month" format="yyyy-MM"/> </span></div>
                    <div>总费用：<span class="readonly width70">${bill.cost }</span></div>
                    <input type="button" value="返回" class="btn_add" onclick="to_listBack();" />
                </div>  
                <!--数据区域：用表格展示数据-->     
                <div id="data">            
                    <table id="datalist">
                    		<tr>
	                            <th class="width70">序号</th>
	                            <th class="width150">OS 账号</th>
	                            <th class="width150">服务器 IP</th>
	                            <th class="width150">时长</th>
	                            <th>费用</th>
	                            <th class="width150">资费</th>
                        	</tr>
                    	<s:iterator status="st" value="billItemList" var="bi">
                    		<tr>
	                            <td><s:property value="#st.count"/></td>
	                            <td><s:property value="#bi.service.os_username"/></td>
	                            <td><s:property value="#bi.service.host.host_ip"/></td>
	                            <td><s:property value="#bi.monthDuration.sofar_duration"/></td>
	                            <td><s:property value="#bi.cost"/></td>
	                            <td><s:property value="#bi.service.fee.name"/></td>                          
                        	</tr>
                    	</s:iterator>
                    </table>
                </div>
</form>
<script>
function to_listBack(){
	var href = "${pageContext.request.contextPath}/bill/listData";
	$.post(href,function(data){
		$("#main").html(data);
	});		
}
</script>