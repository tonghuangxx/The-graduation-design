package com.dlts.account.service;

import java.util.Date;
import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import com.dlts.account.domain.Account;
import com.dlts.base.service.BaseService;
import com.dlts.service.service.ServiceService;
import com.dlts.util.MD5Util;
import com.dlts.util.dao.DCriteriaPageSupport;

public class AccountService extends BaseService{
	private ServiceService serviceService;
	/**
	 * 分页查询数据
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	public DCriteriaPageSupport<Account> list(int pageNo,int pageSize){
		DetachedCriteria dc = DetachedCriteria.forClass(Account.class);
		dc.addOrder(Order.desc("create_date"));
		return this.dao.findPageByCriteria(dc,pageSize,pageNo);
	}
	/**
	 * 搜索
	 * @param form
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	public DCriteriaPageSupport<Account> search(Account form,int pageNo,int pageSize){
		DetachedCriteria dc = DetachedCriteria.forClass(Account.class);
		if(form!=null&&!"".equals(form)){
			if(form.getLogin_name()!=null&&!"".equals(form.getLogin_name())){
				dc.add(Restrictions.ilike("login_name", form.getLogin_name(), MatchMode.ANYWHERE));
			}
			if(form.getReal_name()!=null&&!"".equals(form.getReal_name())){
				dc.add(Restrictions.ilike("real_name", form.getReal_name(), MatchMode.ANYWHERE));
			}
			if(form.getIdcard_no()!=null&&!"".equals(form.getIdcard_no())){
				dc.add(Restrictions.ilike("idcard_no", form.getIdcard_no(), MatchMode.ANYWHERE));
			}
			if(form.getStatus()!=null&&!"".equals(form.getStatus())){
				dc.add(Restrictions.eq("status", form.getStatus()));
			}
		}
		dc.addOrder(Order.desc("create_date"));
		return this.dao.findPageByCriteria(dc,pageSize,pageNo);
	}
	
	/**
	 * 根据id获取
	 * @param id
	 * @return
	 */
	public Account getAccountById(String id){
		Account account = (Account) this.dao.getIObjectByPK(Account.class, id);
		Account recommender = (Account) this.dao.getIObjectByPK(Account.class, account.getRecommender_id());
		account.setRecommender(recommender);
		return account;
	}
	/**
	 * 修改
	 * @param account
	 * @return
	 */
	public boolean updateAccount(Account account,String newPwd,String oldPwd){
		boolean result = false;
		if(account!=null){
			if(oldPwd!=null&&!"".equals(oldPwd)){
				if(account.getLogin_passwd().equals(MD5Util.MD5(oldPwd))){
					if(newPwd!=null||!"".equals(newPwd)){
						account.setLogin_passwd(MD5Util.MD5(newPwd));
						this.dao.updateIObject(account);
						result = true;
					}
				}
			}
		}
		return result;
	}
	
	/**
	 * 开启
	 * @param id
	 * @return
	 */
	public boolean updateAccountStart(String id){
		boolean result = false;
		String hql = "update Account set status=?,pause_date=? where id=?";
		if(id!=null&&!"".equals(id)){
			this.dao.execByHQL(hql, new Object[]{"0",null,id});
			result = true;
		}
		return result;
	}
	/**
	 * 暂停
	 * @param id
	 * @return
	 */
	public boolean updateAccountStop(String id){
		boolean result = false;
		String hql = "update Account set status=?,pause_date=? where id=?";
		if(id!=null&&!"".equals(id)){
			int i = this.dao.execByHQL(hql, new Object[]{"1",new Date(),id});
			if(i>0){
				boolean flag = serviceService.updateServiceStopByAccount_id(id);
				result = flag;
			}
		}
		return result;
	}
	/**
	 * 删除
	 * @param id
	 * @return
	 */
	public boolean delete(String id){
		boolean result = false;
		String hql = "update Account set status=?,close_date=? where id=?";
		if(id!=null&&!"".equals(id)){
			int i = this.dao.execByHQL(hql, new Object[]{"2",new Date(),id});
			if(i>0){
				result = serviceService.deleteByAccount_id(id);
			}
		}
		return result;
	}
	
	/**
	 * 添加
	 * @param account
	 * @return
	 */
	public boolean saveAccount(Account account){
		boolean result = false;
		if(account!=null){
			account.setLogin_passwd(MD5Util.MD5(account.getLogin_passwd()));
			account.setStatus("0");
			Account acc = getAccountByIdcard_no(account.getRecommender().getIdcard_no());
			if(acc!=null){
				account.setRecommender_id(acc.getId());
			}
			this.dao.saveIObject(account);
			result = true;
		}
		return result;
	}
	/**
	 * 根据身份证查询
	 * @param recommender_id
	 * @return
	 */
	public Account getAccountByIdcard_no(String idcard_no){
		String hql = "from Account where idcard_no=?";
		List list = this.dao.findAllyHql(hql, new Object[]{idcard_no});
		return list==null||list.size()<=0?null:(Account)list.get(0);
	}
	
	/**
	 * 根据姓名查询
	 * @param real_name
	 * @return
	 */
	public Account getAccountByReal_name(String real_name){
		String hql = "from Account where real_name=?";
		List list = this.dao.findAllyHql(hql, new Object[]{real_name});
		return list==null||list.size()<=0?null:(Account)list.get(0);
	}
	
	/**
	 * 根据账号查询
	 * @param login_name
	 * @return
	 */
	public Account getAccountByLogin_name(String login_name){
		String hql = "from Account where login_name=?";
		List list = this.dao.findAllyHql(hql, new Object[]{login_name});
		return list==null||list.size()<=0?null:(Account)list.get(0);
	}
	
	/**
	 * 跟新推荐人id
	 * @param account
	 */
	public void updateAccountRecommender_id(Account account){
		this.dao.updateIObject(account);
	}
	
	/**
	 * 获取所有数据
	 * @return
	 */
	public DCriteriaPageSupport<Account> getAll(){
		DetachedCriteria dc = DetachedCriteria.forClass(Account.class);
		return this.dao.findPageByCriteria(dc);
	}
	
	/**
	 * 根据身份证模糊查询
	 * @param recommender_id
	 * @return
	 */
	public Account getAccountByIdcard_noLike(String idcard_no){
		DetachedCriteria dc = DetachedCriteria.forClass(Account.class);
		dc.add(Restrictions.ilike("idcard_no", idcard_no, MatchMode.ANYWHERE));
		List list = this.dao.findAllByCriteria(dc);
		return list==null||list.size()<=0?null:(Account)list.get(0);
	}
	public ServiceService getServiceService() {
		return serviceService;
	}
	public void setServiceService(ServiceService serviceService) {
		this.serviceService = serviceService;
	}
	
}
