//保存结果的提示
function showResultDiv(flag) {
	var divResult = document.getElementById("save_result_info");
	if (flag) {
		divResult.style.display = "block";
	} else {
		divResult.style.display = "none";
	}
}

$(function() {

	if ($('.save_success').html() == "") {
		showResultDiv(false);
	} else {
		showResultDiv(true);
		window.setTimeout("showResultDiv(false);", 5000);
	}

	//管理员名称输入框失去焦点
	$('#admin_code').blur(function() {
		var admin_code = $.trim($('#admin_code').val());
		//检查是否为空
			if (admin_code == '') {
				$('#adminCodeLabel').addClass("error_msg").html("管理员帐号不能为空");
				return;
			}
			var reg = /^\w{4,20}$/;
			if (!reg.test(admin_code)) {
				$('#adminCodeLabel').addClass("error_msg").html(
						"4-20长度的字母、数字和下划线的组合");
				return;
			} else {
				$('#adminCodeLabel').removeClass("error_msg").html(
						"4-20长度的字母、数字和下划线的组合");
			}
			$.post("../user/adminCodeValidName", {
				"adminInfo.admin_code" : admin_code
			},
					function(json) {
						var data = eval('(' + json + ')'); 
						if(data.statusCode==200){
							$('#adminCodeLabel').removeClass('error_msg')
							.addClass('displayOK').html('ok');
						}else{
							$('#adminCodeLabel').addClass("error_msg ").html(data.message);
						}
						
					});
		});
	//姓名失去焦点
	$('#name').blur(function() {
		var name = $.trim($('#name').val());
		//检查是否为空
			if (name == '') {
				$('#nameLabel').addClass("error_msg").html("姓名不能为空");
				return;
			}
			var reg = /^([\u4e00-\u9fa5]|\w){2,20}$/;
			if (!reg.test(name)) {
				$('#nameLabel').addClass("error_msg").html(
						"2-20长度的字母、数字和下划线的组合");
				return;
			} else {
				$('#nameLabel').removeClass("error_msg").addClass('displayOK')
						.html('ok');
			}
		});
	//密码失去焦点
	$('#pwd')
			.blur(function() {
				var pwd = $.trim($('#pwd').val());
				//检查是否为空
					if (pwd == '') {
						$('#pwdLabel').addClass("error_msg").html("密码不能为空");
						return;
					}
					var reg = /^\w{4,8}$/;
					if (!reg.test(pwd)) {
						$('#pwdLabel').addClass("error_msg").html(
								"4-8长度的字母、数字和下划线的组合");
						return;
					} else {
						$('#pwdLabel').removeClass("error_msg").addClass(
								'displayOK').html('ok');
					}
				});
	//重复密码框失去焦点
	$('#rpwd').blur(
			function() {
				if ($.trim($('#rpwd').val()) == "") {
					$('#rpwdLabel').addClass("error_msg").html("不能为空");
					return;
				}
				if ($('#rpwd').val() != $('#pwd').val()) {
					$('#rpwdLabel').addClass("error_msg").html("两次密码必须相同");
				} else {
					$('#rpwdLabel').removeClass("error_msg").addClass(
							'displayOK').html('ok');
				}
			});
	//电话输入框失去焦点
	$('#telphone').blur(function() {
		var telphone = $.trim($('#telphone').val());
		//检查是否为空
			if (telphone == '') {
				$('#telphoneLabel').addClass("error_msg").html("电话不能为空");
				return;
			}
			var reg = /^[0-9]{4,20}$/;
			if (!reg.test(telphone)) {
				$('#telphoneLabel').addClass("error_msg").html(
						"正确的电话号码格式：手机或固话");
				return;
			} else {
				$('#telphoneLabel').removeClass("error_msg").addClass(
						'displayOK').html('ok');
			}
		});

	//邮箱输入框失去焦点
	$('#email').blur(function() {
		var email = $.trim($('#email').val());
		//检查是否为空
			if (email == '') {
				$('#emailLabel').addClass("error_msg").html("邮箱不能为空");
				return;
			}
			var reg = /^(\w+@{1}\w+[\.]{1}[a-zA-Z]+)$/;
			if (!reg.test(email)) {
				$('#emailLabel').addClass("error_msg").html(
						"50长度以内，正确的 email 格式");
				return;
			}
			if (email.length > 50) {
				$('#emailLabel').addClass("error_msg").html(
						"50长度以内，正确的 email 格式");
			} else {
				$('#emailLabel').removeClass("error_msg").addClass('displayOK')
						.html('ok');
			}
		});

	$('#send').click(function() {
		$(':input').trigger('blur');
		var j = 0; //判断是否有checkbox选中
			var inputArray = document.getElementById("mainform")
					.getElementsByTagName("input");
			for ( var i = 1; i < inputArray.length; i++) {
				if (inputArray[i].type == "checkbox") {
					if (inputArray[i].checked) {
						j++;
					}
				}
			}
			//如果没有选中就不能提交表单
			if (j == 0) {
				$('.validate_msg_tiny').addClass("error_msg");
				return false;
			} else {
				$('.validate_msg_tiny').removeClass("error_msg");
				if ($('form div').hasClass('error_msg')) {
					return false;
				}
				$('#mainform').submit();
			}
		});

});