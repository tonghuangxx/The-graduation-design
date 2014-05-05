package com.dlts.login.service;

import java.util.List;

import com.dlts.admininfo.domain.AdminInfo;
import com.dlts.base.service.BaseService;
import com.dlts.util.MD5Util;

/**
 * 用户登录service
 * @author CWB
 *
 */
public class LoginService extends BaseService{
	/**
	 * 根据用户名查找
	 * @param adminInfo
	 * @return
	 */
	public AdminInfo findByCode(AdminInfo adminInfo){
		adminInfo.setPassword(MD5Util.MD5(adminInfo.getPassword()));
		AdminInfo result = null;
		String hql = "from AdminInfo where admin_code = ?";
		if(adminInfo != null){
			List<AdminInfo> list = this.dao.findAllyHql(hql, new Object[]{adminInfo.getAdmin_code()});
			 result = list == null||list.size() <= 0 ? null :list.get(0);
		}
		return result;
	}
	
	/**
	 * 根据用户名密码查询
	 * @param adminInfo
	 * @return
	 */
	public AdminInfo findByCodeAndPwd(AdminInfo adminInfo){
		adminInfo.setPassword(MD5Util.MD5(adminInfo.getPassword()));
		AdminInfo result = null;
		String hql = "from AdminInfo where admin_code = ? and password = ?";
		if(adminInfo!=null){
			List<AdminInfo> list = this.dao.findAllyHql(hql, new Object[]{adminInfo.getAdmin_code(),adminInfo.getPassword()});
			result = list == null||list.size()<=0 ? null : list.get(0);
		}
		return result;
	}
}
