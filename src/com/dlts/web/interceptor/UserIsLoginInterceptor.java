package com.dlts.web.interceptor;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.xml.registry.infomodel.User;

import org.apache.struts2.ServletActionContext;

import com.dlts.util.string.ConstantString;
import com.dlts.web.action.BaseAction;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

/**
 * 用户是否登录拦截器
 * 
 * @author CWB
 */
public class UserIsLoginInterceptor extends AbstractInterceptor {
	/**
	 * 
	 */
	private static final long serialVersionUID = 89548185695541648L;

	/**
	 * 拦截Action处理的拦截方法
	 */
	public String intercept(ActionInvocation invocation) throws Exception {
		// 取得请求相关的actionContext实例
		if (invocation.getInvocationContext().getSession().get(ConstantString.USER) == null) {
			return Action.LOGIN;
		} else {
			return invocation.invoke();
		}
	}
}
