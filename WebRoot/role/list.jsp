<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/taglibs.jsp"%>
<div id="data">
		<table id="datalist">
			<tr>
				<th>
					序号
				</th>
				<th>
					角色名称
				</th>
				<th class="width600">
					拥有的功能
				</th>
				<th class="td_modi"></th>
			</tr>
			<s:iterator value="roleList" var="c" status="st">
				<tr>
					<td>
						<s:property value="#st.count" />
					</td>
					<td>
						<s:property value="#c.role_name" />
					</td>
					<td>
						<s:iterator value="#c.funList">
							<s:property value="name" />
						</s:iterator>
					</td>
					<td>
						<input type="button" value="修改" class="btn_modify"
							onclick="editRole('<s:property value="#c.id" />');" />
						<input type="button" value="删除" class="btn_delete"
							onclick="deleteRole('<s:property value="#c.id" />');" />
					</td>
				</tr>
			</s:iterator>
		</table>
	</div>
	<!--分页-->
<div id="pages">
	<s:if test="pageNum>1">
		<a href="javascript:void(0);" style="color: green;"
			onclick="roleNumberPage('${pageNum-1}');">上一页</a>
	</s:if>
	<s:else>上一页</s:else>
	<s:iterator value="new int[pageCount]" status="i">
		<s:if test="#i.count==pageNum">
			<a href="javascript:void(0);" class="current_page"
				style="color: green;"
				onclick="roleNumberPage('<s:property value='#i.count'/>');"><s:property value="#i.count" />
			</a>
		</s:if>
		<s:else>
			<a href="javascript:void(0);" style="color: green;"
				onclick="roleNumberPage('<s:property value='#i.count'/>');"><s:property
					value="#i.count" /> </a>
		</s:else>
	</s:iterator>
	<s:if test="pageNum<pageCount">
		<a href="javascript:void(0);" style="color: green;"
			onclick="roleNumberPage('${pageNum+1}');">下一页</a>
	</s:if>
	<s:else>下一页</s:else>
</div>
<script type="text/javascript">
/**
 * 显示某一页数据
 * @param pageNum
 * @return
 */
function roleNumberPage(pageNum){
	var href = "../role/list?pageNum="+pageNum;
	$.post(href,function(data){
		$("#datapages").html(data);
	});
}
/**
 * 点击修改
 */
function editRole(id){
	var href = "../role/edit?role.id="+id;
	$.post(href,function(data){
		$("#main").html(data);
	});
}
</script>