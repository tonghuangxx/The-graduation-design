package com.dlts.admininfo.action;

import java.io.IOException;
import java.io.PrintWriter;

import com.dlts.admininfo.domain.AdminInfo;
import com.dlts.admininfo.servcie.UserService;
import com.dlts.util.SpringUtil;
import com.dlts.util.dao.DCriteriaPageSupport;
import com.dlts.util.string.ConstantString;
import com.dlts.web.action.BaseAction;

public class UserAction extends BaseAction{
	private UserService userService = (UserService) SpringUtil.getWebApplicationContext().getBean("userService");
	private DCriteriaPageSupport<AdminInfo> dataList;
	/**
	 * 分页显示用户及其所含角色信息
	 * @return
	 */
	public String list(){
		dataList = userService.list(pageNum, numPerPage);
		total = dataList.getTotalCount();
		getPageCount();
		return ConstantString.SUCCESS;
	}
	public DCriteriaPageSupport<AdminInfo> getDataList() {
		return dataList;
	}
	public void setDataList(DCriteriaPageSupport<AdminInfo> dataList) {
		this.dataList = dataList;
	}
	
}
