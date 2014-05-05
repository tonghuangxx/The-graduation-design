package com.dlts.util;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.config.DefaultSettings;

import com.dlts.util.string.ValidateObject;
import com.dlts.web.action.ActionResult;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.ActionProxy;

/**
 * 和平台相关操作的帮助类
 * 
 * @author CWB
 */
public class ContextUtil {
	/**
	 * namespace分隔符
	 */
	private static final String SEPERATOR = "/";
	/**
	 * web应用名称
	 */
	private static String contextPath = "";

	private static String realPath = null;

	/**
	 * 设置web应用名称
	 * 
	 * @param contextPath
	 *            contextPath
	 */
	public static void setContextPath(String contextPath) {
		ContextUtil.contextPath = contextPath;
	}

	/**
	 * 获取web应用名称
	 * 
	 * @return web应用名称
	 */
	public static String getContextPath() {
		return contextPath;
	}

	/**
	 * 将action的结果转为json字符串
	 * 
	 * @param result
	 *            结果
	 * @return 字符串
	 */
	public static String resultToJson(ActionResult result) {
		return "{\"statusCode\":\"" + result.getStatusCode() + "\", \"message\":\"" + result.getMessage() + "\"}";
	}

	/**
	 * 获得action code
	 * 
	 * @param ai
	 *            ai
	 * @return code
	 */
	public static String getStruts2ActionCode(ActionInvocation ai) {
		StringBuilder actionString = new StringBuilder();
		ActionProxy proxy = ai.getProxy();
		String namespace = proxy.getNamespace();
		actionString.append(namespace);
		if (ValidateObject.hasValue(namespace) && !SEPERATOR.equals(namespace)) {
			actionString.append(SEPERATOR);
		}
		actionString.append(proxy.getActionName()).append(".").append(new DefaultSettings().get("struts.action.extension"));
		return actionString.toString();
	}

	/**
	 * 当前用户是否可以访问functionCode
	 * 
	 * @param functionCode
	 *            functionCode
	 * @return boolean
	 */
//	public static boolean hasFunctionForUser(String functionCode) {
//		Object obj = ServletActionContext.getContext().getSession().get("userFunctionSet");
//		if (obj == null) {
//			return false;
//		}
//		Set<String> userFunctionSet = (Set<String>) obj;
//		return InitData.authFunction(functionCode) ? (InitData.isForbbidden(functionCode) ? false : userFunctionSet.contains(functionCode)) : true;
//	}

	/**
	 * 获得当前session
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static Map getContextMap() {
		Map map = ServletActionContext.getContext().getSession();
		Map newMap = new HashMap(map.size());
		Iterator it = map.keySet().iterator();
		while (it.hasNext()) {
			Object key = it.next();
			newMap.put(key, map.get(key));
		}
		return newMap;
	}

	/**
	 * 将图片路径改成小图路径
	 * 
	 * @param path
	 * @return
	 */
	public static String changeImgPathToSmall(String path) {
		if (ValidateObject.hasValue(path) && path.indexOf(".") != -1) {
			int index = path.indexOf(".");
			return path.substring(0, index) + "_thumb" + path.substring(index).toLowerCase();
		}
		return path;
	}

	public static String getRealPath() {
		return realPath;
	}

	public static void setRealPath(String realPath) {
		if (ContextUtil.realPath == null) {
			ContextUtil.realPath = realPath;
		}
	}
}
