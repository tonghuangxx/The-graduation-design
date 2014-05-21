package com.dlts.host.service;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;

import com.dlts.base.service.BaseService;
import com.dlts.host.domain.Host;
import com.dlts.util.dao.DCriteriaPageSupport;

public class HostService extends BaseService{
	/**
	 * 获取所有服务器信息
	 * @return
	 */
	public DCriteriaPageSupport<Host> getAllHost(){
		DetachedCriteria dc = DetachedCriteria.forClass(Host.class);
		return this.dao.findPageByCriteria(dc);
	}
	
	/**
	 * 根据id获取服务器信息
	 * @param id
	 * @return
	 */
	public Host getHostById(String id){
		return (Host) this.dao.getIObjectByPK(Host.class, id);
	}
	
	/**
	 * 根据服务器地址获取服务器信息
	 * @param host_ip
	 * @return
	 */
	public Host getHostByHost_ip(String host_ip){
		String hql = "from Host where host_ip=?";
		List list = this.dao.findAllyHql(hql, new Object[]{host_ip});
		return list==null||list.size()<=0?null:(Host)list.get(0);
	}
}
