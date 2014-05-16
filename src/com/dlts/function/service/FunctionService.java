package com.dlts.function.service;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;

import com.dlts.base.service.BaseService;
import com.dlts.function.domain.Function;

public class FunctionService extends BaseService{
	/**
	 * 查询资源
	 * 
	 * @return 查询结果
	 */
	public List<Function> list() {
		DetachedCriteria dc = DetachedCriteria.forClass(Function.class);
		return this.getDao().findAllByCriteria(dc);
	}
}
