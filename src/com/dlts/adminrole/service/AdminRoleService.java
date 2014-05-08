package com.dlts.adminrole.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.hibernate.criterion.DetachedCriteria;

import com.dlts.admininfo.domain.AdminInfo;
import com.dlts.adminrole.domain.AdminRole;
import com.dlts.base.service.BaseService;
import com.dlts.role.domain.Role;
import com.dlts.util.dao.DCriteriaPageSupport;

public class AdminRoleService extends BaseService {
	/**
	 * 根据usid删除数据
	 * @param usid
	 */
	public void deleteAdminRole(String usid){
		String hql = "delete from AdminRole where usid=?";
		this.dao.execByHQL(hql, new Object[]{usid});
	}
	
	/**
	 * 批量添加数据
	 * @param rid
	 * @param usid
	 */
	public void addAdminRole(String[] rids, String usid) {
		if (rids != null && rids.length > 0) {
			List<AdminRole> list = new ArrayList<AdminRole>();
			for(String rid : rids){
				AdminRole ar = new AdminRole();
				ar.setRid(rid);
				ar.setUsid(usid);
				list.add(ar);
			}
			for(AdminRole r : list){
				this.dao.saveIObject(r);
			}
		}
	}
	/**
	 * 修改数据
	 * @param rids
	 * @param usid
	 */
	public void updateAdminRole(String[] rids,String usid){
		deleteAdminRole(usid);
		addAdminRole(rids, usid);
	}
}
