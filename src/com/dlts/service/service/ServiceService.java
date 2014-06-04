package com.dlts.service.service;

import java.util.Date;
import java.util.List;

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
import com.dlts.service.domain.ServiceBak;
import com.dlts.util.MD5Util;
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
	 * 修改操作
	 * @param service
	 * @return
	 */
	public boolean updateService(Service service){
		boolean result = false;
		if(service!=null){
			ServiceBak serviceBak = null;
			String hql = "from ServiceBak where service_id=?";
			List list = this.dao.findAllyHql(hql, new Object[]{service.getId()});
			if(list==null||list.size()<=0){
				serviceBak = new ServiceBak();
				serviceBak.setCost_id(service.getCost_id());
				serviceBak.setService_id(service.getId());
				this.dao.saveIObject(serviceBak);
				result = true;
			}else{
				serviceBak = (ServiceBak) list.get(0);
				serviceBak.setCost_id(service.getCost_id());
				this.dao.saveOrUpdateIObject(serviceBak);
			}
			result = true;
		}
		return result;
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

	/**
	 * 根据账务id暂停业务
	 * @param account_id
	 * @return
	 */
	public boolean updateServiceStopByAccount_id(String account_id){
		boolean result = false;
		String hql = "update Service set status=?,pause_date=? where account_id=?";
		if(account_id!=null&&!"".equals(account_id)){
			this.dao.execByHQL(hql, new Object[]{"1",new Date(),account_id});
			result = true;
		}
		return result;
	}
	
	/**
	 * 根据账务id删除业务
	 * @param account_id
	 * @return
	 */
	public boolean deleteByAccount_id(String account_id){
		boolean result = false;
		String hql = "update Service set status=?,close_date=? where account_id=?";
		if(account_id!=null&&!"".equals(account_id)){
			this.dao.execByHQL(hql, new Object[]{"2",new Date(),account_id});
			result = true;
		}
		return result;
	}
	/**
	 * 开启业务（先判断该业务的所对应的账务是否是开启的）
	 * @param id
	 * @return
	 */
	public String updateServiceStart(String id){
		String result = null;
		Service service = getServiceById(id);
		Account account = accountService.getAccountById(service.getAccount_id());
		Fee fee = feeService.getFeeById(service.getCost_id());
		if("0".equals(account.getStatus())||account.getStatus()=="0"){
			if(fee.getStatus()=='0'){
				String hql = "update Service set status=?,pause_date=? where id=?";
				if(id!=null&&!"".equals(id)){
					int i = this.dao.execByHQL(hql, new Object[]{"0",null,id});
					if(i<0){
						result = "开启失败";
					}
				}
			}else{
				result="开启失败,选择的资费未开启";
			}
		}else{
			result="开启失败,账务账号已暂停";
		}
		return result;
	}
	
	/**
	 *暂停业务
	 */
	public boolean updateServiceStop(String id){
		boolean result = false;
		String hql = "update Service set status=?,pause_date=? where id=?";
		if(id!=null&&!"".equals(id)){
			int i = this.dao.execByHQL(hql, new Object[]{"1",new Date(),id});
			if(i>0){
				result = true;
			}
		}
		return result;
	}
	/**
	 * 删除业务
	 * @param id
	 * @return
	 */
	public boolean updateServiceDelete(String id){
		boolean result = false;
		String hql = "update Service set status=?,close_date=? where id=?"	;
		if(id!=null&&!"".equals(id)){
			int i = this.dao.execByHQL(hql, new Object[]{"2",new Date(),id});
			if(i>0){
				result = true;
			}
		}
		return result;
	}
	/**
	 * 保存业务
	 * @param service
	 * @return
	 */
	public boolean saveService(Service service){
		boolean result = false;
		if(service!=null){
			service.setStatus("0");
			service.setLogin_passwd(MD5Util.MD5(service.getLogin_passwd()));
			service.setCreate_date(new Date());
			this.dao.saveIObject(service);
			result = true;
		}
		return result;
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
