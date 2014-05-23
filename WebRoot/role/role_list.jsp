<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<form action="<%=request.getContextPath() %>/role/list" method="post" id="roleForm">
	<input type="hidden" value="${ pageNum}" name="pageNum" id="pageNum" />
	<input type="hidden" value="${numPerPage}" name="numPerPage" id="numPerPage" />
</form>
	<div class="search_add">
		<input type="button" value="增加" class="btn_add"
			onclick="to_roleAdd();" />
	</div>
	<!--删除的操作提示-->
	<div id="operate_result_info">
		<img src="../images/close.png" onclick="this.parentNode.style.display='none';" /><span id="infoSpan"></span></div>
	<!--删除错误！该角色被使用，不能删除。-->
<div id="datapages">
	<jsp:include page="/role/list.jsp"></jsp:include>
</div>
<script language="javascript" type="text/javascript">
            function deleteRole(id) {
                var r = window.confirm("确定要删除此角色吗？");
                if(r){
                	$.post("../role/delete",{'role.id':id},function(json){
                		var data = eval("("+json+")"); 
                    	document.getElementById("infoSpan").innerHTML=data.message;
                    	var operate_result_info = document.getElementById("operate_result_info");
                    	operate_result_info.style.display = "block";
               			if(data.statusCode=='200'){
               				operate_result_info.className="operate_success";
               	   		}else{
               	   			operate_result_info.className="operate_fail";
               	   		}
            			AT.postFrm("#roleForm", callFunction);
            		});
                }
            }
            /**
             * 回调函数
             * @param data
             * @return
             */
            function callFunction(data){
            	$("#datapages").html(data);
            }
            function to_roleAdd(){
            	var href="../role/add"
            		$.post(href,function(data){
            			$("#main").html(data);
            		});
            }
</script>

