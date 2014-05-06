var AT = new AjaxTool();
var XDUI = new UIUtil();
var XDMSG = new XDMessage();
var XDT = new XdTool();
var treeUtil=new PaltformDhtmlxTree();
/**
 * 进行ajax请求的类
 * 
 * @return
 */
function AjaxTool() {
	/**
	 * get方式提交数据
	 */
	this.get = function(url, func) {
		if (url.indexOf("?") > 0) {
			url += "&_rad=" + new Date().getTime();
		} else {
			url += "?_rad=" + new Date().getTime();
		}
		$("#progressBar").show();
		var options = {
			async : true,
			cache : false,
			url : url,
			type : "get",
			success : function(data, textStatus) {
				func(data);
				$("#progressBar").hide();
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				$("#progressBar").hide();
				alertMsg.info("请求出错！");
			}
		};
		$.ajax(options);
	}

	/**
	 * post方式提交
	 * 
	 * @return
	 */
	this.post = function(url, cdata, func) {
		if (url.indexOf("?") > 0) {
			url += "&_rad=" + new Date().getTime();
		} else {
			url += "?_rad=" + new Date().getTime();
		}
		$("#progressBar").show();
		var opts="";
		if(cdata instanceof Array){
			for(var i=0;i<cdata.length;i++){
				if(opts.length>0){
					opts=opts+",";
				}
				opts=opts+"'"+cdata[i].name+"':'"+cdata[i].value+"'";
			}
		}
		var dataParam=eval("({"+opts+"})");
		var options = {
			async : true,
			cache : false,
			data : dataParam,
			url : url,
			type : "POST",
			success : function(data, textStatus) {
				func(data);
				$("#progressBar").hide();
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				$("#progressBar").hide();
				alertMsg.info("请求出错！");
			}
		};
		$.ajax(options);
	}
	
	/**
	 * 提交表单
	 * @return
	 */
	this.postFrm = function(form,func) {
		var $form = $(form);
		if ($form.valid()) {
			var param = $form.serializeArray();
			$.post($form.attr("action"), param, function(data) {
				func(data);
			});
		}
		return false;
	}
	/**
	 * 刷新分页区的div
	 * @param pageFormId
	 * @param listDivId
	 * @return
	 */
	this.freshPageList = function(pageFormId,listDivId,initF){
		this.postFrm($("#"+pageFormId)[0],function(data){
			$("#"+listDivId).html(data);
			if(initF==null || initF){
				$("#"+listDivId).initUI(listDivId);
				XDUI.initTable(listDivId);
			}
		});
	}
	/**
	 * 带文件上传的ajax表单提交
	 * @param {Object} form
	 * @param {Object} callback
	 */
	this.postFileFrm = function (form, callback){
		var $form = $(form), $iframe = $("#callbackframe");
		if(!$form.valid()) {return false;}

		if ($iframe.size() == 0) {
			$iframe = $("<iframe id='callbackframe' name='callbackframe' src='about:blank' style='display:none'><html><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"/><head></html></iframe>").appendTo("body");
		}
		if(!form.ajax) {
			$form.append('<input type="hidden" name="ajax" value="1" />');
		}
		form.target = "callbackframe";
		
		this._iframeResponse($iframe[0], callback || DWZ.ajaxDone);
	}
	
	this.postFileFrmNoValidate = function (form, callback){
		var $form = $(form), $iframe = $("#callbackframe");

		if ($iframe.size() == 0) {
			$iframe = $("<iframe id='callbackframe' name='callbackframe' src='about:blank' style='display:none'><html><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"/><head></html></iframe>").appendTo("body");
		}
		if(!form.ajax) {
			$form.append('<input type="hidden" name="ajax" value="1" />');
		}
		form.target = "callbackframe";
		
		this._iframeResponse($iframe[0], callback || DWZ.ajaxDone);
	}
	
	this._iframeResponse = function(iframe, callback){
		var $iframe = $(iframe), $document = $(document);
		$("#progressBar").show();
		$iframe.bind("load", function(event){
			$iframe.unbind("load");
			$("#progressBar").hide();
			if (iframe.src == "javascript:'%3Chtml%3E%3C/html%3E';" || // For Safari
				iframe.src == "javascript:'<html></html>';") { // For FF, IE
				return;
			}
			var doc = iframe.contentDocument || iframe.document;
			// fixing Opera 9.26,10.00
			if (doc.readyState && doc.readyState != 'complete') return; 
			// fixing Opera 9.64
			if (doc.body && doc.body.innerHTML == "false") return;
			var response;
			if (doc.XMLDocument) {
				// response is a xml document Internet Explorer property
				response = doc.XMLDocument;
			} else if (doc.body){
				try{
					response = $iframe.contents().find("body").html();
					if(response.startsWith("<pre>")){
						response = response.replaceAll("<pre>","");
						response = response.replaceAll("</pre>","");
					}
				} catch (e){ // response is html document or plain text
					response = doc.body.innerHTML;
				}
			} else {
				// response is a xml document
				response = doc;
			}
			callback(response);
		});
	}
}
function XDMessage() {
	this.confirm = function(message, okFun, cFun) {
		alertMsg.confirm(message, {
			okCall : okFun,
			cancelCall : cFun
		});
	}
}
/**
 * 跟样式有关的js
 * 
 * @return
 */
function UIUtil() {
	/**
	 * 渲染表格样式
	 * @param boxId 表格的父节点ID，如果不输入，则按照document算
	 * @return
	 */
	this.initTable = function(boxId) {
		var $p = document.getElementById(boxId) || document;
		$("table.table", $p).jTable();
		$('table.list', $p).cssTable();
		$($p).find("[layoutH]").layoutH();
	}
	/**
	 * 渲染分页UI
	 * @param boxId
	 * @return
	 */
	this.initPageDiv=function(boxId){
		var $p = document;
		var box = document.getElementById(boxId);
		if (box) {
			$p = box;
		}
		$("div.panelBar li, div.panelBar", $p).hoverClass("hover");
		$("div.pagination", $p).each(function(){
			var $this = $(this);
			$this.pagination({
				targetType:$this.attr("targetType"),
				rel:$this.attr("rel"),
				totalCount:$this.attr("totalCount"),
				numPerPage:$this.attr("numPerPage"),
				pageNumShown:$this.attr("pageNumShown"),
				currentPage:$this.attr("currentPage"),
				xdfunc:$this.attr("xdfunc")
			});
		});
	}
	this.initValidateForm = function(boxId){
		var $p = document.getElementById(boxId) || document;
		$("form.required-validate", $p).each(function(){
			$(this).validate({
				focusInvalid: false,
				focusCleanup: true,
				errorElement: "span",
				ignore:".ignore",
				invalidHandler: function(form, validator) {
					var errors = validator.numberOfInvalids();
					if (errors) {
						var message = DWZ.msg("validateFormError",[errors]);
						alertMsg.error(message);
					} 
				}
			});
		});
	}
	this.frontInitValidateForm = function(boxId){
		var $p = document.getElementById(boxId) || document;
		$("form.required-validate", $p).each(function(){
			$(this).validate({
				focusInvalid: false,
				focusCleanup: true,
				errorElement: "span",
				ignore:".ignore",
				invalidHandler: function(form, validator) {
					var errors = validator.numberOfInvalids();
					if (errors) {
						alert("提交字段不完整，"+errors+"个字段有错误，请改正后再提交！");
					} 
				}
			});
		});
	}
	this.initPage=function(boxId){
		initUI(document.getElementById(boxId));
		this.initTable(boxId);
	}
	this.changeDivHeight= function(divId,plus){
		if(plus==null){
			plus = 360;
		}
		var height = $(window).height()-plus;
		$("#"+divId).height(height);
	}
}
/**
 * 公用的帮助方法
 * @return
 */
function XdTool(){
	this.checkAll=function(checkBox,checkName){
		$(document.getElementsByName(checkName)).each(function(){
			this.checked=checkBox.checked;
		});
	}
	/**
	 * 为当前tab页的url增加参数
	 * @param data
	 * @return
	 */
	this.addParamtsToURL = function(data){
		var curTab = (navTab._getTabs().eq(navTab._currentIndex));
		var url = curTab.attr("initurl");
		if(!url || url==""){
			url = curTab.attr("url");
			curTab.attr('initurl',url);//保存最开始的url
		}
		if(url.indexOf('?')!=-1){
			url +='&'+data;
		}else{
			url +='?'+data;
		}
		curTab.attr('url',url);
	}
}
/**
 * 树操作类
 * 
 * @return
 */
function PaltformDhtmlxTree() {
	/**
	 * 获取树对象
	 * 
	 * @param divId：树显示的divID
	 * @param dragAble：是否可以拖拽
	 * @return
	 */
	this.getTree = function(divId, dragAble, checkbox) {
		var tree = dhtmlXTreeFromHTML(divId, checkbox);
		if (!dragAble) {
			tree.enableDragAndDrop('temporary_disabled');
		}
		return tree;
	}
	/**
	 * 注册点击事件
	 * 
	 * @param tree
	 * @param func
	 * @return
	 */
	this.click = function(tree, func) {
		tree.setOnClickHandler(func);
	}
	/**
	 * 注册拖拽事件
	 * 
	 * @param tree
	 * @param func
	 * @return
	 */
	this.drag = function(tree, func) {
		tree.setDragHandler(func);
	}
	/**
	 * 删除节点
	 * 
	 * @param tree
	 * @param itemId
	 * @param parentSelect：删除节点后树是否选中被删除节点的父节点
	 * @return
	 */
	this.deleteItem = function(tree, itemId, parentSelect) {
		tree.deleteItem(itemId, parentSelect);
	}
	/**
	 * 获得用户自定义属性
	 * 
	 * @param tree
	 * @param itemId
	 * @param name
	 * @return
	 */
	this.getUserData = function(tree, itemId, name) {
		return tree.getUserData(itemId, name);
	}

	/**
	 * 选中一个节点
	 * 
	 * @param tree
	 * @param itemId
	 * @param mode
	 * @param preserve
	 * @return
	 */
	this.selectItem = function(tree, itemId, mode, preserve) {
		tree.selectItem(itemId, mode, preserve);
	}
	/**
	 * 注册checked事件
	 * 
	 * @param tree
	 * @param func
	 * @return
	 */
	this.check = function(tree, useDefaultFunc, func) {
		if (useDefaultFunc) {
			tree.setOnCheckHandler( function(itemId, state) {
				var tempId = itemId;
				if (state == 0) {
					tree.setSubChecked(itemId, 0);
				}
				while (tempId != "1" && tempId != "0" && tempId != "") {
					tempId = tree.getParentId(tempId);
					if (state == 1) {
						tree.setCheck(tempId, state);
					}
				}
				if (window.event) {
					if (window.event.shiftKey) {
						tree.setSubChecked(itemId, state);
					}
				}
			});
		} else {
			tree.setOnCheckHandler(func);
		}
	}
}
/**
 * 设置div隐藏和展现
 * @param showId
 * @param group
 * @param showClass
 * @param hideClass
 * @return
 */
function showHideDiv(showId,group,showClass,hideClass){
	var divId = showId+'Div';
	var titleId;
	$("div[group="+group+"]").each(function(){
		if($(this).attr('id') == divId){
			$(this).show();
			$("#"+showId).addClass(showClass);
			$("#"+showId).removeClass(hideClass);
		}else{
			$(this).hide();
			titleId = $(this).attr('id').replace('Div','');
			$("#"+titleId).addClass(hideClass);
			$("#"+titleId).removeClass(showClass);
		}
	});
}
//设置当前登陆者信息
function setLoginUserInfo(){
	var url="/gad/getLoginUserInfo.dhtml";
	var options = {
			async : true,
			cache : false,
			url : url,
			type : "POST",
			success : function(data, textStatus) {
				if(data!="" && data.length>2){
					var message = eval('(' + data + ')'); 
					$("#buttonDiv").html('<a href="/gad/index.dhtml" style="padding-left:10px;" target="_blank">Hi,'+message['username']+'</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="#" style="padding-left:10px;" onclick="closeGadSession();" >退出登录</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="/agency/login.jsp" target="_blank">经销商登录</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="/dealers/login.jsp" target="_blank">金融机构登录</a>');
				}
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
			}
	};
	$.ajax(options);
}
//判断用户是否已经登录
function isLogin(){
	var user = $("#buttonDiv").html();
	if(user.indexOf('退出登录')==-1){
		return false;
	} else {
		return true;
	}
}