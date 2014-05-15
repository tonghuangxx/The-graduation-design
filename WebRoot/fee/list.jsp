<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/taglibs.jsp"  %>
<div id="data">
	<table id="datalist">
		<tr>
			<th>
				序号
			</th>
			<th class="width100">
				资费名称
			</th>
			<th>
				基本时长
			</th>
			<th>
				基本费用
			</th>
			<th>
				单位费用
			</th>
			<th>
				创建时间
			</th>
			<th>
				开通时间
			</th>
			<th class="width50">
				状态
			</th>
			<th class="width200"></th>
		</tr>
		<s:iterator value="feeList" status="st" var="fl">
			<tr>
				<td>
					<s:property value="#st.count"/>
				</td>
				<td>
					<a href="feeDetail?feeId=${fee.id}"><s:property value="name"/></a>
				</td>
				<td>
					<s:property value="base_duration"/>小时
				</td>
				<td>
					<s:property value="base_cost"/>元
				</td>
				<td>
					<s:property value="unit_cost"/>元/小时
				</td>
				<td>
					<s:date name="creatime" format="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<s:date name="startime" format="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					<s:if test="status=='0'">开通</s:if>
					<s:if test="status=='1'">暂停</s:if>
					<s:if test="status=='2'">删除</s:if>
				</td>
				<td>
					<s:if test="status=='0'">
						<input type="button" value="启用" class="btn_start" onclick="startFee('<s:property value="id"/>');" disabled="disabled"/>
						<input type="button" value="修改" class="btn_modify" onclick="editFee('<s:property value="id"/>');" disabled="disabled" />
						<input type="button" value="删除" class="btn_delete" onclick="deleteFee('<s:property value="id"/>');" disabled="disabled" />
					</s:if>
					<s:if test="status=='1'">
						<input type="button" value="启用" class="btn_start" onclick="startFee('<s:property value="id"/>');" />
						<input type="button" value="修改" class="btn_modify" onclick="editFee('<s:property value="id"/>');" />
						<input type="button" value="删除" class="btn_delete" onclick="deleteFee('<s:property value="id"/>');" />
					</s:if>
					<s:if test="status=='2'">
						<input type="button" value="启用" class="btn_start" onclick="startFee('<s:property value="id"/>');" />
						<input type="button" value="修改" class="btn_modify" onclick="editFee('<s:property value="id"/>');" />
						<input type="button" value="删除" class="btn_delete" onclick="deleteFee('<s:property value="id"/>');" disabled="disabled"/>
					</s:if>
				</td>
			</tr>
		</s:iterator>
	</table>
	<p>
		业务说明：
		<br />
		1、创建资费时，状态为暂停，记载创建时间；
		<br />
		2、暂停状态下，可修改，可删除；
		<br />
		3、开通后，记载开通时间，且开通后不能修改、不能再停用、也不能删除；
		<br />
		4、业务账号修改资费时，在下月底统一触发，修改其关联的资费ID（此触发动作由程序处理）
	</p>
</div>
<!--分页-->
<div id="pages">
	<s:if test="pageNum>1">
		<a href="javascript:void(0);" style="color: green;"
			onclick="numberPage('${pageNum-1}');">上一页</a>
	</s:if>
	<s:else>上一页</s:else>
	<s:iterator value="new int[pageCount]" status="i">
		<s:if test="#i.count==pageNum">
			<a href="javascript:void(0);" class="current_page"
				style="color: green;"
				onclick="numberPage('<s:property value='#i.count'/>');"><s:property
					value="#i.count" />
			</a>
		</s:if>
		<s:else>
			<a href="javascript:void(0);" style="color: green;"
				onclick="numberPage('<s:property value='#i.count'/>');"><s:property
					value="#i.count" /> </a>
		</s:else>
	</s:iterator>
	<s:if test="pageNum<pageCount">
		<a href="javascript:void(0);" style="color: green;"
			onclick="numberPage('${pageNum+1}');">下一页</a>
	</s:if>
	<s:else>下一页</s:else>
</div>
<script>
function editFee(id){
	var href="../fee/edit?fee.id="+id;
	$.post(href,function(data){
		$("#main").html(data);
	});
}

function deleteFee(id){
	var r = window.confirm("确定要删除此资费吗？");
	if (r) {
		$.post("../fee/delete",{'fee.id':id},function(data){
			AT.postFrm("#sortFeeForm", callFunction);
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
</script>
