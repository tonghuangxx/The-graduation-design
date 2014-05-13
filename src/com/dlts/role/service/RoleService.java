package com.dlts.role.service;

import java.util.List;

import com.dlts.base.service.BaseService;
import com.dlts.role.domain.Role;
import com.dlts.util.dao.DCriteriaPageSupport;

public class RoleService extends BaseService {
	/**
	 * 分页获取角色
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	public DCriteriaPageSupport<Role> list(int pageNo,int pageSize){
		String hql = "from Role";
		return this.dao.findPageByHql(hql, pageSize, pageNo);
	}
	/**
	 * 获取角色
	 * @return
	 */
	public List<Role> list(){
		String hql = "from Role";
		return this.dao.findAllyHql(hql, new Object[]{});
	}
}
