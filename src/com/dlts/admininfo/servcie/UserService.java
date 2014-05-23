package com.dlts.admininfo.servcie;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

import com.dlts.admininfo.domain.AdminInfo;
import com.dlts.adminrole.domain.AdminRole;
import com.dlts.base.service.BaseService;
import com.dlts.role.domain.Role;
import com.dlts.util.MD5Util;
import com.dlts.util.dao.DCriteriaPageSupport;
import com.dlts.util.string.ConstantString;
import com.dlts.util.string.ValidateObject;

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
			String id = adminInfo.getId();
			result = (AdminInfo) this.dao.getIObjectByPK(AdminInfo.class,id);
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
//	public DCriteriaPageSupport<AdminInfo> list(int pageNo, int pageSize) {
//		String hql = "select ar.id,ar.usid,ar.rid,ai.id,ai.admin_code,ai.password,ai.name,"
//				+ "ai.telephone,ai.email,ai.enrolldate,r.id,r.role_name from AdminInfo as ai,AdminRole as ar,Role as r where ar.rid=r.id and ar.usid=ai.id order by ai.enrolldate desc";
//		DCriteriaPageSupport list = this.dao.findPageByHql(hql, pageSize,pageNo);
//		List<AdminInfo> aList = new ArrayList<AdminInfo>();
//		Map<String, AdminInfo> aMap = new HashMap<String, AdminInfo>(); // key为用户id，value为该用户
//		Map<String, List<Role>> rMap = new HashMap<String, List<Role>>(); // key为用户id,value为该用户所拥有的角色
//		if (list != null && list.size() > 0) {
//			int size = list.size();
//			for (int i = 0; i < size; i++) {
//				Object[] object = (Object[]) list.get(i);
//				String key = (String) object[3];
//				List<Role> rlist = rMap.get(key) == null ? new ArrayList<Role>()
//						: rMap.get(key);
//				Role role = new Role();
//				role.setId((String) object[10]);
//				role.setRole_name((String) object[11]);
//				rlist.add(role);
//				rMap.put(key, rlist);
//				AdminInfo ai = aMap.get(key);
//				if (ai == null) {
//					ai = new AdminInfo();
//					ai.setId((String) object[3]);
//					ai.setAdmin_code((String) object[4]);
//					ai.setPassword((String) object[5]);
//					ai.setName((String) object[6]);
//					ai.setTelephone((String) object[7]);
//					ai.setEmail((String) object[8]);
//					ai.setEnrolldate((Date) object[9]);
//				}
//				ai.setRoleList(rlist);
//				aMap.put(key, ai);
//			}
//		}
//		for (Entry<String, AdminInfo> entry : aMap.entrySet()) {
//			aList.add(entry.getValue());
//		}
//		DCriteriaPageSupport<AdminInfo> result = new DCriteriaPageSupport<AdminInfo>(aList, list.getTotalCount());
//		Collections.sort(result);
//		return result;
//	}
	

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
	 * 分页查询用户表
	 * @param pageSize
	 * @param pageNo
	 * @return
	 */
	public DCriteriaPageSupport<AdminInfo> list( int pageNo,int pageSize) {
		DetachedCriteria dc = DetachedCriteria.forClass(AdminInfo.class);
		dc.addOrder(Order.desc("enrolldate"));
		DCriteriaPageSupport list = this.dao.findPageByCriteria(dc, pageSize, pageNo);
		List arList = findAdminRoleList();
		int listSize = list!=null&&!"".equals(list) ? list.size():0;
		int arListSize = arList!=null&&!"".equals(arList) ? arList.size() : 0;
		for (int i = 0; i < listSize; i++) {
			AdminInfo ai = (AdminInfo) list.get(i);
			List<Role> rList = ai.getRoleList() ==null ? new ArrayList<Role>() : ai.getRoleList();
			for(int j=0; j<arListSize; j++){
				Object[] o = (Object[]) arList.get(j);
				if(ai.getId().equals(o[1])){
					Role r = new Role();
					r.setId((String) o[2]);
					r.setRole_name((String) o[4]);
					rList.add(r);
				}
			}
			ai.setRoleList(rList);
		}
		Collections.sort(list);
		return list;
	}

	/**
	 * 获取用户角色与角色表的联合查询数据
	 * 
	 * @return
	 */
	public List findAdminRoleList() {
		String hql = "select ar.id,ar.usid,ar.rid,r.id,r.role_name from AdminRole as ar,Role as r where ar.rid=r.id";
		return this.dao.findAllyHql(hql, new Object[] {});
	}	
	/**
	 * 更新数据
	 * 
	 * @param adminInfo
	 */
	public boolean updateAdminInfo(String[] rid,AdminInfo adminInfo) {
		boolean result = false;
		if(adminInfo!=null){
			this.dao.updateIObject(adminInfo);
			updateAdminRole(rid,adminInfo.getId());
			result = true;
		}
		return result;
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
	/**
	 * 根据usid删除数据
	 * @param usid
	 */
	public void deleteAdminRole(String usid){
		String hql = "delete from AdminRole where usid=?";
		this.dao.execByHQL(hql, new Object[]{usid});
	}
	/**
	 * 添加数据
	 * 
	 * @param adminInfo
	 */
	public boolean addAdminInfo(AdminInfo adminInfo,String[] rid) {
		boolean result = false;
		if(adminInfo!=null){
			adminInfo.setPassword(MD5Util.MD5(adminInfo.getPassword()));
			adminInfo.setEnrolldate(new Date());
			this.dao.saveIObject(adminInfo);
			adminInfo = findAdminInfoByAdmin_code(adminInfo.getAdmin_code());
			addAdminRole(rid, adminInfo.getId());
			result =true;
		}
		return result;
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
	public boolean deleteAdminInfo(AdminInfo adminInfo){
		boolean result = false;
		if(adminInfo!=null){
			this.dao.deleteIObject(adminInfo);
			result = true;
		}
		return result;
	}
	/**
	 * 检测管理员账号是否重名
	 * @param admin_code
	 * @return
	 */
	public String checkAdminCode(String admin_code){
		String result = null;
		String hql = "from AdminInfo where admin_code=?";
		List<AdminInfo> list = this.dao.findAllyHql(hql, new Object[]{admin_code});
		if(list!=null&&list.size()>0){
			result = ADMIN_CODE_FALSE;
		}
		return result;
	}
	/**
	 * 查询
	 * @param pageNo
	 * @param pageSize
	 * @param selRole
	 * @param searchAdmin_code
	 * @return
	 */
	public DCriteriaPageSupport<AdminInfo> search( int pageNo,int pageSize,String searchAdmin_code){
		DetachedCriteria dc = DetachedCriteria.forClass(AdminInfo.class);
		dc.addOrder(Order.desc("enrolldate"));
		if(searchAdmin_code!=null&&!"".equals(searchAdmin_code)){
			dc.add(Restrictions.like("admin_code", searchAdmin_code, MatchMode.ANYWHERE));
		}
		DCriteriaPageSupport list = this.dao.findPageByCriteria(dc, pageSize, pageNo);
		List arList = findAdminRoleList();
		int listSize = list!=null&&!"".equals(list) ? list.size():0;
		int arListSize = arList!=null&&!"".equals(arList) ? arList.size() : 0;
		for (int i = 0; i < listSize; i++) {
			AdminInfo ai = (AdminInfo) list.get(i);
			List<Role> rList = ai.getRoleList() ==null ? new ArrayList<Role>() : ai.getRoleList();
			for(int j=0; j<arListSize; j++){
				Object[] o = (Object[]) arList.get(j);
				if(ai.getId().equals(o[1])){
					Role r = new Role();
					r.setId((String) o[2]);
					r.setRole_name((String) o[4]);
					rList.add(r);
				}
			}
			ai.setRoleList(rList);
		}
		Collections.sort(list);
		return list;
	}
	/**
	 * 修改密码
	 * @param adminInfo
	 * @return
	 */
	public boolean updatePwd(AdminInfo adminInfo,String oldPwd ){
		boolean result = false;
		if(adminInfo!=null){
			AdminInfo ai = findAdminInfoById(adminInfo);
			if(ai.getPassword().equals(MD5Util.MD5(oldPwd))){
				adminInfo.setPassword(MD5Util.MD5(adminInfo.getPassword()));
				String hql = "update AdminInfo set password=? where id=?";
				this.dao.execByHQL(hql, new Object[]{adminInfo.getPassword(),adminInfo.getId()});
				result = true;
			}
		}
		return result;
	}
	
	/**
	 * 获取所有的用户
	 * @return
	 */
	public List<AdminInfo> getAll() {
		DetachedCriteria dc = DetachedCriteria.forClass(AdminInfo.class);
		return this.getDao().findAllByCriteria(dc);
	}
	
	/**
	 * 根据用户id查找所以用户角色
	 * 
	 * @param userid
	 * @return
	 */
	public List<AdminRole> getRoleByUserId(String usid) {
		DetachedCriteria dc = DetachedCriteria.forClass(AdminRole.class);
		if (ValidateObject.hasValue(usid)) {
			dc.add(Restrictions.eq("usid", usid));
		}
		return this.getDao().findAllByCriteria(dc);
	}
}
