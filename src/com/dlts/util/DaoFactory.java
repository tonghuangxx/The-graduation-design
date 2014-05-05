package com.dlts.util;

/**
 * dao工厂类
 * @author CWB
 *
 */
public class DaoFactory {
	public static Object getInsObject(String type){
		Object obj=null;
		String className=ConfigUtils.getValue(type);
		try {
			obj=Class.forName(className).newInstance();
		} catch (InstantiationException e) {
			e.printStackTrace();
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		return obj;
	}
}	
