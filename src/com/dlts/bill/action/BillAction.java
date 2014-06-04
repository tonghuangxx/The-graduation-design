package com.dlts.bill.action;

import java.util.Calendar;
import java.util.List;

import com.dlts.bill.domain.Bill;
import com.dlts.bill.service.BillService;
import com.dlts.billitem.domain.BillItem;
import com.dlts.service.domain.Service;
import com.dlts.util.SpringUtil;
import com.dlts.util.dao.DCriteriaPageSupport;
import com.dlts.util.string.ConstantString;
import com.dlts.web.action.BaseAction;

public class BillAction extends BaseAction{
	private BillService billService = (BillService) SpringUtil.getWebApplicationContext().getBean("billService");
	private DCriteriaPageSupport<Bill> billList;
	private Bill form;
	/**
	 * 搜索时选择的年
	 */
	private String selYears;
	/**
	 * 搜索时选择的月
	 */
	private String selMonths;
	private List<BillItem> billItemList;
	private Bill bill;
	private Service service;
	/**
	 * 分页显示数据
	 * @return
	 */
	public String listData(){
		billList = billService.list(pageNum, numPerPage);
		total = billList.getTotalCount();
		countPageCount();
		return ConstantString.SUCCESS;
	}
	/**
	 * 搜索
	 * @return
	 */
	public String search(){
		if(selMonths!=null&&!"".equals(selMonths)){
			Calendar c = Calendar.getInstance();
			c.set(Calendar.MONTH, Integer.parseInt(selMonths)-1);
			c.set(Calendar.YEAR,Integer.parseInt(selYears));
			c.set(Calendar.DAY_OF_MONTH, 1);
			form.setBill_month(c.getTime());
		}
		billList = billService.search(form,pageNum, numPerPage);
		total = billList.getTotalCount();
		countPageCount();
		return ConstantString.SUCCESS;
	}
	/**
	 * 获取某个账单的账单条目
	 * @return
	 */
	public String getBillItem(){
		billItemList = billService.getBillItemList(bill.getId());
		BillItem b = billItemList.get(0);
		service = b.getService();
		bill = b.getBill();
		return ConstantString.SUCCESS;
	}
	
	public DCriteriaPageSupport<Bill> getBillList() {
		return billList;
	}
	public void setBillList(DCriteriaPageSupport<Bill> billList) {
		this.billList = billList;
	}
	public Bill getForm() {
		return form;
	}
	public void setForm(Bill form) {
		this.form = form;
	}
	public String getSelYears() {
		return selYears;
	}
	public void setSelYears(String selYears) {
		this.selYears = selYears;
	}
	public String getSelMonths() {
		return selMonths;
	}
	public void setSelMonths(String selMonths) {
		this.selMonths = selMonths;
	}
	public List<BillItem> getBillItemList() {
		return billItemList;
	}
	public void setBillItemList(List<BillItem> billItemList) {
		this.billItemList = billItemList;
	}
	public Bill getBill() {
		return bill;
	}
	public void setBill(Bill bill) {
		this.bill = bill;
	}
	public Service getService() {
		return service;
	}
	public void setService(Service service) {
		this.service = service;
	}
	
}
