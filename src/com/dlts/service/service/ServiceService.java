package com.dlts.service.service;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import com.dlts.account.domain.Account;
import com.dlts.account.service.AccountService;
import com.dlts.base.service.BaseService;
import com.dlts.fee.domain.Fee;
import com.dlts.fee.service.FeeService;
import com.dlts.host.domain.Host;
import com.dlts.host.service.HostService;
import com.dlts.service.domain.Service;
import com.dlts.util.dao.DCriteriaPageSupport;

public class ServiceService extends BaseService {
	private FeeService feeService;
	private AccountService accountService;
	private HostService hostService;

	/**
	 * 分页查询
	 * 
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	public DCriteriaPageSupport<Service> list(int pageNo, int pageSize) {
		DetachedCriteria dc = DetachedCriteria.forClass(Service.class);
		dc.addOrder(Order.desc("create_date"));
		DCriteriaPageSupport<Service> serviceList = this.dao.findPageByCriteria(dc, pageSize, pageNo);
		DCriteriaPageSupport<Fee> feeList = feeService.getAll();
		DCriteriaPageSupport<Account> accountList = accountService.getAll();
		DCriteriaPageSupport<Host> hostList = hostService.getAllHost();
		for (Service s : serviceList) {
			for (Fee f : feeList) {
				if (s.getCost_id().equals(f.getId())) {
					s.setFee(f);
					break;
				}
			}
			for (Account a : accountList) {
				if (s.getAccount_id().equals(a.getId())) {
					s.setAccount(a);
					break;
				}
			}
			for (Host h : hostList) {
				if (s.getUnix_host().equals(h.getId())) {
					s.setHost(h);
					break;
				}
			}
		}
		return serviceList;
	}

	/**
	 * 根据id获取业务信息
	 * 
	 * @param id
	 * @return
	 */
	public Service getServiceById(String id) {
		Service service = (Service) this.dao.getIObjectByPK(Service.class, id);
		service.setFee(feeService.getFeeById(service.getCost_id()));
		service.setHost(hostService.getHostById(service.getUnix_host()));
		service.setAccount(accountService.getAccountById(service.getAccount_id()));
		return service;
	}

	/**
	 * 搜索
	 * 
	 * @param form
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	public DCriteriaPageSupport<Service> search(Service form, int pageNo, int pageSize) {
		DetachedCriteria dc = DetachedCriteria.forClass(Service.class);
		if (form != null && !"".equals(form)) {
			if (form.getOs_username() != null && !"".equals(form.getOs_username())) {
				dc.add(Restrictions.ilike("os_username", form.getOs_username(), MatchMode.ANYWHERE));
			}
			if (form.getHost().getHost_ip() != null && !"".equals(form.getHost().getHost_ip())) {
				Host host = hostService.getHostByHost_ip(form.getHost().getHost_ip());
				if(host!=null){
					dc.add(Restrictions.eq("unix_host", host.getId()));
				}else{
					dc.add(Restrictions.eq("unix_host", null));
				}
			}
			if (form.getAccount().getIdcard_no() != null && !"".equals(form.getAccount().getIdcard_no())) {
				Account account = accountService.getAccountByIdcard_no(form.getAccount().getIdcard_no());
				if(account!=null){
					dc.add(Restrictions.eq("account_id", account.getId()));
				}else{
					dc.add(Restrictions.eq("account_id", null));
				}
			}
			if (form.getStatus() != null && !"".equals(form.getStatus())) {
				dc.add(Restrictions.eq("status", form.getStatus()));
			}
		}
		dc.addOrder(Order.desc("create_date"));
		DCriteriaPageSupport<Service> serviceList = this.dao.findPageByCriteria(dc, pageSize, pageNo);
		DCriteriaPageSupport<Fee> feeList = feeService.getAll();
		DCriteriaPageSupport<Account> accountList = accountService.getAll();
		DCriteriaPageSupport<Host> hostList = hostService.getAllHost();
		if (serviceList != null && !"".equals(serviceList)) {
			for (Service s : serviceList) {
				for (Fee f : feeList) {
					if (s.getCost_id().equals(f.getId())) {
						s.setFee(f);
						break;
					}
				}
				for (Account a : accountList) {
					if (s.getAccount_id().equals(a.getId())) {
						s.setAccount(a);
						break;
					}
				}
				for (Host h : hostList) {
					if (s.getUnix_host().equals(h.getId())) {
						s.setHost(h);
						break;
					}
				}
			}
		}
		return serviceList;
	}

	public FeeService getFeeService() {
		return feeService;
	}

	public void setFeeService(FeeService feeService) {
		this.feeService = feeService;
	}

	public AccountService getAccountService() {
		return accountService;
	}

	public void setAccountService(AccountService accountService) {
		this.accountService = accountService;
	}

	public HostService getHostService() {
		return hostService;
	}

	public void setHostService(HostService hostService) {
		this.hostService = hostService;
	}

}
