package com.dlts.role.service;

import com.dlts.base.service.BaseService;
import com.dlts.role.domain.Role;
import com.dlts.util.dao.DCriteriaPageSupport;

public class RoleService extends BaseService {
	public DCriteriaPageSupport<Role> list(int pageNo,int pageSize){
		String hql = "from Role";
		return this.dao.findPageByHql(hql, pageSize, pageNo);
	}
}
