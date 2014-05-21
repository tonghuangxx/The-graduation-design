package com.dlts.service.action;

import com.dlts.service.domain.Service;
import com.dlts.service.service.ServiceService;
import com.dlts.util.SpringUtil;
import com.dlts.util.dao.DCriteriaPageSupport;
import com.dlts.util.string.ConstantString;
import com.dlts.web.action.BaseAction;

public class ServiceAction extends BaseAction{
	private ServiceService serviceService = (ServiceService) SpringUtil.getWebApplicationContext().getBean("serviceService");
	private DCriteriaPageSupport<Service> serviceList;
	private Service service;
	/**
	 * 搜索条件
	 */
	private Service form;
	/**
	 * 分页显示数据
	 * @return
	 */
	public String listData(){
		serviceList = serviceService.list(pageNum, numPerPage);
		total = serviceList.getTotalCount();
		countPageCount();
		return ConstantString.SUCCESS;
	}
	
	/**
	 * 详细界面
	 * @return
	 */
	public String detail(){
		numPerPage=this.getNumPerPage();
		pageNum=this.getPageNum();
		service = serviceService.getServiceById(service.getId());
		return ConstantString.SUCCESS;
	}
	
	/**
	 * 搜索
	 * @return
	 */
	public String search(){
		serviceList = serviceService.search(form,pageNum, numPerPage);
		total = serviceList.getTotalCount();
		countPageCount();
		return ConstantString.SUCCESS;
	}
	
	public DCriteriaPageSupport<Service> getServiceList() {
		return serviceList;
	}
	public void setServiceList(DCriteriaPageSupport<Service> serviceList) {
		this.serviceList = serviceList;
	}

	public Service getService() {
		return service;
	}

	public void setService(Service service) {
		this.service = service;
	}

	public Service getForm() {
		return form;
	}

	public void setForm(Service form) {
		this.form = form;
	}
	
}

