package com.dlts.role.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import com.dlts.function.domain.Function;
import com.dlts.role.domain.Role;
import com.dlts.role.service.RoleService;
import com.dlts.util.ContextUtil;
import com.dlts.util.InitData;
import com.dlts.util.SpringUtil;
import com.dlts.util.dao.DCriteriaPageSupport;
import com.dlts.util.string.ConstantString;
import com.dlts.web.action.ActionResult;
import com.dlts.web.action.BaseAction;

public class RoleActioin extends BaseAction{
	private RoleService roleService = (RoleService) SpringUtil.getWebApplicationContext().getBean("roleService");
	/**
	 * 列表数据
	 */
	private DCriteriaPageSupport<Role> roleList ;
	private List<Function> functionList;
	private Role role;
	/**
	 * 显示数据列表
	 * @return
	 */
	public String listData(){
		roleList = roleService.list(pageNum,numPerPage);
		total = roleList.getTotalCount();
		countPageCount();
		return ConstantString.SUCCESS;
	}
	/**
	 * 点击某一页时显示的数据列表
	 * @return
	 */
	public String list(){
		roleList = roleService.list(pageNum,numPerPage);
		total = roleList.getTotalCount();
		countPageCount();
		return ConstantString.SUCCESS;
	}
	/**
	 * 跳转到添加界面
	 * @return
	 */
	public String add(){
		Map<String,Function> funMap = InitData.getFunctionIdMap();
		for(Entry<String, Function> entry : funMap.entrySet()){
			functionList.add(entry.getValue());
		}
		return ConstantString.SUCCESS;
	}
	/**
	 * 检测角色名字是否重复
	 * @return
	 */
	public void checkRole_name(){
		response.setContentType("text/html;charset=utf-8");
		String result = roleService.checkRole_name(role.getRole_name(), role.getId());
		try {
			ActionResult actionResult = new ActionResult(ConstantString.SUCCESSCODE,"不重复");
			if(result!=null){
				actionResult = new ActionResult(ConstantString.FAILURECODE,"角色名重复");
			}
			PrintWriter out = response.getWriter();
			out.print(ContextUtil.resultToJson(actionResult));
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public DCriteriaPageSupport<Role> getRoleList() {
		return roleList;
	}
	public void setRoleList(DCriteriaPageSupport<Role> roleList) {
		this.roleList = roleList;
	}
	public Role getRole() {
		return role;
	}
	public void setRole(Role role) {
		this.role = role;
	}
	public List<Function> getFunctionList() {
		return functionList;
	}
	public void setFunctionList(List<Function> functionList) {
		this.functionList = functionList;
	}
	
}
