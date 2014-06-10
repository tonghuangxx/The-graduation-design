 <%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/taglibs.jsp"  %>
 <div id="save_result_info" class="save_success"></div>
<form action="<%=request.getContextPath() %>/service/editDo" method="post" class="main_form" id="editServiceForm" >
	<input type="hidden" value="${pageNum}" name="pageNum" id="pageNum" />
	<input type="hidden" value="${numPerPage}" name="numPerPage" id="numPerPage" />
	<input value="${service.id }" name="service.id" type="hidden"/>
	<input value="${service.account_id }" name="service.account_id" type="hidden"/>
	<input value="${service.unix_host }" name="service.unix_host" type="hidden"/>
	<input value="${service.login_passwd }" name="service.login_passwd" type="hidden"/>
	<input value="${service.status }" name="service.status" type="hidden"/>
	<input value="${service.create_date }" name="service.create_date" type="hidden"/>
	<input value="${service.pause_date }" name="service.pause_date" type="hidden"/>
	<input value="${service.close_date }" name="service.close_date" type="hidden"/>
	<input value="${service.cost_id }" type="hidden" id="cost_id_hidden"/>
	<!--必填项-->
	<div class="text_info clearfix">
		<span>OS 账号：</span>
	</div>
	<div class="input_info">
		<input type="text" value="${service.os_username }" name="service.os_username" readonly class="readonly" />
	</div>
	<div class="text_info clearfix">
		<span>服务器 IP：</span>
	</div>
	<div class="input_info">
		<input type="text" value="${service.host.host_ip }" readonly class="readonly" />
	</div>
	<div class="text_info clearfix">
		<span>资费类型：</span>
	</div>
	<div class="input_info">
		<select class="width150" name="service.cost_id" id="cost_id">
			<s:iterator value="feeList" var="f">
				<option value="<s:property value="#f.id"/>" <s:if test="service.fee.id==#f.id">selected='selected'</s:if>><s:property value="#f.name"/></option>
			</s:iterator>
		</select>
		<div class="validate_msg_long">
			请修改资费类型，或者取消修改操作。
		</div>
	</div>
	<!--操作按钮-->
	<div class="button_info clearfix">
		<input type="button" value="保存" class="btn_save"
			onclick="to_serviceEditDo();" />
		<input type="button" value="取消" class="btn_save" onclick="to_serviceList();"/>
	</div>


	<p>
		业务说明：
		<br />
		1、修改资费后，点击保存，并未真正修改数据库中的数据；
		<br />
		2、提交操作到资费更新备份表；
		<br />
		3、每月月底由程序自动完成业务所关联的资费；
	</p>

</form>
<script language="javascript" type="text/javascript">

	function to_serviceEditDo(){
		var cost_id_hidden = $("#cost_id_hidden").val();
		var cost_id = $('#cost_id').val();
		if(cost_id_hidden===cost_id){
			$(".validate_msg_long").addClass("error_msg");
			return;
		}else{
			$(".validate_msg_long").removeClass("error_msg");
			AT.postFrm("#editServiceForm", editServiceCall_function);
		}
	}
	function editServiceCall_function(json){
		var data = eval('('+json+')');
		showResultDiv(true,data.message);
		window.setTimeout("showResultDiv(false);", 5000);
	}
	//保存结果的提示
	function showResultDiv(flag,message) {
		var divResult = document.getElementById("save_result_info");
		if (flag) {
			divResult.innerHTML=message;
			divResult.style.display = "block";
		} else {
			divResult.style.display = "none";
		}
	}
	function to_serviceList(){
		var pageNum=$("#pageNum").val();
		var numPerPage=$("#numPerPage").val();
		var href = "../service/listData?pageNum="+pageNum+"&numPerPage="+numPerPage;
		$.post(href,function(data){
			$("#main").html(data);
		});
	}
</script>
