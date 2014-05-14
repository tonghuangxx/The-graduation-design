<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/taglibs.jsp" %>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/js/adminlist.js"></script>
<div class="search_add">
	<form action="<%=request.getContextPath() %>/user/search" method="post"
		id="searchForm">
		<input type="hidden" value="${ pageNum}" name="pageNum" id="pageNum" />
		<input type="hidden" value="${numPerPage}" name="numPerPage"
			id="numPerPage" />
		<div>
			角色：
			<select id="selRole" class="select_search">
				<option value="">
					全部
				</option>
				<s:iterator value="rList">
					<option value="${id }">
						${role_name }
					</option>
				</s:iterator>
			</select>
		</div>
		<div>
			登录名：
			<input type="text" value="" class="text_search width200"
				id="searchAdmin_code" name="searchAdmin_code" />
		</div>
		<div>
			<input type="button" value="搜索" class="btn_search" id="search"
				onclick="adminCodeSearch();" />
		</div>
		<input type="button" value="密码重置" class="btn_add"
			onclick="resetPwd();" />
		<input type="button" value="增加" class="btn_add" onclick="addUser();" />
	</form>
</div>
<!--删除的操作提示-->
<div id="operate_result_info" class="operate_fail">
	<img src="../images/close.png"
		onclick="this.parentNode.style.display='none';" />
	<span id='msg'></span>
</div>
<!--数据区域：用表格展示数据-->
<div id="datapages">
	<jsp:include page="/admin/list.jsp"></jsp:include>
</div>
