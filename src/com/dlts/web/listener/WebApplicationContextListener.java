package com.dlts.web.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.springframework.web.context.support.WebApplicationContextUtils;

import com.dlts.util.ContextUtil;
import com.dlts.util.SpringUtil;

/**
 * web应用初始化加载
 * 
 * @author Administrator
 */
public class WebApplicationContextListener implements ServletContextListener {

	/**
	 * 关闭
	 * 
	 * @param servletContextEvent
	 *            servletContextEvent
	 */
	public void contextDestroyed(ServletContextEvent servletContextEvent) {
		System.exit(0);
	}

	/**
	 * 启动
	 * 
	 * @param servletContextEvent
	 *            servletContextEvent
	 */
	public void contextInitialized(ServletContextEvent servletContextEvent) {
		SpringUtil.setWac(WebApplicationContextUtils.getWebApplicationContext(servletContextEvent.getServletContext()));
		ContextUtil.setContextPath(servletContextEvent.getServletContext().getContextPath());
		String realPath=servletContextEvent.getServletContext().getRealPath("");
		ContextUtil.setRealPath(realPath);
		SpringUtil.setWac(WebApplicationContextUtils.getWebApplicationContext(servletContextEvent.getServletContext()));
		/*new Thread(new Runnable() {
			
			public void run() {
				ContentService contentService = (ContentService) SpringUtil.getWebApplicationContext().getBean("contentService");
				contentService.deletedIndex();
			}
		}).start();*/
		
	}

}
