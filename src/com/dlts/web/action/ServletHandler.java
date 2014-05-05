package com.dlts.web.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dlts.admininfo.domain.AdminInfo;

/**
 * http请求接口
 * 
 * @author CWB
 */
public interface ServletHandler {
	/**
	 * Request
	 * 
	 * @param request
	 *            HttpServletRequest
	 * @throws Exception
	 */
	void setServletRequest(HttpServletRequest request) throws Exception;

	/**
	 * Response
	 * 
	 * @param response
	 *            HttpServletResponse
	 * @throws Exception
	 */
	void setServletResponse(HttpServletResponse response) throws Exception;

	/**
	 * 操作内容描述
	 * @return 操作内容描述
	 */
	String getActionMessage();


	/**
	 * 设置当前用户
	 * @param currentUser	用户
	 * @throws Exception
	 */
	void setCurrentUser(AdminInfo currentUser) throws Exception;

}
