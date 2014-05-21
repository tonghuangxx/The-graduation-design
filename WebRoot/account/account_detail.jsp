<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/taglibs.jsp"  %>
<form action="" method="post" class="main_form">
	<input type="hidden" value="${pageNum}" name="pageNum" id="pageNum" />
	<input type="hidden" value="${numPerPage}" name="numPerPage" id="numPerPage" />
    <div class="text_info clearfix"><span>姓名：</span></div>
    <div class="input_info"><input type="text" value="${account.real_name }" readonly class="readonly" /></div>
    <div class="text_info clearfix"><span>身份证：</span></div>
    <div class="input_info">
        <input type="text" value="${account.idcard_no }" readonly class="readonly" />
    </div>
    <div class="text_info clearfix"><span>登录账号：</span></div>
    <div class="input_info">
    	<input type="text" value="${account.login_name }" readonly class="readonly" />
    </div>                   
    <div class="text_info clearfix"><span>电话：</span></div>
    <div class="input_info">
         <input type="text" class="width200 readonly" readonly value="${account.telephone }" />
    </div>
    <div class="text_info clearfix"><span>推荐人身份证号码：</span></div>
    <div class="input_info"><input type="text" readonly class="readonly" value="${account.recommender.idcard_no }" /></div>
    <div class="text_info clearfix"><span>状态：</span></div>
    <div class="input_info">
         <select disabled>
         	<s:if test='account.status=="0"'>
            	<option selected="selected">开通</option>
           	</s:if><s:elseif test='account.status=="1"'>
	            <option selected="selected">暂停</option>
            </s:elseif><s:elseif test='account.status=="2"'>
	            <option selected="selected">删除</option>
            </s:elseif>
         </select>                        
     </div>
     <s:if test='account.status=="0"'>
     <div class="text_info clearfix"><span>创建时间：</span></div>
	 <div class="input_info"><input type="text" readonly class="readonly" value="<s:date name="account.create_date" format="yyyy-MM-dd HH:mm:ss"/>" /></div>
     </s:if><s:elseif test='account.status=="1"'>
	 	<div class="text_info clearfix"><span>暂停时间：</span></div>
	    <div class="input_info"><input type="text" readonly class="readonly" value="<s:date name="account.pause_date" format="yyyy-MM-dd HH:mm:ss"/>" /></div>
     </s:elseif><s:elseif test='account.status=="2"'>
	    <div class="text_info clearfix"><span>删除时间：</span></div>
	    <div class="input_info"><input type="text" readonly class="readonly" value="<s:date name="account.close_date" format="yyyy-MM-dd HH:mm:ss"/>" /></div>
     </s:elseif>                    
     <div class="text_info clearfix"><span>上次登录时间：</span></div>
     <div class="input_info"><input type="text" readonly class="readonly" value="<s:date name="account.last_login_time" format="yyyy-MM-dd HH:mm:ss"/>" /></div>
     <div class="text_info clearfix"><span>上次登录IP：</span></div>
     <div class="input_info"><input type="text" readonly class="readonly" value="${account.last_login_ip }" /></div>
     <!--可选项数据-->
     <div class="text_info clearfix"><span>生日：</span></div>
     <div class="input_info">
     <input type="text" readonly class="readonly" value="<s:date name="account.birthdate" format="yyyy-MM-dd"/>" />
        </div>
     <div class="text_info clearfix"><span>Email：</span></div>
        <div class="input_info">
            <input type="text" class="width350 readonly" readonly value="${account.email }" />
        </div> 
     <div class="text_info clearfix"><span>职业：</span></div>
     <div class="input_info">
        <input type="text" class="width350 readonly" readonly value="${account.occupation }" />                     
     </div>
     <div class="text_info clearfix"><span>性别：</span></div>
     <div class="input_info fee_type">
         <s:if test="account.gender=='0'">
            <input type="radio" name="radSex" checked="checked" id="female" disabled />
            <label for="female">女</label>
            <input type="radio" name="radSex" id="male" disabled />
            <label for="male">男</label>
         </s:if><s:else>
            <input type="radio" name="radSex"  id="female" disabled />
            <label for="female">女</label>
            <input type="radio" name="radSex" checked="checked" id="male" disabled />
            <label for="male">男</label>
         </s:else>
      </div> 
         <div class="text_info clearfix"><span>通信地址：</span></div>
      <div class="input_info"><input type="text" class="width350 readonly" readonly value="${account.mailaddress }" /></div> 
      <div class="text_info clearfix"><span>邮编：</span></div>
      <div class="input_info"><input type="text" class="readonly" readonly value="${account.zipcode }" /></div> 
      <div class="text_info clearfix"><span>QQ：</span></div>
      <div class="input_info"><input type="text" class="readonly" readonly value="${account.qq }" /></div>                
      <!--操作按钮-->
      <div class="button_info clearfix">
      	<input type="button" value="返回" class="btn_save" onclick="to_accountList();" />
      </div>
</form>  
<script type="text/javascript">
function to_accountList(){
	var pageNum=$("#pageNum").val();
	var numPerPage=$("#numPerPage").val();
	var href = "../account/listData?pageNum="+pageNum+"&numPerPage="+numPerPage;
	$.post(href,function(data){
		$("#main").html(data);
	});
}
</script>