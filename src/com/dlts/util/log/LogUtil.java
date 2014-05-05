package com.dlts.util.log;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 日志帮助类
 * 
 * @author cuixy
 * @date 2012-02-11
 */
public class LogUtil {
	/**
	 * 日志对象
	 */
	private static final Logger LOGGER = LoggerFactory.getLogger(LogUtil.class);

	/**
	 * 写debug级别的日志
	 * 
	 * @param info
	 *            内容
	 */
	public static void debug(String info) {
		LOGGER.debug(info);
	}

	/**
	 * 写info级别的日志
	 * 
	 * @param info
	 *            内容
	 */
	public static void info(String info) {
		LOGGER.info(info);
	}

	/**
	 * 写warn级别的日志
	 * 
	 * @param info
	 *            内容
	 */
	public static void warn(String info) {
		LOGGER.warn(info);
	}

	/**
	 * 写error级别的日志
	 * 
	 * @param info
	 *            内容
	 */
	public static void error(String info) {
		LOGGER.error(info);
	}

	/**
	 * 写error级别的日志
	 * 
	 * @param info
	 *            内容
	 * @param e
	 *            异常
	 */
	public static void error(String info, Throwable e) {
		LOGGER.error(info, e);
	}

	/**
	 * 写error级别的日志
	 * 
	 * @param e
	 *            异常
	 */
	public static void error(Throwable e) {
		LOGGER.error(e.getMessage());
	}

	/**
	 * 打印异常具体信息,不建议使用该方法
	 * 
	 * @param e
	 *            异常
	 */
	public static void printStackTrace(Throwable e) {
		LOGGER.error("错误信息:", e);
		e.printStackTrace();
	}
}
