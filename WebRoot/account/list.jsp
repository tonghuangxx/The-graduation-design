<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/taglibs.jsp"  %>
<form action="<%=request.getContextPath() %>/account/search" method="post" id="serachAccountHinForm" >
		<input type="hidden" value="${pageNum}" name="pageNum" id="pageNum" />
		<input type="hidden" value="${numPerPage}" name="numPerPage" id="numPerPage" />
		<input type="hidden" value="${form.idcard_no }" class="text_search" name="form.idcard_no"/>
		<input type="hidden" class="width70 text_search" value="${form.real_name }" name="form.real_name"/>
		<input type="hidden" value="${form.login_name }" class="text_search" name="form.login_name" />
		<input type="hidden" value="${form.status }" class="text_search" name="form.status" />
</form>
<div id="data">
	<table id="datalist">
		<tr>
			<th>
				序号
			</th>
			<th>
				姓名
			</th>
			<th class="width150">
				身份证
			</th>
			<th>
				登录名
			</th>
			<th>
				状态
			</th>
			<th class="width150">
				创建日期
			</th>
			<th class="width150">
				上次登录时间
			</th>
			<th class="width200"></th>
		</tr>
		<s:iterator value="accountList" var="l" status="st">
			<tr>
				<td>
					<s:property value="#st.count" />
				</td>
				<td>
					<a href="javascript:void(0);" onclick="to_AccountDetail('<s:property value="#l.id" />')"><s:property value="#l.real_name" /></a>
				</td>
				<td>
					<s:property value="#l.idcard_no" />
				</td>
				<td>
					<s:property value="#l.login_name" />
				</td>
				<td>
					<s:if test='#l.status=="0"'>开通</s:if>
					<s:if test='#l.status=="1"'>暂停</s:if>
					<s:if test='#l.status=="2"'>删除</s:if>
				</td>
				<td>
					<s:date name="#l.create_date" format="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<s:date name="#l.last_login_time" format="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td class="td_modi">
					<s:if test='#l.status=="0"'>
						<input type="button" value="暂停" class="btn_pause" onclick="stop('<s:property value="#l.id" />');" />
						<input type="button" value="修改" class="btn_modify" onclick="to_accountEdit('<s:property value="#l.id" />')" disabled="disabled" />
						<input type="button" value="删除" class="btn_delete" onclick="deleteAccount('<s:property value="#l.id" />');" disabled="disabled" />
					</s:if>
					<s:if test='#l.status=="1"'>
						<input type="button" value="开通" class="btn_start" onclick="start('<s:property value="#l.id" />');" />
						<input type="button" value="修改" class="btn_modify" onclick="to_accountEdit('<s:property value="#l.id" />')"  />
						<input type="button" value="删除" class="btn_delete" onclick="deleteAccount('<s:property value="#l.id" />');"  />
					</s:if>
					<s:if test='#l.status=="2"'>
					</s:if>
				</td>
			</tr>
		</s:iterator>
	</table>
	<p>
		业务说明：
		<br />
		1、创建则开通，记载创建时间；
		<br />
		2、暂停后，记载暂停时间；
		<br />
		3、重新开通后，删除暂停时间；
		<br />
		4、删除后，记载删除时间，标示为删除，不能再开通、修改、删除；
		<br />
		5、暂停账务账号，同时暂停下属的所有业务账号；
		<br />
		6、暂停后重新开通账务账号，并不同时开启下属的所有业务账号，需要在业务账号管理中单独开启；
		<br />
		7、删除账务账号，同时删除下属的所有业务账号。
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
					value="#i.count" />
			</a>
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
function to_AccountDetail(id){
	var pageNum=$("#pageNum").val();
	var numPerPage=$("#numPerPage").val();
	var href = "../account/detail?account.id="+id+"&pageNum="+pageNum+"&numPerPage="+numPerPage;
	$.post(href,function(data){
		$("#main").html(data);
	});
}
function to_accountEdit(id){
	var href="../account/edit?account.id="+id;
	$.post(href,function(data){
		$("#main").html(data);
	});
}
//删除
function deleteAccount() {
	var r = window.confirm("确定要删除此账务账号吗？\r\n删除后将不能恢复，且会删除其下属的所有业务账号。");
	if (r) {
		$.post("../fee/start",{'fee.id':id},function(data){
			AT.postFrm("#sortFeeForm", callFunction);
		});
	}	
}
//暂停
function stop(id) {
	var r = window.confirm("确定要暂停此账务账号吗？");
	if (r) {
		$.post("../account/stop",{'account.id':id},function(data){
			AT.postFrm("#serachAccountHinForm", callFunction);
		});
	}	
}
//开启
function start(id) {
	var r = window.confirm("确定要开启此账务账号吗？");
	if (r) {
		$.post("../account/start",{'account.id':id},function(data){
			AT.postFrm("#serachAccountHinForm", callFunction);
		});
	}	
}
</script>
