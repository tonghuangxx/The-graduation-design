<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib uri="/struts-tags" prefix="s" %>
<form action="" method="post">
	<!--查询-->
	<div class="search_add">
		<input type="button" value="增加" class="btn_add"
			onclick="location.href='../control/roleAddControl?m.id=1&operation=c';" />
	</div>
	<!--删除的操作提示-->
	<div id="operate_result_info" class="operate_success">
		<img src="../images/close.png" onclick="this.parentNode.style.display='none';" />删除成功！</div>
	<!--删除错误！该角色被使用，不能删除。-->
	<!--数据区域：用表格展示数据-->
	<div id="data">
		<table id="datalist">
			<tr>
				<th>
					用户 ID
				</th>
				<th>
					角色名称
				</th>
				<th class="width600">
					拥有的权限
				</th>
				<th class="td_modi"></th>
			</tr>
			<s:iterator value="roleList" var="c">
				<tr>
					<td>
						<s:property value="#c.adminInfo.id" />
					</td>
					<td>
						<s:property value="#c.adminInfo.admin_code" />
					</td>
					<td>
						<s:iterator value="#c.role">
							<s:property value="role_name" />
						</s:iterator>
					</td>
					<td>
						<input type="button" value="修改" class="btn_modify"
							onclick="location.href='../control/roleUpdateControl?m.id=1&operation=u&adminId=${c.adminInfo.id}';" />
						<input type="button" value="删除" class="btn_delete"
							onclick="deleteRole(${c.adminInfo.id});" />
					</td>
				</tr>
			</s:iterator>
		</table>
	</div>
	<!--分页-->
	<div id="pages">
		<s:if test="pageNo>1">
			<a href="roleList?pageNo=${pageNo-1}">上一页</a>
		</s:if>
		<s:else>上一页</s:else>
		<s:iterator value="new int[totalPages]" status="i">
			<s:if test="#i.count==pageNo">
				<a href="roleList?pageNo=<s:property value='#i.count'/>"
					class="current_page"><s:property value="#i.count" />
				</a>
			</s:if>
			<s:else>
				<a href="roleList?pageNo=<s:property value='#i.count'/>"><s:property
						value="#i.count" /> </a>
			</s:else>
		</s:iterator>
		<s:if test="pageNo<totalPages">
			<a href="roleList?pageNo=${pageNo+1}">下一页</a>
		</s:if>
		<s:else>下一页</s:else>
	</div>
</form>
<script language="javascript" type="text/javascript">
            function deleteRole(id) {
                var r = window.confirm("确定要删除此角色吗？");
                if(r){
                			location.href='../control/roleDelControl?m.id=1&operation=d&adminId='+id;
                document.getElementById("operate_result_info").style.display = "block";
                }
            }
</script>

