package com.dlts.service.action;

import java.io.IOException;
import java.io.PrintWriter;

import com.dlts.account.domain.Account;
import com.dlts.account.service.AccountService;
import com.dlts.fee.domain.Fee;
import com.dlts.fee.service.FeeService;
import com.dlts.host.domain.Host;
import com.dlts.host.service.HostService;
import com.dlts.service.domain.Service;
import com.dlts.service.service.ServiceService;
import com.dlts.util.ContextUtil;
import com.dlts.util.SpringUtil;
import com.dlts.util.dao.DCriteriaPageSupport;
import com.dlts.util.string.ConstantString;
import com.dlts.web.action.ActionResult;
import com.dlts.web.action.BaseAction;

public class ServiceAction extends BaseAction{
	private ServiceService serviceService = (ServiceService) SpringUtil.getWebApplicationContext().getBean("serviceService");
	private FeeService feeService = (FeeService) SpringUtil.getWebApplicationContext().getBean("feeService");
	private HostService hostService = (HostService) SpringUtil.getWebApplicationContext().getBean("hostService");
	private AccountService accountService = (AccountService) SpringUtil.getWebApplicationContext().getBean("accountService");
	private DCriteriaPageSupport<Service> serviceList;
	private Service service;
	/**
	 * 所有开通的资费
	 */
	private DCriteriaPageSupport<Fee> feeList;
	/**
	 * 所有服务器
	 */
	private DCriteriaPageSupport<Host> hostList;
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
	
	/**
	 * 跳转到修改界面
	 * @return
	 */
	public String edit(){
		numPerPage = this.getNumPerPage();
		pageNum= this.getPageNum();
		feeList = feeService.getAllStartFee();
		service = serviceService.getServiceById(service.getId());
		return ConstantString.SUCCESS;
	}
	
	/**
	 * 修改操作
	 */
	public void editDo(){
		response.setContentType("text/html;charset=utf-8");
		boolean result = serviceService.updateService(service);
		try {
			ActionResult actionResult = new ActionResult(ConstantString.SUCCESSCODE, "修改成功");
			if(!result){
				actionResult = new ActionResult(ConstantString.FAILURECODE,"修改失败,原密码输入有误");
			}
			PrintWriter out = response.getWriter();
			out.print(ContextUtil.resultToJson(actionResult));
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 开启
	 */
	public void start(){
		response.setContentType("text/html;charset=utf-8");
		String result = serviceService.updateServiceStart(service.getId());
		try {
			ActionResult actionResult = new ActionResult(ConstantString.SUCCESSCODE, "开启成功");
			if(result!=null){
				actionResult = new ActionResult(ConstantString.FAILURECODE,result);
			}
			PrintWriter out = response.getWriter();
			out.print(ContextUtil.resultToJson(actionResult));
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	/**
	 * 暂停
	 */
	public void stop(){
		response.setContentType("text/html;charset=utf-8");
		boolean result = serviceService.updateServiceStop(service.getId());
		try {
			ActionResult actionResult = new ActionResult(ConstantString.SUCCESSCODE, "暂停成功");
			if(!result){
				actionResult = new ActionResult(ConstantString.FAILURECODE,"暂停失败");
			}
			PrintWriter out = response.getWriter();
			out.print(ContextUtil.resultToJson(actionResult));
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 删除
	 */
	public void delete(){
		response.setContentType("text/html;charset=utf-8");
		boolean result = serviceService.updateServiceDelete(service.getId());
		try {
			ActionResult actionResult = new ActionResult(ConstantString.SUCCESSCODE, "删除成功");
			if(!result){
				actionResult = new ActionResult(ConstantString.FAILURECODE,"删除失败");
			}
			PrintWriter out = response.getWriter();
			out.print(ContextUtil.resultToJson(actionResult));
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 跳转到添加界面
	 * @return
	 */
	public String add(){
		feeList = feeService.getAllStartFee();
		hostList = hostService.getAllHost();
		return ConstantString.SUCCESS;
	}
	
	/**
	 * 添加操作
	 */
	public void addDo(){
		response.setContentType("text/html;charset=utf-8");
		boolean result = serviceService.saveService(service);
		try {
			ActionResult actionResult = new ActionResult(ConstantString.SUCCESSCODE, "添加成功");
			if(!result){
				actionResult = new ActionResult(ConstantString.FAILURECODE,"添加失败");
			}
			PrintWriter out = response.getWriter();
			out.print(ContextUtil.resultToJson(actionResult));
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 检测身份证号是否存在账务表中
	 */
	public void checkIdcard_no(){
		response.setContentType("text/html;charset=utf-8");
		Account account = accountService.getAccountByIdcard_no(service.getAccount().getIdcard_no());
		try {
			ActionResult actionResult = null;
			if(account==null||"".equals(account)){
				actionResult = new ActionResult(ConstantString.FAILURECODE,"没有此身份证号");
			}else{
				actionResult = new ActionResult(ConstantString.SUCCESSCODE, account.getId());
			}
			PrintWriter out = response.getWriter();
			out.print(ContextUtil.resultToJson(actionResult));
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
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

	public DCriteriaPageSupport<Fee> getFeeList() {
		return feeList;
	}

	public void setFeeList(DCriteriaPageSupport<Fee> feeList) {
		this.feeList = feeList;
	}

	public DCriteriaPageSupport<Host> getHostList() {
		return hostList;
	}

	public void setHostList(DCriteriaPageSupport<Host> hostList) {
		this.hostList = hostList;
	}

}

