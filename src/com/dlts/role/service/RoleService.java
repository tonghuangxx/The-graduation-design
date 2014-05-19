package com.dlts.role.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.hibernate.criterion.DetachedCriteria;

import com.dlts.base.service.BaseService;
import com.dlts.function.domain.Function;
import com.dlts.role.domain.Role;
import com.dlts.rolefunction.domain.RoleFunction;
import com.dlts.util.dao.DCriteriaPageSupport;

public class RoleService extends BaseService {
	private static String ROLE_NAME_FAILE = "角色名重复";
	/**
	 * 分页获取角色
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	public DCriteriaPageSupport<Role> list(int pageNo,int pageSize){
		DetachedCriteria dc = DetachedCriteria.forClass(Role.class);
		DCriteriaPageSupport list = this.dao.findPageByCriteria(dc, pageSize, pageNo);
		List rfList = getRoleFunctionList();
		int listSize = list == null || "".equals(list) ? 0 : list.size();
		int rfListSize = rfList == null || "".equals(rfList) ? 0 : rfList.size();
		Function function = null;
		List<Function> funList = null;
		for(int i=0; i<listSize; i++){
			Role r = (Role) list.get(i);
			funList = r.getFunList()==null?new ArrayList<Function>():r.getFunList();
			for(int j = 0; j<rfListSize ;j++){
				Object[] o = (Object[]) rfList.get(j);
				if(r.getId().equals(o[7])){
					function = new Function();
					function.setId((String) o[0]);
					function.setCode((String) o[1]);
					function.setName((String) o[2]);
					function.setAction((String) o[3]);
					function.setParentId((String) o[4]);
					function.setModuleId((String) o[5]);
					funList.add(function);
				}
			}
			r.setFunList(funList);
		}
		return list;
	}
	/**
	 * 获取角色
	 * @return
	 */
	public List<Role> list(){
		String hql = "from Role";
		return this.dao.findAllyHql(hql, new Object[]{});
	}
	
	/**
	 * 查询所有角色
	 */
	public List<Role> getAllRole() {
		DetachedCriteria dc = DetachedCriteria.forClass(Role.class);
		return this.getDao().findAllByCriteria(dc);
	}
	/**
	 * 查询所有角色资源
	 * 
	 * @return
	 */
	public List<RoleFunction> getAllRoleFunction() {
		DetachedCriteria dc = DetachedCriteria.forClass(RoleFunction.class);
		return this.getDao().findAllByCriteria(dc);
	}
	/**
	 * 角色表和角色功能表联合查询
	 * @return
	 */
	public List getRoleFunctionList(){
		String hql = "select f.id,f.code,f.name,f.action,f.parentId,f.moduleId,rf.id,rf.roleId,rf.functionId from Function as f,RoleFunction as rf where f.id=rf.functionId";
		return this.dao.findAllyHql(hql, new Object[]{});
	}
	/**
	 * 添加角色以及它所拥有的功能
	 * @param role
	 * @param fid
	 * @return
	 */
	public boolean saveRoleFunction(Role role,String[] fid){
		boolean result = false;
		String flag = checkRole_name(role.getRole_name(), role.getId());
		if(flag==null){
			this.dao.saveIObject(role);
			Role r = getRoleByRole_name(role.getRole_name());
			RoleFunction roleFunction = null;
			for(String fd : fid){
				roleFunction = new RoleFunction();
				roleFunction.setRoleId(r.getId());
				roleFunction.setFunctionId(fd);
				this.dao.saveIObject(roleFunction);
			}
			result = true;
		}
		return result;
	}
	/**
	 * 检测角色名是否重复
	 * @param role_name
	 * @return
	 */
	public String checkRole_name(String role_name,String id){
		String result = null;
		StringBuffer hql = new StringBuffer( "from Role where 1=1");
		List<Object> list = new ArrayList<Object>();
		if(id!=null&&!"".equals(id)){
			hql.append(" and id<>?");
			list.add(id);
		}
		if(role_name!=null&&!"".equals(role_name)){
			hql.append(" and role_name=?");
			list.add(role_name);
		}
		List<Role> roleList = this.dao.findAllyHql(hql.toString(),list.toArray());
		if(roleList!=null&&!"".equals(roleList)&&roleList.size()>0){
			result = ROLE_NAME_FAILE;
		}
		return result;
	}
	/**
	 * 根据角色名字获取角色
	 * @param role_name
	 * @return
	 */
	public Role getRoleByRole_name(String role_name){
		String hql = "from Role where role_name = ?";
		List<Role> list =  this.dao.findAllyHql(hql, new Object[]{role_name});
		return list==null||"".equals(list)?null:list.get(0);
	}
	/**
	 * 删除数据
	 * @param role
	 * @return
	 */
	public boolean deleteRole(Role role){
		boolean result = false;
		if(role!=null){
			this.dao.deleteIObject(role);
			result = true;
		}
		return result;
	}
	/**
	 * 根据id获取数据
	 * @param id
	 * @return
	 */
	public Role getRoleById(String id){
		return (Role) this.dao.getIObjectByPK(Role.class, id);
	}
	/**
	 * 根据角色id删除数据
	 * @param roleId
	 * @return
	 */
	public boolean deleteRoleFunctionByRoleId(String roleId){
		boolean result = false;
		String hql = "delete from RoleFunction where roleId=?";
		if(roleId!=null&&!"".equals(roleId)){
			this.dao.execByHQL(hql, new Object[]{roleId});
			result = true;
		}
		return result;
	}
	/**
	 * 更新角色以及该角色对应的功能
	 * @param role
	 * @param fid
	 * @return
	 */
	public boolean updateRole(Role role,String[] fid){
		boolean result = false;
		if(fid!=null&&!"".equals(fid)){
			this.dao.updateIObject(role);
			result = updateRoleFunction(role,fid);
		}
		return result;
	}
	/**
	 * 更新角色功能表
	 * @param role
	 * @param fid
	 * @return
	 */
	public boolean updateRoleFunction(Role role,String[] fid){
		boolean result = false;
		result = deleteRoleFunctionByRoleId(role.getId());
		if(result){
			result = saveRoleFunction(role, fid);
		}
		return result;
	}
}
