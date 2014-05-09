package com.dlts.admininfo.action;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.dlts.admininfo.domain.AdminInfo;
import com.dlts.admininfo.servcie.UserService;
import com.dlts.adminrole.service.AdminRoleService;
import com.dlts.role.domain.Role;
import com.dlts.role.service.RoleService;
import com.dlts.util.SpringUtil;
import com.dlts.util.dao.DCriteriaPageSupport;
import com.dlts.util.string.ConstantString;
import com.dlts.web.action.BaseAction;
/**
 * 管理员action
 * @author CWB
 *
 */
public class UserAction extends BaseAction{
	private UserService userService = (UserService) SpringUtil.getWebApplicationContext().getBean("userService");
	private RoleService roleService = (RoleService) SpringUtil.getWebApplicationContext().getBean("roleService");
	private AdminRoleService adminRoleService = (AdminRoleService) SpringUtil.getWebApplicationContext().getBean("adminRoleService");
	/**
	 * 管理员表中数据
	 */
	private DCriteriaPageSupport<AdminInfo> dataList;
	/**
	 * 管理员数据
	 */
	private AdminInfo adminInfo;
	/**
	 * 角色表中数据
	 */
	private Map<Role,Integer> roleMap;
	/**
	 * 角色id
	 */
	private String[] rid;
	/**
	 * 角色表中数据
	 */
	private DCriteriaPageSupport<Role> rList;
	
	/**
	 * 分页显示用户及其所含角色信息
	 * @return
	 */
	public String list(){
		dataList = userService.list(pageNum, numPerPage);
		total = dataList.getTotalCount();
		getPageCount();
		return ConstantString.SUCCESS;
	}
	/**
	 * 跳转到修改界面
	 * @return
	 */
	public String edit(){
		adminInfo = userService.getAdminInfoById(adminInfo.getId());
		rList = roleService.list(pageNum, numPerPage);
		//0代表没有该角色，1代表有
		roleMap = new HashMap<Role, Integer>();
		for(Role r :rList){
			roleMap.put(r, 0);
		}
		if(adminInfo.getRoleList()!=null){
			for(Role rl:adminInfo.getRoleList()){
				roleMap.put(rl, 1);
			}
		}
		return ConstantString.SUCCESS;
	}
	/**
	 * 修改数据
	 * @return
	 */
	public String editDo(){
		userService.updateAdminInfo(adminInfo);
		adminRoleService.updateAdminRole(rid, adminInfo.getId());
		return ConstantString.SUCCESS;
	}
	/**
	 * 跳转到添加界面
	 * @return
	 */
	public String add(){
		rList = roleService.list(pageNum, numPerPage);
		return ConstantString.SUCCESS;
	}
	/**
	 * 添加数据
	 * @return
	 */
	public String addDo(){
		userService.addAdminInfo(adminInfo);
		adminInfo = userService.findAdminInfoByAdmin_code(adminInfo.getAdmin_code());
		adminRoleService.addAdminRole(rid, adminInfo.getId());
		return ConstantString.SUCCESS;
	}
	/**
	 * 删除数据
	 */
	public String delete(){
		adminInfo = userService.findAdminInfoById(adminInfo);
		userService.deleteAdminInfo(adminInfo);
		return ConstantString.SUCCESS;
	}
	
	public DCriteriaPageSupport<AdminInfo> getDataList() {
		return dataList;
	}
	public void setDataList(DCriteriaPageSupport<AdminInfo> dataList) {
		this.dataList = dataList;
	}
	public AdminInfo getAdminInfo() {
		return adminInfo;
	}
	public void setAdminInfo(AdminInfo adminInfo) {
		this.adminInfo = adminInfo;
	}
	public Map<Role, Integer> getRoleMap() {
		return roleMap;
	}
	public void setRoleMap(Map<Role, Integer> roleMap) {
		this.roleMap = roleMap;
	}
	public String[] getRid() {
		return rid;
	}
	public void setRid(String[] rid) {
		this.rid = rid;
	}
	public DCriteriaPageSupport<Role> getRList() {
		return rList;
	}
	public void setRList(DCriteriaPageSupport<Role> rList) {
		this.rList = rList;
	}
	
}
