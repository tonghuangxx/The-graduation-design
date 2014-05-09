package com.dlts.admininfo.servcie;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.hibernate.criterion.DetachedCriteria;

import com.dlts.admininfo.domain.AdminInfo;
import com.dlts.base.service.BaseService;
import com.dlts.role.domain.Role;
import com.dlts.util.MD5Util;
import com.dlts.util.dao.DCriteriaPageSupport;

public class UserService extends BaseService {
	private static String ADMIN_CODE_FALSE="管理员账号重复";
	
	/**
	 * 根据id查询用户信息
	 * 
	 * @param adminInfo
	 * @return
	 */
	public AdminInfo findAdminInfoById(AdminInfo adminInfo) {
		AdminInfo result = null;
		if (adminInfo != null) {
			result = (AdminInfo) this.dao.getIObjectByPK(AdminInfo.class,
					adminInfo.getId());
		}
		return result;
	}

	/**
	 * 分页查询用户信息及他所拥有的角色
	 * 
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	public DCriteriaPageSupport<AdminInfo> list(int pageNo, int pageSize) {
		String hql = "select ar.id,ar.usid,ar.rid,ai.id,ai.admin_code,ai.password,ai.name,"
				+ "ai.telephone,ai.email,ai.enrolldate,r.id,r.role_name from AdminInfo as ai,AdminRole as ar,Role as r where ar.rid=r.id and ar.usid=ai.id order by ai.enrolldate desc";
		DCriteriaPageSupport list = this.dao.findPageByHql(hql, pageSize,pageNo);
		List<AdminInfo> aList = new ArrayList<AdminInfo>();
		Map<String, AdminInfo> aMap = new HashMap<String, AdminInfo>(); // key为用户id，value为该用户
		Map<String, List<Role>> rMap = new HashMap<String, List<Role>>(); // key为用户id,value为该用户所拥有的角色
		if (list != null && list.size() > 0) {
			int size = list.size();
			for (int i = 0; i < size; i++) {
				Object[] object = (Object[]) list.get(i);
				String key = (String) object[3];
				List<Role> rlist = rMap.get(key) == null ? new ArrayList<Role>()
						: rMap.get(key);
				Role role = new Role();
				role.setId((String) object[10]);
				role.setRole_name((String) object[11]);
				rlist.add(role);
				rMap.put(key, rlist);
				AdminInfo ai = aMap.get(key);
				if (ai == null) {
					ai = new AdminInfo();
					ai.setId((String) object[3]);
					ai.setAdmin_code((String) object[4]);
					ai.setPassword((String) object[5]);
					ai.setName((String) object[6]);
					ai.setTelephone((String) object[7]);
					ai.setEmail((String) object[8]);
					ai.setEnrolldate((Date) object[9]);
				}
				ai.setRoleList(rlist);
				aMap.put(key, ai);
			}
		}
		for (Entry<String, AdminInfo> entry : aMap.entrySet()) {
			aList.add(entry.getValue());
		}
		DCriteriaPageSupport<AdminInfo> result = new DCriteriaPageSupport<AdminInfo>(aList, list.getTotalCount());
		Collections.sort(result);
		return result;
	}

	/**
	 * 根据id获得AdminInfo
	 * 
	 * @param id
	 * @return
	 */
	public AdminInfo getAdminInfoById(String id) {
		String hql = "select ar.id,ar.usid,ar.rid,ai.id,ai.admin_code,ai.password,ai.name,"
				+ "ai.telephone,ai.email,ai.enrolldate,r.id,r.role_name from AdminInfo as ai,AdminRole as ar,Role as r where ar.rid=r.id and ar.usid=ai.id and ai.id=?";
		List list = (List) this.dao.findAllyHql(hql, new Object[] { id });
		List<AdminInfo> aList = new ArrayList<AdminInfo>();
		Map<String, AdminInfo> aMap = new HashMap<String, AdminInfo>(); // key为用户id，value为该用户
		Map<String, List<Role>> rMap = new HashMap<String, List<Role>>(); // key为用户id,value为该用户所拥有的角色
		if (list != null && list.size() > 0) {
			int size = list.size();
			for (int i = 0; i < size; i++) {
				Object[] object = (Object[]) list.get(i);
				String key = (String) object[3];
				List<Role> rlist = rMap.get(key) == null ? new ArrayList<Role>()
						: rMap.get(key);
				Role role = new Role();
				role.setId((String) object[10]);
				role.setRole_name((String) object[11]);
				rlist.add(role);
				rMap.put(key, rlist);
				AdminInfo ai = aMap.get(key);
				if (ai == null) {
					ai = new AdminInfo();
					ai.setId((String) object[3]);
					ai.setAdmin_code((String) object[4]);
					ai.setPassword((String) object[5]);
					ai.setName((String) object[6]);
					ai.setTelephone((String) object[7]);
					ai.setEmail((String) object[8]);
					ai.setEnrolldate((Date) object[9]);
				}
				ai.setRoleList(rlist);
				aMap.put(key, ai);
			}
		}
		for (Entry<String, AdminInfo> entry : aMap.entrySet()) {
			aList.add(entry.getValue());
		}
		return aList.get(0);
	}

	/**
	 * 更新数据
	 * 
	 * @param adminInfo
	 */
	public void updateAdminInfo(AdminInfo adminInfo) {
		this.dao.updateIObject(adminInfo);
	}

	/**
	 * 添加数据
	 * 
	 * @param adminInfo
	 */
	public void addAdminInfo(AdminInfo adminInfo) {
		adminInfo.setPassword(MD5Util.MD5(adminInfo.getPassword()));
		adminInfo.setEnrolldate(new Date());
		this.dao.saveIObject(adminInfo);
	}

	/**
	 * 获取数据
	 * 
	 * @param id
	 * @return
	 */
	public AdminInfo findAdminInfoByAdmin_code(String admin_code) {
		String hql = "from AdminInfo where admin_code=?";
		List<AdminInfo> list = this.dao.findAllyHql(hql,
				new Object[] { admin_code });
		return list != null && list.size() > 0 ? list.get(0) : null;
	}
	/**
	 * 删除数据
	 * @param adminInfo
	 */
	public void deleteAdminInfo(AdminInfo adminInfo){
		this.dao.deleteIObject(adminInfo);
	}
	
	public String checkAdminCode(String admin_code){
		String result = null;
		String hql = "from AdminInfo where admin_code=?";
		List<AdminInfo> list = this.dao.findAllyHql(hql, new Object[]{admin_code});
		if(list!=null&&list.size()>0){
			result = ADMIN_CODE_FALSE;
		}
		return result;
	}
}
