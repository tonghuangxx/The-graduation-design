<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/taglibs.jsp"  %>
<form action="${pageContext.request.contextPath }/bill/search" method="post" id="serachBillHinForm" >
		<input type="hidden" value="${pageNum}" name="pageNum" id="pageNum" />
		<input type="hidden" value="${numPerPage}" name="numPerPage" id="numPerPage" />
		<input type="hidden" value="${form.account.idcard_no }" class="text_search" name="form.account.idcard_no"/>
		<input type="hidden" class="width70 text_search" value="${form.account.login_name }" name="form.account.login_name"/>
		<input type="hidden" value="${form.account.real_name }" class="text_search" name="form.account.real_name" />
		<input type="hidden" value="${form.bill_month }" class="text_search" name="form.bill_month" />
</form>
                <div id="data">            
                    <table id="datalist">
                    <tr>
                        <th class="width50">序号</th>
                        <th class="width70">姓名</th>
                        <th class="width150">身份证</th>
                        <th class="width150">账务账号</th>
                        <th>费用</th>
                        <th class="width100">月份</th>
                        <th class="width100">支付方式</th>
                        <th class="width100">支付状态</th>                                                        
                        <th class="width50"></th>
                    </tr>
                    <s:iterator value="billList" status="st">
                    	<tr>
                    		<td><s:property value="#st.count"/></td>
                    		<td><s:property value="account.real_name"/></td>
                    		<td><s:property value="account.idcard_no"/></td>
                    		<td><s:property value="account.login_name"/></td>
                    		<td><s:property value="cost"/></td>
                    		<td><s:date name="bill_month" format="yyyy-MM"/></td>
                    		<td><s:property value="payment_mode"/></td>
                    		<td><s:if test='pay_state=="0"'>未支付</s:if>
								<s:else>已支付</s:else>                    		
                    		</td>
                    		<td><a href="javascript:void(0);" title="账单明细" onclick="to_billItem('<s:property value="id"/>');">明细</a></td>
                    	</tr>
                    </s:iterator>
                </table>
                
                <p>业务说明：<br />
                1、设计支付方式和支付状态，为用户自服务中的支付功能预留；<br />
                2、只查询近 3 年的账单，即当前年和前两年，如2013/2012/2011；<br />
                3、年和月的数据由 js 代码自动生成；<br />
                4、由程序每月的月底定时计算账单数据。</p>
                </div>                    
                <!--分页-->
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
<script type="text/javascript">
function to_billItem(id){
	var pageNum=$("#pageNum").val();
	var numPerPage=$("#numPerPage").val();
	var href = "${pageContext.request.contextPath}/bill/getBillItem?bill.id="+id+"&pageNum="+pageNum+"&numPerPage="+numPerPage;
	$.post(href,function(data){
		$("#main").html(data);
	});	
}
</script>        