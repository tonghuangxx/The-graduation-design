<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/taglibs.jsp"  %>
        
<!--保存成功或者失败的提示消息-->          
<div id="save_result_info" class="save_success"></div>
            <form action="<%=request.getContextPath() %>/account/editDo" method="post" class="main_form" id="editAccountForm">
            		<input type="hidden" value="${account.id }" name="account.id"/>
            		<input type="hidden" value="${account.recommender_id}" name="account.recommender_id"/>
            		<input type="hidden" value="${account.status}" name="account.status"/>
            		<input type="hidden" value="${account.create_date}" name="account.create_date"/>
            		<input type="hidden" value="${account.pause_date}" name="account.pause_date"/>
            		<input type="hidden" value="${account.close_date}" name="account.close_date"/>
            		<input type="hidden" value="${account.last_login_time}" name="account.last_login_time"/>
            		<input type="hidden" value="${account.last_login_ip}" name="account.last_login_ip"/>
            		<input type="hidden" value="${account.login_passwd}" name="account.login_passwd"/>
                    <div class="text_info clearfix"><span>姓名：</span></div>
                    <div class="input_info">
                        <input type="text" value="${account.real_name }" name="account.real_name" />
                        <span class="required">*</span>
                        <div class="validate_msg_long">20长度以内的汉字、字母和数字的组合</div>
                    </div>
                    <div class="text_info clearfix"><span>身份证：</span></div>
                    <div class="input_info">
                        <input type="text" value="${account.idcard_no }" name="account.idcard_no" readonly class="readonly" />
                    </div>
                    <div class="text_info clearfix"><span>登录账号：</span></div>
                    <div class="input_info">
                        <input type="text" value="${account.login_name }" name="account.login_name" readonly class="readonly"  />                        
                        <div class="change_pwd">
                            <input id="chkModiPwd" type="checkbox" onclick="showPwd(this);" />
                            <label for="chkModiPwd">修改密码</label>
                        </div>
                    </div>
                    <!--修改密码部分-->
                    <div id="divPwds">
                        <div class="text_info clearfix"><span>旧密码：</span></div>
                        <div class="input_info">
                            <input type="password" name="oldPwd" />
                            <span class="required">*</span>
                            <div class="validate_msg_long">30长度以内的字母、数字和下划线的组合</div>
                        </div>
                        <div class="text_info clearfix"><span>新密码：</span></div>
                        <div class="input_info">
                            <input type="password"  name="newPwd"/>
                            <span class="required">*</span>
                            <div class="validate_msg_long">30长度以内的字母、数字和下划线的组合</div>
                        </div>
                        <div class="text_info clearfix"><span>重复新密码：</span></div>
                        <div class="input_info">
                            <input type="password" name="repPwd" id="repPwd"/>
                            <span class="required">*</span>
                            <div class="validate_msg_long">两次密码必须相同</div>
                        </div>  
                    </div>                   
                    <div class="text_info clearfix"><span>电话：</span></div>
                    <div class="input_info">
                        <input type="text" class="width200" name="account.telephone" value="${account.telephone }"/>
                        <span class="required">*</span>
                        <div class="validate_msg_medium">正确的电话号码格式：手机或固话</div>
                    </div>
                    <div class="text_info clearfix"><span>推荐人身份证号码：</span></div>
                    <div class="input_info">
                        <input type="text" name="" value="${account.recommender.idcard_no }" readonly class="readonly"/>
                        <div class="validate_msg_long error_msgs">正确的身份证号码格式</div>
                    </div>
                    <div class="text_info clearfix"><span>生日：</span></div>
                    <div class="input_info">
                        <input type="text" value="<s:date name="account.birthdate" format="yyyy-MM-dd"/>" name="account.birthdate" readonly class="readonly" />
                    </div>
                    <div class="text_info clearfix"><span>Email：</span></div>
                    <div class="input_info">
                        <input type="text" class="width200" name="account.email" value="${account.email }"/>
                        <div class="validate_msg_medium">50长度以内，合法的 Email 格式</div>
                    </div> 
                    <div class="text_info clearfix"><span>职业：</span></div>
                    <div class="input_info">
                        <input type="text" class="width200" name="account.occupation" value="${account.occupation }"/>                    
                    </div>
                    <div class="text_info clearfix"><span>性别：</span></div>
                    <div class="input_info fee_type">
                       	<s:if test="account.gender=='0'">
           			    	<input type="radio" name="account.gender" value="0" checked="checked" id="female"  />
			            	<label for="female">女</label>
			            	<input type="radio" name="account.gender" value="1" id="male"  />
			            	<label for="male">男</label>
			         	</s:if><s:else>
			            	<input type="radio" name="account.gender" value="0" id="female"  />
			            	<label for="female">女</label>
			            	<input type="radio" name="account.gender" value="1" checked="checked" id="male"  />
			            <label for="male">男</label>
			         </s:else>
                    </div> 
                    <div class="text_info clearfix"><span>通信地址：</span></div>
                    <div class="input_info">
                        <input type="text" class="width350" name="account.mailaddress" value="${account.mailaddress }"/>
                        <div class="validate_msg_tiny">100长度以内</div>
                    </div> 
                    <div class="text_info clearfix"><span>邮编：</span></div>
                    <div class="input_info">
                        <input type="text" name="account.zipcode" value="${account.zipcode }"/>
                        <div class="validate_msg_long">6位数字</div>
                    </div> 
                    <div class="text_info clearfix"><span>QQ：</span></div>
                    <div class="input_info">
                        <input type="text" name="account.qq" value="${account.qq }"/>
                        <div class="validate_msg_long">5到13位数字</div>
                    </div>                
                    <!--操作按钮-->
                    <div class="button_info clearfix">
                        <input type="button" value="保存" class="btn_save" onclick="to_accoutEditDo();" />
                        <input type="reset" value="取消" class="btn_save" />
                    </div>
                </form>
<script language="javascript" type="text/javascript">
	//保存成功的提示信息
	function to_accoutEditDo(){
		AT.postFrm("#editAccountForm", editAccountCall_function);
	}
	function editAccountCall_function(json){
		var data = eval('('+json+')');
		showResultDiv(true,data.message);
		window.setTimeout("showResultDiv(false);", 5000);
	}
	//保存结果的提示
	function showResultDiv(flag,message) {
		var divResult = document.getElementById("save_result_info");
		if (flag) {
			divResult.innerHTML=message;
			divResult.style.display = "block";
		} else {
			divResult.style.display = "none";
		}
	}
	//显示修改密码的信息项
	function showPwd(chkObj) {
		if (chkObj.checked)
			document.getElementById("divPwds").style.display = "block";
		else
			document.getElementById("divPwds").style.display = "none";
	}
</script>