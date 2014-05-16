package com.dlts.module.service;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;

import com.dlts.base.service.BaseService;
import com.dlts.module.domain.Module;

public class ModuleService extends BaseService{
	/**
	 * 获得所有的模块
	 * 
	 * @return
	 */
	public List<Module> getAllMenu() {
		return this.getDao().findAllByCriteria(DetachedCriteria.forClass(Module.class).addOrder(Order.asc("displayno")));
	}
}
