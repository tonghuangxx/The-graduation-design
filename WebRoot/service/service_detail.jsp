<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/taglibs.jsp"%>
<form action="" method="post" class="main_form">
	<input type="hidden" value="${pageNum}" name="pageNum" id="pageNum" />
	<input type="hidden" value="${numPerPage}" name="numPerPage" id="numPerPage" />
                <!--必填项-->
                <div class="text_info clearfix"><span>客户姓名：</span></div>
                <div class="input_info"><input type="text" readonly class="readonly" value="${service.account.real_name }" /></div>
                <div class="text_info clearfix"><span>身份证号码：</span></div>
                <div class="input_info"><input type="text" readonly class="readonly" value="${service.account.idcard_no }" /></div>
                <div class="text_info clearfix"><span>服务器 IP：</span></div>
                <div class="input_info"><input type="text" value="${service.host.host_ip }" readonly class="readonly" /></div>
                <div class="text_info clearfix"><span>OS 账号：</span></div>
                <div class="input_info"><input type="text" value="${service.os_username }" readonly class="readonly" /></div>
                <div class="text_info clearfix"><span>状态：</span></div>
                <div class="input_info">
                    <select disabled>
                    	<s:if test='service.status=="0"'>
	                        <option selected="selected">开通</option>
                    	</s:if><s:elseif test='service.status=="1"'>
	                        <option selected="selected">暂停</option>
                    	</s:elseif><s:elseif test='service.status=="2"'>
	                        <option selected="selected">删除</option>
                    	</s:elseif>
                    </select>                        
                </div>
                <div class="text_info clearfix"><span>创建时间：</span></div>
                <div class="input_info"><input type="text" readonly class="readonly" value="<s:date name="service.create_date" format="yyyy-MM-dd HH:mm:ss"/>"/></div>
                <div class="text_info clearfix"><span>资费名称：</span></div>
                <div class="input_info"><input type="text" readonly class="width200 readonly" value="${service.fee.name }" /></div>
                <div class="text_info clearfix"><span>资费说明：</span></div>
                <div class="input_info_high">
                    <textarea class="width300 height70 readonly" readonly>${service.fee.descr }</textarea>
                </div>  
                <!--操作按钮-->
                <div class="button_info clearfix">
                    <input type="button" value="返回" class="btn_save" onclick="to_serviceList();" />
                </div>
            </form>
<script type="text/javascript">
function to_serviceList(){
	var pageNum=$("#pageNum").val();
	var numPerPage=$("#numPerPage").val();
	var href = "../service/listData?pageNum="+pageNum+"&numPerPage="+numPerPage;
	$.post(href,function(data){
		$("#main").html(data);
	});
}
</script>