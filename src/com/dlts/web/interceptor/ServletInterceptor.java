package com.dlts.web.interceptor;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.config.DefaultSettings;

import com.dlts.web.action.ServletHandler;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.ActionProxy;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

/**
 * 注入http对象的拦截器
 * 
 * @author CWB
 */
@SuppressWarnings("serial")
public class ServletInterceptor extends AbstractInterceptor {


	@Override
	public String intercept(ActionInvocation ai) throws Exception {
		Object o = ai.getAction();
		if (o instanceof ServletHandler) {
			HttpServletRequest request = ServletActionContext.getRequest();
			((ServletHandler) o).setServletRequest(request);
			((ServletHandler) o).setServletResponse(ServletActionContext.getResponse());
		}
		String ret = ai.invoke();
		try{
			boolean switchCase = true;
			if (switchCase) {
				StringBuilder actionString = new StringBuilder();
				ActionProxy proxy = ai.getProxy();
				String namespace = proxy.getNamespace();
				actionString.append(namespace);
				if (namespace != null && namespace.trim().length() > 0 && !"/".equals(namespace)) {
					actionString.append("/");
				}
//				actionString.append(proxy.getActionName()).append(".").append(new DefaultSettings().get("struts.action.extension"));
				actionString.append(proxy.getActionName());
				System.out.println("\n");
				System.out.println("action:    " + actionString.toString());
				System.out.println("class :    " + proxy.getConfig().getClassName());
				System.out.println("method:    " + proxy.getConfig().getMethodName());
				com.opensymphony.xwork2.config.entities.ResultConfig config = proxy.getConfig().getResults() != null ? proxy.getConfig().getResults().get(ret == null ? "" : ret) : null;
				System.out.println("result   : " + (config == null ? "null" : (config.getParams() == null ? "null" : config.getParams().get("location"))) + "\n");
			}
		}catch(Exception e){
		}
		return ret;
		//return ai.invoke();
	}

	
}
