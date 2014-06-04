package com.dlts.bill.service;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.Map.Entry;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import com.dlts.account.domain.Account;
import com.dlts.account.service.AccountService;
import com.dlts.base.service.BaseService;
import com.dlts.bill.domain.Bill;
import com.dlts.billitem.domain.BillItem;
import com.dlts.monthduration.domain.MonthDuration;
import com.dlts.service.domain.Service;
import com.dlts.service.service.ServiceService;
import com.dlts.util.dao.DCriteriaPageSupport;

public class BillService extends BaseService {
	private AccountService accountService;
	private ServiceService serviceService;
	/**
	 * 分页查询账单表
	 * 
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	public DCriteriaPageSupport<Bill> list(int pageNo, int pageSize) {
		DetachedCriteria dc = DetachedCriteria.forClass(Bill.class);
		dc.addOrder(Order.desc("bill_month"));
		DCriteriaPageSupport list = this.dao.findPageByCriteria(dc, pageSize,
				pageNo);
		int size = list == null || "".equals(list) ? 0 : list.size();
		for(int i = 0; i<size; i++){
			Bill bill = (Bill) list.get(i);
			Account account = accountService.getAccountById(bill.getAccount_id());
			bill.setAccount(account);
		}
		return list;
	}

	/**
	 * 搜索
	 * @param form
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	public DCriteriaPageSupport<Bill> search(Bill form,int pageNo,int pageSize){
		DetachedCriteria dc = DetachedCriteria.forClass(Bill.class);
		if (form != null && !"".equals(form)) {
			if (form.getAccount().getIdcard_no() != null && !"".equals(form.getAccount().getIdcard_no())) {
				Account account = accountService.getAccountByIdcard_no(form.getAccount().getIdcard_no());
				if(account!=null){
					dc.add(Restrictions.eq("account_id", account.getId()));
				}else{
					dc.add(Restrictions.eq("account_id", null));
				}
			}
			if (form.getAccount().getReal_name() != null && !"".equals(form.getAccount().getReal_name())) {
				Account account = accountService.getAccountByReal_name(form.getAccount().getReal_name());
				if(account!=null){
					dc.add(Restrictions.eq("account_id", account.getId()));
				}else{
					dc.add(Restrictions.eq("account_id", null));
				}
			}
			if (form.getAccount().getLogin_name() != null && !"".equals(form.getAccount().getLogin_name())) {
				Account account = accountService.getAccountByLogin_name(form.getAccount().getLogin_name());
				if(account!=null){
					dc.add(Restrictions.eq("account_id", account.getId()));
				}else{
					dc.add(Restrictions.eq("account_id", null));
				}
			}
			if(form.getBill_month()!=null&&!"".equals(form.getBill_month())){
				Date date = form.getBill_month();
				Calendar now = Calendar.getInstance();
				now.setTime(date);
				Calendar next = Calendar.getInstance();
				next.setTime(date);
				next.add(Calendar.MONTH, 1);
				System.out.println(now.getTime());
				System.out.println(next.getTime());
				dc.add(Restrictions.ge("bill_month", now.getTime()));
				dc.add(Restrictions.lt("bill_month", next.getTime()));
			}else{
				dc.addOrder(Order.desc("bill_month"));
			}
		}
		DCriteriaPageSupport<Bill> billList = this.dao.findPageByCriteria(dc,pageSize,pageNo);
		DCriteriaPageSupport<Account> accountList = accountService.getAll();
		if(billList!=null&&!"".equals(billList)){
			for(Bill b : billList){
				for(Account a : accountList){
					if(a.getId().equals(b.getAccount_id())){
						b.setAccount(a);
						break;
					}
				}
			}
		}
		return billList;
	}
	
	/**
	 * 获取某个账单的账单条目
	 * @param bill_id
	 * @return
	 */
	public List<BillItem> getBillItemList(String bill_id){
		String hql1 = "select b.account_id,b.bill_month,b.cost,bi.id,bi.bill_id,bi.service_id,bi.cost,m.sofar_duration from Bill b,BillItem bi,MonthDuration m where b.id=bi.bill_id and b.id=? and m.id.service_id=bi.service_id";
		List list1 = this.dao.findAllyHql(hql1, new Object[]{bill_id});
		List<BillItem> biList = new ArrayList<BillItem>();
		if(list1!=null&&list1.size()>0){
			int size = list1.size();
			BillItem billItem = null;
			Bill bill = null;
			MonthDuration monthDuration = null;
			for(int i = 0; i<size; i++){
				Object[] o = (Object[]) list1.get(i);
				billItem = new BillItem();
				billItem.setId((String) o[3]);
				billItem.setBill_id((String) o[4]);
				billItem.setService_id((String) o[5]);
				Service service = serviceService.getServiceById((String) o[5]);
				billItem.setService(service);
				billItem.setCost((Float) o[6]);
				monthDuration = new MonthDuration();
				monthDuration.setSofar_duration((Integer) o[7]);
				billItem.setMonthDuration(monthDuration);
				bill = new Bill();
				bill.setAccount_id((String) o[0]);
				bill.setBill_month((Date) o[1]);
				bill.setCost((Float) o[2]);
				billItem.setBill(bill);
				biList.add(billItem);
			}
		}
		return biList;
	}
	
	/**
	 * 计算每个月每个账务的费用
	 */
	public void updateTotalMonthCost() {
		Map<String, Bill> billMap = new HashMap<String, Bill>();
		List<BillItem> billItemList = new ArrayList<BillItem>();
		String hql = "select s.account_id,f.base_duration,f.base_cost,f.unit_cost,f.cost_type,s.id from Service as s,Fee as f where s.cost_id=f.id and s.status='0'";
		List list = this.dao.findAllyHql(hql, new Object[] {});
		String hql1 = "from MonthDuration where month_id > ? and month_id <= ? ";
		// 这个月
		Calendar now = Calendar.getInstance();
		// 上个月
		Calendar last = Calendar.getInstance();
		last.add(Calendar.MONTH, -1);
		// 获取这个月所有业务的时长
		List monthList = this.dao.findAllyHql(hql1, new Object[] { last.getTime(), now.getTime() });
		int size = list == null ? 0 : list.size();
		int monthListSize = monthList == null ? 0 : monthList.size();
		Bill bill = null;
		BillItem billItem = null;
		for (int i = 0; i < size; i++) {
			Object[] o = (Object[]) list.get(i);
			billItem = new BillItem();
			billItem.setService_id((String) o[5]);
			bill = billMap.get(o[0]);
			if(bill==null){
				String bill_id = UUID.randomUUID().toString().replace("-", "");
				bill = new Bill();
				bill.setId(bill_id);
				billItem.setBill_id(bill_id);
			}else{
				billItem.setBill_id(bill.getId());
			}
			if (!"1".equals(o[4])) {
				for (int j = 0; j < monthListSize; j++) {
					MonthDuration md = (MonthDuration) monthList.get(j);
					if (md.getId().getService_id().equals(o[0])) {
						Float base_cost = (Float) o[2];
						Float unit_cost = (Float) o[3];
						Integer base_duration = (Integer) o[1];
						float cost = md.getSofar_duration() > base_duration ? (base_cost + (md.getSofar_duration() - base_duration) * unit_cost) : (base_cost);
						billItem.setCost(cost);
						if (bill.getAccount_id() == null || "".equals(bill.getAccount_id())) {
							bill.setAccount_id((String) o[0]);
							bill.setBill_month(new Date());
							bill.setPay_state("0");
							bill.setCost(cost);
							break;
						} else {
							bill.setCost(bill.getCost() + cost);
							break;
						}
					}
				}
			} else {
				for (int j = 0; j < monthListSize; j++) {
					MonthDuration md = (MonthDuration) monthList.get(j);
					if (md.getId().getService_id().equals(o[0])) {
						Float base_cost = (Float) o[2];
						billItem.setCost(base_cost);
						if (bill.getAccount_id() == null
								|| "".equals(bill.getAccount_id())) {
							bill.setAccount_id((String) o[0]);
							bill.setBill_month(new Date());
							bill.setPay_state("0");
							bill.setCost(base_cost);
							break;
						} else {
							bill.setCost(bill.getCost() + base_cost);
							break;
						}
					}
				}
			}
			billMap.put(bill.getAccount_id(), bill);
			billItemList.add(billItem);
		}
		for (Entry<String, Bill> en : billMap.entrySet()) {
			this.dao.saveIObject(en.getValue());
		}
		countBillItem(billItemList);
	}
	
	/**
	 * 保存账单条目
	 * @param list
	 */
	public void countBillItem(List<BillItem> list){
		for(BillItem bi : list){
			this.dao.saveIObject(bi);
		}
	}

	public AccountService getAccountService() {
		return accountService;
	}

	public void setAccountService(AccountService accountService) {
		this.accountService = accountService;
	}

	public ServiceService getServiceService() {
		return serviceService;
	}

	public void setServiceService(ServiceService serviceService) {
		this.serviceService = serviceService;
	}

	
}
