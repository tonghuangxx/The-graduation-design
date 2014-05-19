package com.dlts.role.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
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

public class RoleAction extends BaseAction{
	private RoleService roleService = (RoleService) SpringUtil.getWebApplicationContext().getBean("roleService");
	/**
	 * 列表数据
	 */
	private DCriteriaPageSupport<Role> roleList ;
	private List<Function> functionList;
	private Role role;
	/**
	 * 存放修改页面的功能及哪些被选中
	 */
	private Map<Function,Integer> functionMap;
	/**
	 * 添加界面选中的功能
	 */
	private String[] fid;
	
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
		functionList = new ArrayList<Function>();
		for(Entry<String, Function> entry : funMap.entrySet()){
			functionList.add(entry.getValue());
		}
		return ConstantString.SUCCESS;
	}
	/**
	 * 添加操作
	 */
	public void addDo(){
		response.setContentType("text/html;charset=utf-8;");
		boolean result = roleService.saveRoleFunction(role, fid);
		ActionResult actionResult = new ActionResult(ConstantString.SUCCESSCODE, "添加成功");
		try {
			if(!result){
				actionResult = new ActionResult(ConstantString.FAILURECODE, "添加失败");
			}else{
				InitData.initFunctionList();
				InitData.initRoleList();
			}
			PrintWriter out = response.getWriter();
			out.print(ContextUtil.resultToJson(actionResult));
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	/**
	 * 删除角色
	 */
	public void delete(){
		response.setContentType("text/html;charset=utf-8;");
		role = roleService.getRoleById(role.getId());
		boolean result = roleService.deleteRole(role);
		try {
			ActionResult actionResult = new ActionResult(ConstantString.SUCCESSCODE, "删除成功");
			if(!result){
				actionResult = new ActionResult(ConstantString.FAILURECODE,"删除失败");
			}else{
				InitData.initFunctionList();
				InitData.initRoleList();
			}
			PrintWriter out = response.getWriter();
			out.print(ContextUtil.resultToJson(actionResult));
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	/**
	 * 跳转到修改界面
	 * @return
	 */
	public String edit(){
		role = roleService.getRoleById(role.getId());
		Map<String,Function> funMap = InitData.getFunctionIdMap();
		Map<String,List<Function>> roleFunctionMap = InitData.getRoleFunctionMap();
		List<Function> funList = roleFunctionMap.get(role.getId());//获取某个角色拥有的功能
		functionMap = new HashMap<Function, Integer>();
		//0代表该角色没有该功能，1代表有
		for(Entry<String, Function> entry : funMap.entrySet()){
			functionMap.put(entry.getValue(), 0);
		}
		for(Function fun : funList){
			functionMap.put(fun, 1);
		}
		return ConstantString.SUCCESS;
	}
	/**
	 * 修改操作
	 */
	public void editDo(){
		response.setContentType("text/html;charset=utf-8");
		boolean result = roleService.updateRole(role, fid);
		ActionResult actionResult = new ActionResult(ConstantString.SUCCESSCODE, "修改成功");
		try {
			if(!result){
				actionResult = new ActionResult(ConstantString.FAILURECODE,"修改失败");
			}else{
				InitData.initRoleList();
				InitData.initFunctionList();
			}
			PrintWriter out = response.getWriter();
			out.print(ContextUtil.resultToJson(actionResult));
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
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
	public String[] getFid() {
		return fid;
	}
	public void setFid(String[] fid) {
		this.fid = fid;
	}
	public Map<Function, Integer> getFunctionMap() {
		return functionMap;
	}
	public void setFunctionMap(Map<Function, Integer> functionMap) {
		this.functionMap = functionMap;
	}
	
}
