<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/taglibs.jsp"  %>
            <form action="<%=request.getContextPath() %>/service/search" method="post" id="searchServiceForm">
                <!--查询-->
                <div class="search_add">                        
                    <div>OS 账号：<input type="text" value="" class="width100 text_search" name="form.os_username"/></div>                            
                    <div>服务器 IP：<input type="text" value="" class="width100 text_search" name="form.host.host_ip"/></div>
                    <div>身份证：<input type="text"  value="" class="text_search" name="form.account.idcard_no" /></div>
                    <div>状态：
                        <select class="select_search" name="form.status">
                            <option value="">全部</option>
                            <option value="0">开通</option>
                            <option value="1">暂停</option>
                            <option value="2">删除</option>
                        </select>
                    </div>
                    <div><input type="button" value="搜索" class="btn_search" onclick="to_searchService();"/></div>
                    <input type="button" value="增加" class="btn_add" onclick="location.href='service_add.html';" />
                </div>  
               </form>
                <!--删除的操作提示-->
                <div id="operate_result_info" class="operate_success">
                    <img src="../images/close.png" onclick="this.parentNode.style.display='none';" />
                </div>   
                <!--数据区域：用表格展示数据-->     
<div id="datapages">
	<jsp:include page="/service/list.jsp"></jsp:include>
</div>  
        
<script language="javascript" type="text/javascript">
	//显示角色详细信息
	function showDetail(flag, a) {
		var detailDiv = a.parentNode.getElementsByTagName("div")[0];
		if (flag) {
			detailDiv.style.display = "block";
		} else
			detailDiv.style.display = "none";
	}
	//删除
	function deleteAccount() {
		var r = window.confirm("确定要删除此业务账号吗？删除后将不能恢复。");
		document.getElementById("operate_result_info").style.display = "block";
	}
	//开通或暂停
	function setState() {
		var r = window.confirm("确定要开通此业务账号吗？");
		document.getElementById("operate_result_info").style.display = "block";
	}
	function to_searchService(){
		AT.postFrm("#searchServiceForm", callFunction);
	}	
	/**
	 * 回调函数
	 * @param data
	 * @return
	 */
	function callFunction(data){
		$("#datapages").html(data);
	}
</script>