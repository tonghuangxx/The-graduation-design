package com.dlts.fee.action;

import com.dlts.fee.domain.Fee;
import com.dlts.fee.service.FeeService;
import com.dlts.util.SpringUtil;
import com.dlts.util.dao.DCriteriaPageSupport;
import com.dlts.util.string.ConstantString;
import com.dlts.web.action.BaseAction;

public class FeeAction extends BaseAction{
	private FeeService feeService = (FeeService) SpringUtil.getWebApplicationContext().getBean("feeService");
	/**
	 * 显示index页面的内容
	 */
	private String indexList;
	private DCriteriaPageSupport<Fee> feeList;
	/**
	 * 跳转到显示页面
	 * @return
	 */
	public String list(){
		indexList=this.getIndexList();
		return ConstantString.SUCCESS;
	}
	
	/**
	 * 分页显示数据
	 * @return
	 */
	public String listData(){
		feeList = feeService.list(pageNum, numPerPage);
		total = feeList.getTotalCount();
		countPageCount();
		return ConstantString.SUCCESS;
	}
	/**
	 * 排序
	 * @return
	 */
	public String sort(){
		feeList = feeService.list(pageNum, numPerPage);
		total = feeList.getTotalCount();
		countPageCount();
		return ConstantString.SUCCESS;
	}
	
	public String getIndexList() {
		return indexList;
	}
	public void setIndexList(String indexList) {
		this.indexList = indexList;
	}
	public DCriteriaPageSupport<Fee> getFeeList() {
		return feeList;
	}
	public void setFeeList(DCriteriaPageSupport<Fee> feeList) {
		this.feeList = feeList;
	}
	
}
