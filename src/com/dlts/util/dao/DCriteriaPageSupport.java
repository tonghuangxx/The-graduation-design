package com.dlts.util.dao;

import java.util.ArrayList;
import java.util.List;

/**
 * 分页
 * @author cuixy
 *
 * @param <T> T
 */
public class DCriteriaPageSupport<T> extends ArrayList<T> {
	/**
	 * 每页默认20条
	 */
	public static final int IPAGESIZE = 20;
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	/**
	 * 每页条数
	 */
	private int pageSize = IPAGESIZE;
	/**
	 * 总数
	 */
	private long totalCount;
	/**
	 * 下表
	 */
	private int[] indexes = new int[0];
	/**
	 * 起始位置
	 */
	private int startIndex = 0;
	/**
	 * 数量的字符串
	 */
	private String countString;

	/**
	 * ArrayList
	 */
	public DCriteriaPageSupport(List list) {
		super(list);
	}

	/**
	 * 设置页码
	 * 
	 * @param totalCount
	 *            int
	 */
	public DCriteriaPageSupport(List list, long totalCount) {
		super(list);
		setPageSize(IPAGESIZE);
		setTotalCount(totalCount);
		setStartIndex(0);
	}

	/**
	 * 设置页码
	 * 
	 * @param totalCount
	 *            int
	 */

	public DCriteriaPageSupport(List list, long totalCount, int startIndex) {
		super(list);
		setPageSize(IPAGESIZE);
		setTotalCount(totalCount);
		setStartIndex(startIndex);
	}

	/**
	 * 设置页码
	 * 
	 * @param totalCount
	 *            int
	 */

	public DCriteriaPageSupport(List list, long totalCount, int pageSize, int startIndex) {
		super(list);
		setPageSize(pageSize);
		setTotalCount(totalCount);
		setStartIndex(startIndex);
	}

	/**
	 * 总记录数
	 * 
	 * @return int
	 */
	public long getTotalCount() {
		return totalCount;
	}

	/**
	 * 总记录数 ， 同时计算总页数 ， 计算每页的起始位置
	 * 
	 * @param totalCount
	 *            int
	 */
	public final void setTotalCount(long totalCount) {
		if (totalCount > 0) {
			this.totalCount = totalCount;
			int count = (int) (totalCount / pageSize);
			if (totalCount % pageSize > 0) {
				count++;
			}
			indexes = new int[count];
			for (int i = 0; i < count; i++) {
				indexes[i] = pageSize * i;
			}
		} else {
			this.totalCount = 0;
		}
	}

	public int getStartIndex() {
		return startIndex;
	}

	/**
	 * 起始记录位置
	 * 
	 * @param startIndex
	 *            int
	 */
	public final void setStartIndex(int startIndex) {
		if (totalCount <= 0) {
			this.startIndex = 0;
		} else if (startIndex >= totalCount) {
			this.startIndex = indexes[indexes.length - 1];
		} else if (startIndex < 0) {
			this.startIndex = 0;
		} else {
			this.startIndex = indexes[startIndex / pageSize];
		}
	}

	/**
	 * pageSize
	 * 
	 * @return pageSize
	 */
	public int getPageSize() {
		return pageSize;
	}

	public final void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	/**
	 * 下一页
	 * 
	 * @return int
	 */
	public int getNextIndex() {
		int nextIndex = getStartIndex() + pageSize;
		if (nextIndex >= totalCount) {
			return getStartIndex();
		} else {
			return nextIndex;
		}
	}

	/**
	 * 上一页
	 * 
	 * @return int
	 */
	public int getPreviousIndex() {
		int previousIndex = getStartIndex() - pageSize;
		if (previousIndex < 0) {
			return 0;
		} else {
			return previousIndex;
		}
	}

	/**
	 * 对于不同属性总数的一个描述字符串
	 * 
	 * @return String
	 */
	public String getCountString() {
		return countString;
	}

	/**
	 * @param countString
	 *            countString
	 */
	public void setCountString(String countString) {
		this.countString = countString;
	}
}
