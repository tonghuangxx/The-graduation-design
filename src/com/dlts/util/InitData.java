package com.dlts.util;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.dlts.admininfo.domain.AdminInfo;
import com.dlts.admininfo.servcie.UserService;
import com.dlts.function.domain.Function;
import com.dlts.function.service.FunctionService;
import com.dlts.module.domain.Module;
import com.dlts.module.service.ModuleService;
import com.dlts.role.domain.Role;
import com.dlts.role.service.RoleService;
import com.dlts.rolefunction.domain.RoleFunction;
import com.dlts.util.string.ValidateObject;

/**
 * 系统启动时加载到内存的初始化数据
 * 
 * @author CWB
 */
public class InitData {

	/**
	 * 功能service
	 */
	private static FunctionService functionService = (FunctionService) SpringUtil.getWebApplicationContext().getBean("functionService");

	/**
	 * 菜单的service
	 */
	private static ModuleService moduleService = (ModuleService) SpringUtil.getWebApplicationContext().getBean("moduleService");

	/**
	 * 角色service
	 */
	private static RoleService roleService = (RoleService) SpringUtil.getWebApplicationContext().getBean("roleService");

	/**
	 * 用户service
	 */
	private static UserService userService = (UserService) SpringUtil.getWebApplicationContext().getBean("userService");
	/**
	 * 所有功能，key是功能路径，value是功能对象
	 */
	private static Map<String, Function> functionMap = java.util.Collections.synchronizedMap(new HashMap<String, Function>()); // 所有资源，key是资源路径，value是资源对象


	/**
	 * 所有角色，key是功能id，value是功能对象
	 */
	private static Map<String, Function> functionIdMap = Collections.synchronizedMap(new HashMap<String, Function>()); // 所有资源，key是资源id，value是资源对象
	/**
	 * 所有角色key是角色id，value是角色对象
	 */
	private static Map<String, Role> roleMap = Collections.synchronizedMap(new HashMap<String, Role>()); // 所有角色key是角色id，value是角色对象

	/**
	 * 所有用户key是角色id，value是用户账号
	 */
	private static Map<String, String> userMap = Collections.synchronizedMap(new HashMap<String, String>()); // 所有角色key是用户id，value是用户对象

	/**
	 * 所有模块，键是菜单的父节点的代码，值是父节点下的所有子节点
	 */
	private static Map<String, List<Module>> menuMap = Collections.synchronizedMap(new HashMap<String, List<Module>>()); // 所有菜单，键是菜单的父节点的代码，值是父节点下的所有子节点
	/**
	 * 所有模块，键是模块的id，值是模块对象
	 */
	private static Map<String, Module> menuFunCodeMap = Collections.synchronizedMap(new HashMap<String, Module>()); // 所有菜单，键是菜单的资源code，值是菜单对象
	/**
	 * 所有角色对应功能。key是角色id，value是该角色对应的所有功能
	 */
	private static Map<String, List<Function>> roleFunctionMap = Collections.synchronizedMap(new HashMap<String, List<Function>>()); // 所有角色对应资源。key是角色id，value是该角色对应的所有资源
	
	/**
	 * 重新加载功能
	 */
	public synchronized static void initFunctionList() {
		functionIdMap.clear();
		functionMap.clear();
		List<Function> functionList = functionService.list();
		for (Function function : functionList) {
			functionIdMap.put(function.getId(), function);
			if (ValidateObject.hasValue(function.getAction())) {
				functionMap.put(function.getAction(), function);
			}
		}
	}

	/**
	 * 根据action 找到功能主键
	 * 
	 * @param action
	 * @return
	 */
	public static Function getFunctionIdByAction(String action) {
		return functionMap.get(action) != null ? functionMap.get(action) : null;
	}

	/**
	 * 重新加载菜单
	 */
	public synchronized static void initMenuList() {
		List<Module> menuList = moduleService.getAllMenu();
		menuFunCodeMap.clear();
		for (Module menu : menuList) {
			menuFunCodeMap.put(menu.getId(), menu);
		}
		synchronized (menuMap) {
			menuMap.clear();
		}
	}



	/**
	 * 加载角色
	 */
	public synchronized static void initRoleList() {
		List<Role> roleList = roleService.getAllRole();
		roleMap.clear();
		roleFunctionMap.clear();
		for (Role role : roleList) {
			roleMap.put(role.getId(), role);
		}
		List<RoleFunction> roleFunctions = roleService.getAllRoleFunction();
		for (RoleFunction rf : roleFunctions) {
			String roleid = rf.getRoleId();
			String functionid = rf.getFunctionId();
			List<Function> funList = roleFunctionMap.get(roleid) != null ? roleFunctionMap.get(roleid) : new ArrayList<Function>();
			funList.add(functionIdMap.get(functionid));
			roleFunctionMap.put(roleid, funList);
		}
	}

	/**
	 * 加载用户
	 */
	public synchronized static void initUserList() {
		List<AdminInfo> userList = userService.getAll();
		userMap.clear();
		for (AdminInfo user : userList) {
			userMap.put(user.getId(), user.getAdmin_code());
		}
	}

	/**
	 * 在系统运行期间，如果是系统运行后新增用户，则先查找，再放入缓存。查找用户信息
	 * 
	 * @param index
	 */
//	public synchronized static void fetcherNewUserInfo(String index) {
//		RegisterUser registerUser = userService.getRegisterUserById(index);
//		if (registerUser != null) {
//			userMap.put(registerUser.getId(), registerUser.getUsername());
//		} else {
//			User user = userService.getUserById(index);
//			if (user != null) {
//				userMap.put(user.getId(), user.getUserName());
//			}
//		}
//	}

	/**
	 * 加载缓存List
	 */
	public static void webInit() {
		initFunctionList();
		initMenuList();
		initRoleList();
		initUserList();
	}

	/**
	 * 判断该code是否需要身份验证
	 * 
	 * @param code
	 * @return
	 */
	public static boolean authFunction(String code) {
		return functionMap.get(code) != null ? true : false;
	}


	// 用序列化与反序列化实现深克隆
	public static Object deepClone(Object src) {
		Object o = null;
		try {
			if (src != null) {
				ByteArrayOutputStream baos = new ByteArrayOutputStream();
				ObjectOutputStream oos = new ObjectOutputStream(baos);
				oos.writeObject(src);
				oos.close();
				ByteArrayInputStream bais = new ByteArrayInputStream(baos.toByteArray());
				ObjectInputStream ois = new ObjectInputStream(bais);
				o = ois.readObject();
				ois.close();
			}
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		return o;
	}

	public static Map<String, Function> getFunctionMap() {
		return functionMap;
	}

	public static void setFunctionMap(Map<String, Function> functionMap) {
		InitData.functionMap = functionMap;
	}

	public static Map<String, Function> getFunctionIdMap() {
		return functionIdMap;
	}

	public static void setFunctionIdMap(Map<String, Function> functionIdMap) {
		InitData.functionIdMap = functionIdMap;
	}

	public static Map<String, Role> getRoleMap() {
		return roleMap;
	}

	public static void setRoleMap(Map<String, Role> roleMap) {
		InitData.roleMap = roleMap;
	}

	public static Map<String, String> getUserMap() {
		return userMap;
	}

	public static void setUserMap(Map<String, String> userMap) {
		InitData.userMap = userMap;
	}

	public static Map<String, List<Module>> getMenuMap() {
		return menuMap;
	}

	public static void setMenuMap(Map<String, List<Module>> menuMap) {
		InitData.menuMap = menuMap;
	}

	public static Map<String, Module> getMenuFunCodeMap() {
		return menuFunCodeMap;
	}

	public static void setMenuFunCodeMap(Map<String, Module> menuFunCodeMap) {
		InitData.menuFunCodeMap = menuFunCodeMap;
	}

	public static Map<String, List<Function>> getRoleFunctionMap() {
		return roleFunctionMap;
	}

	public static void setRoleFunctionMap(Map<String, List<Function>> roleFunctionMap) {
		InitData.roleFunctionMap = roleFunctionMap;
	}


}
