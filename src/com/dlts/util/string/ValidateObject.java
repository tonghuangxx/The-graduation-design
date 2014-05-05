package com.dlts.util.string;

import java.util.Collection;

/**
 *数据有效性验证工具
 * 
 * @author Administrator
 */
public class ValidateObject {
	/**
	 * 判断字符串是否有值
	 * 
	 * @param s
	 *            s
	 * @return true/false
	 */
	public static boolean hasValue(String s) {
		boolean result = false;
		if (s != null) {
			for (int i = 0; i < s.length(); i++) {
				if (s.charAt(i) != ' ') {
					result = true;
					break;
				}
			}
		}
		return result;
	}

	/**
	 * 判断数组中是否有数据，即长度大于等于0
	 * 
	 * @param array
	 *            数组
	 * @return true/false
	 */
	public static boolean hasValueInArray(Object[] array) {
		return array == null || array.length == 0 ? false : true;
	}

	/**
	 * 判断结合中是否有值
	 * 
	 * @param c
	 *            集合
	 * @return boolean
	 */
	public static boolean hasValueInCollection(Collection c) {
		return c == null || c.isEmpty() ? false : true;
	}
	
}
