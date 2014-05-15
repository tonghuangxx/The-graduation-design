<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/taglibs.jsp"  %>
            <div id="save_result_info" class="save_success"></div>
            <form action="<%=request.getContextPath() %>/fee/editDo" method="post" class="main_form" id="feeEditForm">
                <input type="hidden" class="readonly"  value="${fee.id}" name="fee.id"/>
                <input type="hidden" class="readonly"  value="${fee.status}" name="fee.status"/>
                <input type="hidden" class="readonly"  value="${fee.creatime}" name="fee.creatime"/>
                <input type="hidden" class="readonly"  value="${fee.startime}" name="fee.startime"/>
                <div class="text_info clearfix"><span>资费名称：</span></div>
                <div class="input_info">
                    <input type="text" class="width300" value="${fee.name}" id="feeName" name="fee.name"/>
                    <span class="required">*</span>
                    <div class="validate_msg_short" id="nameLabel">2长度以上的字母、数字、汉字和下划线的组合</div>
                </div>
                <div class="text_info clearfix"><span>资费类型：</span></div>
                <div class="input_info fee_type">
                    <input type="radio" name="radFeeType" id="monthly" onclick="feeTypeChange(1);" />
                    <label for="monthly">包月</label>
                    <input type="radio" name="radFeeType" checked="checked" id="package" onclick="feeTypeChange(2);" />
                    <label for="package">套餐</label>
                    <input type="radio" name="radFeeType" id="timeBased" onclick="feeTypeChange(3);" />
                    <label for="timeBased">计时</label>
                </div>
                <div class="text_info clearfix"><span>基本时长：</span></div>
                <div class="input_info">
                    <input type="text" class="width100" value="${fee.base_duration}" id="base_duration" name="fee.base_duration"/>
                    <span class="info">小时</span>
                    <span class="required">*</span>
                    <div class="validate_msg_long  validate_msg_long1" style="width:300px;">1-600之间的整数</div>
                </div>
                <div class="text_info clearfix"><span>基本费用：</span></div>
                <div class="input_info">
                    <input type="text"  class="width100" value="${fee.base_cost}" id="base_cost" name="fee.base_cost"/>
                    <span class="info">元</span>
                    <span class="required">*</span>
                    <div class="validate_msg_long validate_msg_long2" style="width:300px;">0-99999.99之间的数值</div>
                </div>
                <div class="text_info clearfix"><span>单位费用：</span></div>
                <div class="input_info">
                    <input type="text" class="width100" value="${fee.unit_cost }" id="unit_cost" name="fee.unit_cost"/>
                    <span class="info">元/小时</span>
                    <span class="required">*</span>
                    <div class="validate_msg_long validate_msg_long3" style="width:300px;">0-99999.99之间的数值</div>
                </div>   
                <div class="text_info clearfix"><span>资费说明：</span></div>
                <div class="input_info_high">
                    <textarea class="width300 height70" id="descr" name="fee.descr">${fee. descr}
                    </textarea>
                    <div class="validate_msg_short"  id="desc_msg">5长度以上的字母、数字、汉字和下划线的组合</div>
                </div>                    
                <div class="button_info clearfix">
                    <input type="button" value="保存" class="btn_save"  id="send" onclick="editFeeDo();"/>
                    <input type="reset" value="取消" class="btn_save" />
                </div>
            </form>
		<script type="text/javascript">
//资费名称输入框失去焦点
$('#feeName').blur(function(){
	var feeName=$.trim($('#feeName').val());
	//检查是否为空
	if(feeName==''){
		$('#nameLabel').addClass("error_msg");
		return;
	}else{
		$('#nameLabel').removeClass('error_msg');
	}
});
//基本时长失去焦点
$('#base_duration').blur(function(){
	var base_duration=$.trim($('#base_duration').val());
	var reg = /^\d*$/;
	if(reg.test(base_duration)){
		if(parseInt(base_duration)<0||parseFloat(base_duration)>600){
			$('.validate_msg_long1').addClass("error_msg");
			return;
		}else{
			$('.validate_msg_long1').removeClass('error_msg');;
		}
	}else{
		$('.validate_msg_long1').addClass("error_msg");
		return;
	}
});
//基本费用失去焦点
$('#base_cost').blur(function(){
	var base_cost=$.trim($('#base_cost').val());
	var reg = /^\d*\.?\d*$/;
	if(reg.test(base_cost)){
		//判断基本费用是否在0到99999.99之间
		if(parseFloat(base_cost)<0||parseFloat(base_cost)>99999.99){
			$('.validate_msg_long2').addClass("error_msg");
			return;
		}else{
			$('.validate_msg_long2').removeClass('error_msg');
		}
	}else{
		$('.validate_msg_long2').addClass("error_msg");
		return;
	}
});
//单位费用输入框失去焦点
$('#unit_cost').blur(function(){
	var unit_cost=$.trim($('#unit_cost').val());
	var reg = /^\d*\.?\d*$/;
	if(reg.test(unit_cost)){
		//判断单位费用是否在0到99999.99之间
		if(parseFloat(unit_cost)<0||parseFloat(unit_cost)>99999.99){
			$('.validate_msg_long3').addClass("error_msg");
			return;
		}else{
			$('.validate_msg_long3').removeClass('error_msg');
		}
	}else{
		$('.validate_msg_long3').addClass("error_msg");
		return;
	}
});
$('#descr').blur(function(){
	var descr=$.trim($('#descr').val());
	if($.trim(descr).length<5){
		$('#desc_msg').addClass('error_msg');
	}else{
		$("#desc_msg").removeClass('error_msg');
	}
});

function editFeeDo(){
	$(':input').trigger('blur');
	if ($('form div').hasClass("error_msg")) {
		return false;
	} else {
		AT.postFrm("#feeEditForm", editFeeCall_function);
	}
}
function editFeeCall_function(json){
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
//切换资费类型
function feeTypeChange(type) {
    var inputArray = document.getElementById("main").getElementsByTagName("input");
    if (type == 1) {
        inputArray[5].readonly = true;
        inputArray[5].value = "";
        inputArray[5].className += " readonly";
        inputArray[6].readonly = false;
        inputArray[6].className = "width100";
        inputArray[7].readonly = true;
        inputArray[7].className += " readonly";
        inputArray[7].value = "";
    }
    else if (type == 2) {
        inputArray[5].readonly = false;
        inputArray[5].className = "width100";
        inputArray[6].readonly = false;
        inputArray[6].className = "width100";
        inputArray[7].readonly = false;
        inputArray[7].className = "width100";
    }
    else if (type == 3) {
        inputArray[5].readonly = true;
        inputArray[5].value = "";
        inputArray[5].className += " readonly";
        inputArray[6].readonly = true;
        inputArray[6].value = "";
        inputArray[6].className += " readonly";
        inputArray[7].readonly = false;
        inputArray[7].className = "width100";
    }
}
</script>   
