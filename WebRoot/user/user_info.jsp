<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<!--保存操作后的提示信息：成功或者失败-->
<div id="save_result_info" class="save_success" style="display:none"></div>
<form action="updateAdminInfo" method="post" class="main_form">
	<input type="hidden" value="${ai.id}" name="ai.id" />
	<div class="text_info clearfix">
		<span>管理员账号：</span>
	</div>
	<div class="input_info">
		<input type="text" readonly="readonly" class="readonly"
			value="${ai.admin_code}" />
	</div>
	<div class="text_info clearfix">
		<span>角色：</span>
	</div>
	<div class="input_info">
		<input type="text" readonly="readonly" class="readonly width400"
			value="${roList}" />
	</div>
	<div class="text_info clearfix">
		<span>姓名：</span>
	</div>
	<div class="input_info">
		<input type="text" value="${ai.name}" name="ai.name" />
		<span class="required">*</span>
		<div class="validate_msg_long ">
			20长度以内的汉字、字母的组合
		</div>
	</div>
	<div class="text_info clearfix">
		<span>电话：</span>
	</div>
	<div class="input_info">
		<input type="text" class="width200" value="${ai.telphone}"
			name="ai.telphone" />
		<div class="validate_msg_medium">
			电话号码格式：手机或固话
		</div>
	</div>
	<div class="text_info clearfix">
		<span>Email：</span>
	</div>
	<div class="input_info">
		<input type="text" class="width200" value="${ai.email}"
			name="ai.email" />
		<div class="validate_msg_medium">
			50长度以内，符合 email 格式
		</div>
	</div>
	<div class="text_info clearfix">
		<span>创建时间：</span>
	</div>
	<div class="input_info">
		<input type="text" readonly="readonly" class="readonly"
			value="${ ai.enrolldate}" />
	</div>
	<div class="button_info clearfix">
		<input type="submit" value="保存" class="btn_save"
			onclick="showResult();" />
		<input type="reset" value="取消" class="btn_save" />
	</div>
</form>
