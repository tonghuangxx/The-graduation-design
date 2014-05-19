<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/taglibs.jsp"  %>
<form action="" method="post" class="main_form">
	<input type="hidden" value="${numPerPage }" id="numPerPage" name="numPerPage"/>
	<input type="hidden" value="${pageNum }" id="pageNum" name="pageNum"/>
                <div class="text_info clearfix"><span>资费名称：</span></div>
                <div class="input_info"><input type="text" class="readonly" readonly value="${fee.name}"/></div>
                <div class="text_info clearfix"><span>资费状态：</span></div>
                <div class="input_info">
                    <select class="readonly" disabled>
                    <s:if test="fee.status=='0'">
                        <option selected="selected">开通</option>
                    </s:if>
                    <s:elseif test="fee.status=='1'">
                        <option selected="selected">暂停</option>
                    </s:elseif>
                    <s:else>
                        <option selected="selected">删除</option>
                    </s:else>
                    </select>                        
                </div>
                <div class="text_info clearfix"><span>资费类型：</span></div>
                <div class="input_info fee_type">
                    <input type="radio" name="radFeeType" id="monthly" disabled="disabled" />
                    <label for="monthly">包月</label>
                    <input type="radio" name="radFeeType" id="package" disabled="disabled" />
                    <label for="package">套餐</label>
                    <input type="radio" name="radFeeType" checked="checked" id="timeBased" disabled="disabled" />
                    <label for="timeBased">计时</label>
                </div>
                <div class="text_info clearfix"><span>基本时长：</span></div>
                <div class="input_info">
                    <input type="text" class="readonly" readonly value="${fee.base_duration}"  />
                    <span>小时</span>
                </div>
                <div class="text_info clearfix"><span>基本费用：</span></div>
                <div class="input_info">
                    <input type="text"  class="readonly" readonly value="${fee.base_cost}" />
                    <span>元</span>
                </div>
                <div class="text_info clearfix"><span>单位费用：</span></div>
                <div class="input_info">
                    <input type="text"  class="readonly" readonly value="${fee.unit_cost}" />
                    <span>元/小时</span>
                </div>
                <div class="text_info clearfix"><span>创建时间：</span></div>
                <div class="input_info"><input type="text"  class="readonly" readonly value="<s:date name="fee.creatime" format="yyyy-MM-dd HH:mm:ss"/>" /></div>      
                <div class="text_info clearfix"><span>启动时间：</span></div>
                <div class="input_info"><input type="text"  class="readonly" readonly value="<s:date name="fee.startime" format="yyyy-MM-dd HH:mm:ss"/>" /></div>      
                <div class="text_info clearfix"><span>资费说明：</span></div>
                <div class="input_info_high">
                    <textarea class="width300 height70 readonly" readonly><s:property value="fee.descr"/> </textarea>
                </div>                    
                <div class="button_info clearfix">
                    <input type="button" value="返回" class="btn_save" onclick="to_feeList();" />
                </div>
</form>  
<script type="text/javascript">
function to_feeList(){
	var numPerPage = $("#numPerPage").val();
	var pageNum = $("#pageNum").val();
	var href="../fee/listData?numPerPage="+numPerPage+"&pageNum="+pageNum;
	$.post(href,function(data){
		$("#main").html(data);
	})
}
</script>