package com.dlts.fee.service;

import java.util.Date;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;

import com.dlts.base.service.BaseService;
import com.dlts.fee.domain.Fee;
import com.dlts.util.dao.DCriteriaPageSupport;

public class FeeService extends BaseService{
	/**
	 * 分页查询
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	public DCriteriaPageSupport<Fee> list(int pageNo,int pageSize){
		DetachedCriteria dc = DetachedCriteria.forClass(Fee.class);
		dc.addOrder(Order.desc("creatime"));
		return this.dao.findPageByCriteria(dc, pageSize, pageNo);
	}
	/**
	 * 保存Fee
	 * @param fee
	 * @return
	 */
	public boolean saveFee(Fee fee){
		boolean result = false;
		if(fee!=null){
			fee.setCreatime(new Date());
			fee.setStatus('1');
			this.dao.saveIObject(fee);
			result = true;
		}
		return result;
	}
	/**
	 * 根据id获取Fee
	 * @param id
	 * @return
	 */
	public Fee getFeeById(String id){
		return (Fee) this.dao.getIObjectByPK(Fee.class, id);
	}
	/**
	 * 更新Fee
	 * @param fee
	 * @return
	 */
	public boolean updateFee(Fee fee){
		boolean result = false;
		if(fee!=null){
			this.dao.updateIObject(fee);
			result = true;
		}
		return result;
	}
	/**
	 * 删除一个资费
	 * @param id
	 * @return
	 */
	public boolean deleteFee(String id){
		boolean result = false;
		if(id!=null&&!"".equals(id)){
			String hql = "update Fee set status=? where id=?";
			this.dao.execByHQL(hql, new Object[]{'2',id});
		}
		return result;
	}
}
