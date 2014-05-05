package com.dlts.util;

import org.springframework.web.context.WebApplicationContext;

/**
 * spring帮助类
 * 
 * @author Administrator
 */
public class SpringUtil {
	/**
	 * spring context
	 */
	private static WebApplicationContext wc;

	/**
	 * 设置spring context
	 * 
	 * @param webApplicationContext
	 *            spring上下文
	 */
	public static void setWac(WebApplicationContext webApplicationContext) {
		wc = webApplicationContext;
	}

	/**
	 * 获取spring context
	 * 
	 * @return spring上下文
	 */
	public static WebApplicationContext getWebApplicationContext() {
		return wc;
	}

}
