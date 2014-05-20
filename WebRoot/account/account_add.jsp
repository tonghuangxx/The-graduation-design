<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/taglibs.jsp"  %>
       
<!--保存成功或者失败的提示消息-->
<div id="save_result_info" class="save_success"></div>
<form action="<%=request.getContextPath() %>/account/addDo" method="post" class="main_form" id="accountAddForm">
                <!--必填项-->
                <div class="text_info clearfix"><span>姓名：</span></div>
                <div class="input_info">
                    <input type="text" value="" name="account.real_name" />
                    <span class="required">*</span>
                    <div class="validate_msg_long">20长度以内的汉字、字母和数字的组合</div>
                </div>
                <div class="text_info clearfix"><span>身份证：</span></div>
                <div class="input_info">
                    <input type="text" value="" name="account.idcard_no"/>
                    <span class="required">*</span>
                    <div class="validate_msg_long">正确的身份证号码格式</div>
                </div>
                <div class="text_info clearfix"><span>登录账号：</span></div>
                <div class="input_info">
                    <input type="text" value="" name="account.login_name" />
                    <span class="required">*</span>
                    <div class="validate_msg_long">30长度以内的字母、数字和下划线的组合</div>
                </div>
                <div class="text_info clearfix"><span>密码：</span></div>
                <div class="input_info">
                    <input type="password" name="account.login_passwd" />
                    <span class="required">*</span>
                    <div class="validate_msg_long">30长度以内的字母、数字和下划线的组合</div>
                </div>
                <div class="text_info clearfix"><span>重复密码：</span></div>
                <div class="input_info">
                    <input type="password"  />
                    <span class="required">*</span>
                    <div class="validate_msg_long">两次密码必须相同</div>
                </div>     
                <div class="text_info clearfix"><span>电话：</span></div>
                <div class="input_info">
                    <input type="text" class="width200" name="account.telephone"/>
                    <span class="required">*</span>
                    <div class="validate_msg_medium">正确的电话号码格式：手机或固话</div>
                </div>                
                <!--可选项-->
                <div class="text_info clearfix"><span>可选项：</span></div>
                <div class="input_info">
                    <img src="../images/show.png" alt="展开" onclick="showOptionalInfo(this);" />
                </div>
                <div id="optionalInfo" class="hide">
                    <div class="text_info clearfix"><span>推荐人身份证号码：</span></div>
                    <div class="input_info">
                        <input type="text" name="account.recommender.idcard_no"/>
                        <div class="validate_msg_long">正确的身份证号码格式</div>
                    </div>
                    <div class="text_info clearfix"><span>生日：</span></div>
                    <div class="input_info">
                        <input type="text" value=""  name="account.birthdate" />
                    </div>
                    <div class="text_info clearfix"><span>Email：</span></div>
                    <div class="input_info">
                        <input type="text" class="width350" name="account.email"/>
                        <div class="validate_msg_tiny">50长度以内，合法的 Email 格式</div>
                    </div> 
                    <div class="text_info clearfix"><span>职业：</span></div>
                    <div class="input_info">
                        <input type="text" class="width350" name="account.occupation"/>                     
                    </div>
                    <div class="text_info clearfix"><span>性别：</span></div>
                    <div class="input_info fee_type">
                        <input type="radio" name="account.gender" value="0" checked="checked" id="female" />
                        <label for="female">女</label>
                        <input type="radio" name="account.gender" value="1" id="male" />
                        <label for="male">男</label>
                    </div> 
                    <div class="text_info clearfix"><span>通信地址：</span></div>
                    <div class="input_info">
                        <input type="text" class="width350" name="account.mailaddress"/>
                        <div class="validate_msg_tiny">50长度以内</div>
                    </div> 
                    <div class="text_info clearfix"><span>邮编：</span></div>
                    <div class="input_info">
                        <input type="text" name="account.zipcode"/>
                        <div class="validate_msg_long">6位数字</div>
                    </div> 
                    <div class="text_info clearfix"><span>QQ：</span></div>
                    <div class="input_info">
                        <input type="text" name="account.qq"/>
                        <div class="validate_msg_long">5到13位数字</div>
                    </div>                
                </div>
                <!--操作按钮-->
                <div class="button_info clearfix">
                    <input type="button" value="保存" class="btn_save" onclick="to_accountAddDo();" />
                    <input type="reset" value="取消" class="btn_save" />
                </div>
            </form>
<script language="javascript" type="text/javascript">
	//保存成功的提示信息
	function showResult() {
		showResultDiv(true);
		window.setTimeout("showResultDiv(false);", 3000);
	}
	function showResultDiv(flag) {
		var divResult = document.getElementById("save_result_info");
		if (flag)
			divResult.style.display = "block";
		else
			divResult.style.display = "none";
	}

	//显示选填的信息项
	function showOptionalInfo(imgObj) {
		var div = document.getElementById("optionalInfo");
		if (div.className == "hide") {
			div.className = "show";
			imgObj.src = "../images/hide.png";
		} else {
			div.className = "hide";
			imgObj.src = "../images/show.png";
		}
	}

	function to_accountAddDo(){
		AT.postFrm("#accountAddForm", addAccoutCall_function);
	}
	function addAccoutCall_function(json){
		var data = eval('(' + json + ')'); 
		document.getElementById("accountAddForm").reset();
		showResultDiv(true,data.message);
		window.setTimeout("showResultDiv(false);", 5000);
	}
	function showResultDiv(flag,message) {
		var divResult = document.getElementById("save_result_info");
		if (flag) {
			divResult.innerHTML=message;
			divResult.style.display = "block";
		} else {
			divResult.style.display = "none";
		}
	}
</script>