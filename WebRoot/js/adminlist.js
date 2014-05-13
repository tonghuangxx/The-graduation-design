$(function(){
	$.post("../user/listData",function(data){
		$("#datapages").html(data);
	});
});


//显示角色详细信息
function showDetail(flag, a) {
	var detailDiv = a.parentNode.getElementsByTagName("div")[0];
	if (flag) {
		detailDiv.style.display = "block";
	} else
		detailDiv.style.display = "none";
}
//重置密码
function resetPwd() {
	var j = 0; //判断是否有checkbox选中
	//                document.getElementById("operate_result_info").style.display = "block";
	var inputArray = document.getElementById("datalist").getElementsByTagName(
			"input");
	for ( var i = 1; i < inputArray.length; i++) {
		if (inputArray[i].type == "checkbox") {
			if (inputArray[i].checked) {
				j++;
			}
		}
	}
	if (j != 1) {
		alert("请选择一条数据！");
	} else {
		document.getElementById("mainform").action = "../user/uresetPwd";
//		document.getElementById("mainform").submit();
		$('#mainform').submit();
	}
}
//删除
function deleteAdmin(adminId) {
	var r = window.confirm("确定要删除此管理员吗？");
	if (r) {
		$.post("../user/delete",{'adminInfo.id':adminId},function(data){
			AT.postFrm("#searchRorm", callFunction);
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
$(function() {
	if ($('#msg').html() == "") {
		showResultDiv(false);
	} else {
		showResultDiv(true);
		window.setTimeout("showResultDiv(false);", 5000);
	}
	$('#search').click(function(){
		location.href="serachAdminRole?admin_code="+$('#searchAdmin_code').val();
	});
});
/**
 * 显示某一页数据
 * @param pageNum
 * @return
 */
function numberPage(pageNum){
	var href = "../user/listData?pageNum="+pageNum;
	$.post(href,function(data){
		$("#datapages").html(data);
	});
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
function search(){
	AT.postFrm("#searchRorm", callFunction);
}
