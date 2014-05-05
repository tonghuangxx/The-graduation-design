package com.dlts.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;


/**
 * 读取属性文件
 * @author CWB
 *
 */
public class ConfigUtils {
	private static Properties p=new Properties();
	static{
		ClassLoader loader=ConfigUtils.class.getClassLoader();
		InputStream ips=loader.getResourceAsStream("daoconfig.properties");
		try {
			p.load(ips);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	public static String getValue(String key){
		return p.getProperty(key);
	}
}
