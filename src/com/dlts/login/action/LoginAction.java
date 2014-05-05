package com.dlts.login.action;

import java.io.IOException;
import java.io.PrintWriter;

import com.dlts.admininfo.domain.AdminInfo;
import com.dlts.login.service.LoginService;
import com.dlts.util.SpringUtil;
import com.dlts.util.string.ConstantString;
import com.dlts.web.action.BaseAction;
/**
 * 用户登录action
 * @author 	CWB
 *
 */
public class LoginAction extends BaseAction{
	private LoginService loginService = (LoginService) SpringUtil.getWebApplicationContext().getBean("loginService"); 
	/**
	 * 用户
	 */
	private AdminInfo adminInfo;
	/**
	 * 用户输入的验证码
	 */
	private String yzm;
	/**
	 * 返回的操作信息
	 */
	private String message;

	/**
	 * 验证验证码
	 * @return
	 */
	public String testYZM(){
		response.setContentType("text/html;charset=utf-8");
		String code=(String) request.getSession().getAttribute(com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);
		PrintWriter out=null;
		try {
			out=response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		if(!code.equalsIgnoreCase(yzm)){
			this.setMessage("验证码错误");
			out.print(message);
		}else{
			this.setMessage("验证码正确");
			out.print(message);
		}
		return null;
	}
	
	/**
	 * 用户登录
	 * @return
	 */
	public String login(){
		adminInfo = loginService.findByCode(adminInfo);
		String result = null;
		if(adminInfo == null){
			this.setMessage("用户名不存在");
			result = ConstantString.FALSE;
		}else{
			adminInfo = loginService.findByCodeAndPwd(adminInfo);
			if(adminInfo == null){
				this.setMessage("密码错误");
				result = ConstantString.FALSE;
			}else{
				result = ConstantString.SUCCESS;
			}
		}
		return result;
	}
	
	/**
	 * 退出
	 * @return
	 */
	public String loginOut(){
		request.getSession().setAttribute(ConstantString.USER, null);
		return ConstantString.SUCCESS;
	}

	public AdminInfo getAdminInfo() {
		return adminInfo;
	}

	public void setAdminInfo(AdminInfo adminInfo) {
		this.adminInfo = adminInfo;
	}


	public String getYzm() {
		return yzm;
	}


	public void setYzm(String yzm) {
		this.yzm = yzm;
	}

	public String getMessage() {
		return message;
	}


	public void setMessage(String message) {
		this.message = message;
	}
	
}
