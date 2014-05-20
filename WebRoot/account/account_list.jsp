<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/taglibs.jsp"  %>
	<form action="<%=request.getContextPath() %>/account/search" method="post" id="serachAccountForm" >
		<!--查询-->
		<div class="search_add">
			<div>
				身份证：
				<input type="text" value="" class="text_search" name="form.idcard_no"/>
			</div>
			<div>
				姓名：
				<input type="text" class="width70 text_search" value="" name="form.real_name"/>
			</div>
			<div>
				登录名：
				<input type="text" value="" class="text_search" name="form.login_name" />
			</div>
			<div>
				状态：
				<select class="select_search" name="form.status">
					<option value="">全部</option >
					<option value="0">开通</option>
					<option value="1">暂停</option >
					<option value="2">删除</option>
				</select>
			</div>
			<div>
				<input type="button" value="搜索" class="btn_search" onclick="to_serachAccount();"/>
			</div>
			<input type="button" value="增加" class="btn_add" onclick="to_accountAdd();"/>
		</div>
	</form>
		<!--删除等的操作提示-->
		<div id="operate_result_info" class="operate_success">
		<img src="../images/close.png"
			onclick="this.parentNode.style.display='none';" />
	</div>
		<!--数据区域：用表格展示数据-->
<!--数据区域：用表格展示数据-->
<div id="datapages">
	<jsp:include page="/account/list.jsp"></jsp:include>
</div>
<script type="text/javascript">
	
	/**
	 * 显示某一页数据
	 * @param pageNum
	 * @return
	 */
	function numberPage(pageNum){
		$("#pageNum").val(pageNum);
		AT.postFrm("#serachAccountHinForm", callFunction);
	}
	/**
	 * 回调函数
	 * @param data
	 * @return
	 */
	function callFunction(data){
		$("#datapages").html(data);
	}
	function to_serachAccount(){
		AT.postFrm("#serachAccountForm", callFunction);
	}

	function to_accountAdd(){
		var href="../account/add";
		$.post(href,function(data){
			$("#main").html(data);
		});
	}
</script>