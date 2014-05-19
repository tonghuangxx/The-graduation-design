<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/taglibs.jsp"  %>
<form action="<%=request.getContextPath() %>/fee/sort" method="post" id="sortFeeForm">
	<input type="hidden" value="${ pageNum}" name="pageNum" id="pageNum" />
	<input type="hidden" value="${numPerPage}" name="numPerPage"
		id="numPerPage" />
	<!--排序-->
                <div class="search_add">
                    <div>
                    	<input type="button" value="月租" class="sort_asc" onclick="sort(this);" id="base_cost"/>
                        <input type="button" value="单费" class="sort_asc" onclick="sort(this);" id="unit_cost" />
                        <input type="button" value="时长" class="sort_asc" onclick="sort(this);" id="base_duration"/>
                        <input type="hidden" value="" name="con_sort" id="base_cost_sort"/>
                        <input type="hidden" value="" name="con_sort" id="unit_cost_sort"/>
                        <input type="hidden" value="" name="con_sort" id="base_duration_sort"/>
                    </div>
                    <input type="button" value="增加" class="btn_add" onclick="to_feeAdd();"  />
                </div> 
</form>		
                <!--启用操作的操作提示-->
	<div id="operate_result_info" class="operate_success">
		<img src="../images/close.png"
			onclick="this.parentNode.style.display='none';" />
		<span id='msg'></span>
	</div>

                <!--数据区域：用表格展示数据-->
<div id="datapages">
	<jsp:include page="/fee/list.jsp"></jsp:include>
</div>
<script type="text/javascript">

//排序按钮的点击事件
function sort(btnObj) {
    if (btnObj.className == "sort_desc"){
        btnObj.className = "sort_asc";
        if($(btnObj).attr("id")=="base_cost"){
            $("#base_cost_sort").val("asc");
            $("#unit_cost_sort").val("");
            $("#base_duration_sort").val("");
        }
        if($(btnObj).attr("id")=="unit_cost"){
            $("#base_cost_sort").val("");
            $("#unit_cost_sort").val("asc");
            $("#base_duration_sort").val("");
        }
        if($(btnObj).attr("id")=="base_duration"){
            $("#base_cost_sort").val("");
        	$("#unit_cost_sort").val("");
            $("#base_duration_sort").val("asc");
        }
    }else{
        btnObj.className = "sort_desc";
        if($(btnObj).attr("id")=="base_cost"){
        	$("#base_cost_sort").val("desc");
            $("#unit_cost_sort").val("");
            $("#base_duration_sort").val("");
        }
        if($(btnObj).attr("id")=="unit_cost"){
        	$("#base_cost_sort").val("");
            $("#unit_cost_sort").val("desc");
            $("#base_duration_sort").val("");
        }
        if($(btnObj).attr("id")=="base_duration"){
        	$("#base_cost_sort").val("");
            $("#unit_cost_sort").val("");
            $("#base_duration_sort").val("desc");
        }
    }
        AT.postFrm("#sortFeeForm", callFunction);
}
/**
 * 回调函数
 * @param data
 * @return
 */
function callFunction(data){
	$("#datapages").html(data);
}
//启用
function startFee(feeId) {
	var r = window.confirm("确定要启用此资费吗？资费启用后将不能修改和删除。");
	if (r) {
		location.href = "../control/feeStartControl?m.id=2&operation=u&feeId="
				+ feeId;
	} else {
		return false;
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
	AT.postFrm("#sortFeeForm", callFunction);
}
/**
 * 回调函数
 * @param data
 * @return
 */
function callFunction(data){
	$("#datapages").html(data);
}

/*点击增加*/
function to_feeAdd(){
	var href="../fee/add"
		$.post(href,function(data){
			$("#main").html(data);
	});
}

</script>

