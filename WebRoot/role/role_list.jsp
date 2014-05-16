<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<form action="" method="post">
	<!--查询-->
	<div class="search_add">
		<input type="button" value="增加" class="btn_add"
			onclick="to_roleAdd();" />
	</div>
	<!--删除的操作提示-->
	<div id="operate_result_info" class="operate_success">
		<img src="../images/close.png" onclick="this.parentNode.style.display='none';" />删除成功！</div>
	<!--删除错误！该角色被使用，不能删除。-->
</form>
<div id="datapages">
	<jsp:include page="/role/list.jsp"></jsp:include>
</div>
<script language="javascript" type="text/javascript">
            function deleteRole(id) {
                var r = window.confirm("确定要删除此角色吗？");
                if(r){
                			location.href='../control/roleDelControl?m.id=1&operation=d&adminId='+id;
                document.getElementById("operate_result_info").style.display = "block";
                }
            }
            function to_roleAdd(){
            	var href="../role/add"
            		$.post(href,function(data){
            			$("#main").html(data);
            		});
            }
</script>

