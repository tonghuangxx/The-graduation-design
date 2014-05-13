<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/taglibs.jsp"%>
<div id="data">
	<table id="datalist">
		<tr>
			<th class="th_select_all">
				<input type="checkbox" onclick="selectAdmins(this);" />
				<span>全选</span>
			</th>
			<th>
				序号
			</th>
			<th>
				姓名
			</th>
			<th>
				登录名
			</th>
			<th>
				电话
			</th>
			<th>
				电子邮件
			</th>
			<th>
				授权日期
			</th>
			<th class="width100">
				拥有角色
			</th>
			<th></th>
		</tr>
		<s:iterator value="dataList" var="l" status="st">
			<tr>
				<td>
					<input type="checkbox" name="adminId"
						value="<s:property value="#l.id"/>" />
				</td>
				<td>
					<s:property value="#st.count" />
				</td>
				<td>
					<s:property value="#l.name" />
				</td>
				<td>
					<s:property value="#l.admin_code" />
				</td>
				<td>
					<s:property value="#l.telephone" />
				</td>
				<td>
					<s:property value="#l.email" />
				</td>
				<td>
					<s:date name="#l.enrolldate" format="yyyy-MM-dd HH:mm:ss" />
				</td>
				<td>
					<a class="summary" onmouseover="showDetail(true,this);"
						onmouseout="showDetail(false,this);">管理员管理</a>
					<!--浮动的详细信息-->
					<div class="detail_info">
						<s:iterator value="#l.roleList" var="r">
							<s:property value="#r.role_name" />
						</s:iterator>
					</div>
				</td>
				<td class="td_modi">
					<input type="button" value="修改" class="btn_modify" onclick="editUser('${l.id}');" />
					<input type="button" value="删除" class="btn_delete"
						onclick="deleteAdmin('${l.id}');" />
				</td>
			</tr>
		</s:iterator>
	</table>
</div>
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
<script type="text/javascript">
/**
 * 修改用户
 */
function editUser(id){
	var href="../user/edit?adminInfo.id="+id;
	$.post(href,function(data){
		$("#main").html(data);
	});
}
</script>