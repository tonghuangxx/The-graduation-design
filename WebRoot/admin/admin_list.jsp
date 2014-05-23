<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/taglibs.jsp" %>
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
<div id="operate_result_info">
	<img src="../images/close.png"
		onclick="this.parentNode.style.display='none';" /><span id="infoSpan"></span>
</div>
<!--数据区域：用表格展示数据-->
<div id="datapages">
	<jsp:include page="/admin/list.jsp"></jsp:include>
</div>
<script>
//重置密码
function resetPwd() {
	var href="../user/updatePwd"
		$.post(href,function(data){
			$("#main").html(data);
		});
}


//显示角色详细信息
function showDetail(flag, a) {
	var detailDiv = a.parentNode.getElementsByTagName("div")[0];
	if (flag) {
		detailDiv.style.display = "block";
	} else
		detailDiv.style.display = "none";
}

//删除
function deleteAdmin(adminId) {
	var r = window.confirm("确定要删除此管理员吗？");
	if (r) {
		$.post("../user/delete",{'adminInfo.id':adminId},function(json){
			var data = eval("("+json+")"); 
        	document.getElementById("infoSpan").innerHTML=data.message;
        	var operate_result_info = document.getElementById("operate_result_info");
        	operate_result_info.style.display = "block";
   			if(data.statusCode=='200'){
   				operate_result_info.className="operate_success";
   	   		}else{
   	   			operate_result_info.className="operate_fail";
   	   		}
			AT.postFrm("#searchForm", callFunction);
		});
	}
}
//全选
function selectAdmins(inputObj) {
	var inputArray = document.getElementById("datalist").getElementsByTagName(
			"input");
	for ( var i = 1; i < inputArray.length; i++) {
		if (inputArray[i].type == "checkbox") {
			inputArray[i].checked = inputObj.checked;
		}
	}
}
function message() {
	var resetPwdMsg = '${resetPwdMsg}';
	if (resetPwdMsg != "${resetPwdMsg}") {
		$('#msg').html(resetPwdMsg);
		document.getElementById("operate_result_info").style.display = "block";
	}
}
//保存结果的提示
function showResultDiv(flag) {
	var divResult = document.getElementById("operate_result_info");
	if (flag) {
		divResult.style.display = "block";
	} else {
		divResult.style.display = "none";
	}
}


/**
* 显示某一页数据
* @param pageNum
* @return
*/
function numberPage(pageNum){
	$("#pageNum").val(pageNum);
	AT.postFrm("#searchForm", callFunction);
}
/**
* 回调函数
* @param data
* @return
*/
function callFunction(data){
	$("#datapages").html(data);
}

/**
* 搜索
* @return
*/
function adminCodeSearch(){
	AT.postFrm("#searchForm", callFunction);
}
/**
* 点击添加
* @return
*/
function addUser(){
	var href="../user/add"
	$.post(href,function(data){
		$("#main").html(data);
	});
}


</script>
