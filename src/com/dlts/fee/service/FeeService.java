package com.dlts.fee.service;

import org.hibernate.criterion.DetachedCriteria;

import com.dlts.base.service.BaseService;
import com.dlts.fee.domain.Fee;
import com.dlts.util.dao.DCriteriaPageSupport;

public class FeeService extends BaseService{
	public DCriteriaPageSupport<Fee> list(int pageNo,int pageSize){
		DetachedCriteria dc = DetachedCriteria.forClass(Fee.class);
		return this.dao.findPageByCriteria(dc, pageSize, pageNo);
	}
}
