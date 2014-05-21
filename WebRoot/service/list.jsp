<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/taglibs.jsp"%>
<form action="<%=request.getContextPath() %>/service/search" method="post" id="serachServiceHinForm" >
		<input type="hidden" value="${pageNum}" name="pageNum" id="pageNum" />
		<input type="hidden" value="${numPerPage}" name="numPerPage" id="numPerPage" />
		<input type="hidden" value="${form.os_username }" class="text_search" name="form.os_username"/>
		<input type="hidden" value="${form.host.host_ip }" class="text_search" name="form.host.host_ip" />
		<input type="hidden" value="${form.account.idcard_no }" class="text_search" name="form.account.idcard_no" />
		<input type="hidden" value="${form.status }" class="text_search" name="form.status" />
</form>
<div id="data">
	<table id="datalist">
		<tr>
			<th class="width50">
				序号
			</th>
			<th class="width150">
				身份证
			</th>
			<th class="width70">
				姓名
			</th>
			<th>
				OS 账号
			</th>
			<th class="width50">
				状态
			</th>
			<th class="width100">
				服务器 IP
			</th>
			<th class="width100">
				资费
			</th>
			<th class="width200"></th>
		</tr>
			<s:iterator value="serviceList" status="st">
		<tr>
			<td>
				<s:property value="#st.count"/>
			</td>
			<td>
				<a href="javascript:void(0)" onclick="to_serviceDetail('<s:property value="id"/>');"><s:property value="account.idcard_no"/></a>
			</td>
			<td>
				<s:property value="account.real_name"/>
			</td>
			<td>
				<s:property value="os_username"/>
			</td>
			<td>
				<s:if test='status=="0"'>开通</s:if>
				<s:elseif test='status=="1"'>暂停</s:elseif>
				<s:elseif test='stauts=="2"'>删除</s:elseif>
			</td>
			<td>
				<s:property value="host.host_ip"/>
			</td>
			<td>
				<a class="summary" onmouseover="showDetail(true,this);"
					onmouseout="showDetail(false,this);"><s:property value="fee.name"/></a>
				<!--浮动的详细信息-->
				<div class="detail_info">
					<s:property value="fee.descr"/>
				</div>
			</td>
			<td class="td_modi">
				<input type="button" value="暂停" class="btn_pause"
					onclick="setState();" />
				<input type="button" value="修改" class="btn_modify"
					onclick="location.href='service_modi.html';" />
				<input type="button" value="删除" class="btn_delete"
					onclick="deleteAccount();" />
			</td>
		</tr>
			</s:iterator>
	</table>
	<p>
		业务说明：
		<br />
		1、创建即开通，记载创建时间；
		<br />
		2、暂停后，记载暂停时间；
		<br />
		3、重新开通后，删除暂停时间；
		<br />
		4、删除后，记载删除时间，标示为删除，不能再开通、修改、删除；
		<br />
		5、业务账号不设计修改密码功能，由用户自服务功能实现；
		<br />
		6、暂停和删除状态的账务账号下属的业务账号不能被开通。
	</p>
</div>
<!--分页-->
<div id="pages">
	<s:if test="pageNum>1">
		<a href="javascript:void(0);" style="color: green;"
			onclick="numberPage('${pageNum-1}');">上一页</a>
	</s:if>
	<s:else>上一页</s:else>
	<s:iterator value="new int[pageCount]" status="i">
		<s:if test="#i.count==pageNum">
			<a href="javascript:void(0);" class="current_page"
				style="color: green;"
				onclick="numberPage('<s:property value='#i.count'/>');"><s:property
					value="#i.count" /> </a>
		</s:if>
		<s:else>
			<a href="javascript:void(0);" style="color: green;"
				onclick="numberPage('<s:property value='#i.count'/>');"><s:property
					value="#i.count" /> </a>
		</s:else>
	</s:iterator>
	<s:if test="pageNum<pageCount">
		<a href="javascript:void(0);" style="color: green;"
			onclick="numberPage('${pageNum+1}');">下一页</a>
	</s:if>
	<s:else>下一页</s:else>
</div>
<script type="text/javascript">
function to_serviceDetail(id){
	var pageNum=$("#pageNum").val();
	var numPerPage=$("#numPerPage").val();
	var href = "../service/detail?service.id="+id+"&pageNum="+pageNum+"&numPerPage="+numPerPage;
	$.post(href,function(data){
		$("#main").html(data);
	});
}

/**
 * 显示某一页数据
 * @param pageNum
 * @return
 */
function numberPage(pageNum){
	$("#pageNum").val(pageNum);
	AT.postFrm("#serachServiceHinForm", callFunction);
}

</script>