package com.dlts.account.action;

import java.io.IOException;
import java.io.PrintWriter;

import com.dlts.account.domain.Account;
import com.dlts.account.service.AccountService;
import com.dlts.util.ContextUtil;
import com.dlts.util.SpringUtil;
import com.dlts.util.dao.DCriteriaPageSupport;
import com.dlts.util.string.ConstantString;
import com.dlts.web.action.ActionResult;
import com.dlts.web.action.BaseAction;

public class AccountAction extends BaseAction{
	private AccountService accountService = (AccountService) SpringUtil.getWebApplicationContext().getBean("accountService");
	private DCriteriaPageSupport<Account> accountList;
	/**
	 * 搜索的条件
	 */
	private Account form;
	private Account account;
	/**
	 * 新密码
	 */
	private String newPwd;
	/**
	 * 旧密码
	 */
	private String oldPwd;

	/**
	 * 分页显示数据
	 * @return
	 */
	public String listData(){
		accountList = accountService.list(pageNum, numPerPage);
		total = accountList.getTotalCount();
		countPageCount();
		return ConstantString.SUCCESS;
	}
	
	/**
	 * 搜索
	 * @return
	 */
	public String search(){
		accountList = accountService.search(form,pageNum, numPerPage);
		total = accountList.getTotalCount();
		countPageCount();
		return ConstantString.SUCCESS;
	}
	/**
	 * 详细界面
	 * @return
	 */
	public String detail(){
		numPerPage=this.getNumPerPage();
		pageNum=this.getPageNum();
		account = accountService.getAccountById(account.getId());
		return ConstantString.SUCCESS;
	}
	/**
	 * 跳转到修改界面
	 * @return
	 */
	public String edit(){
		account = accountService.getAccountById(account.getId());
		return ConstantString.SUCCESS;
	}
	/**
	 * 修改操作
	 */
	public void editDo(){
		response.setContentType("text/html;charset=utf-8");
		boolean result = accountService.updateAccount(account,newPwd,oldPwd);
		try {
			ActionResult actionResult = new ActionResult(ConstantString.SUCCESSCODE, "修改成功");
			if(!result){
				actionResult = new ActionResult(ConstantString.FAILURECODE,"修改失败,原密码输入有误");
			}
			PrintWriter out = response.getWriter();
			out.print(ContextUtil.resultToJson(actionResult));
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	/**
	 * 开启
	 */
	public void start(){
		response.setContentType("text/html;charset=utf-8");
		boolean result = accountService.updateAccountStart(account.getId());
		try {
			ActionResult actionResult = new ActionResult(ConstantString.SUCCESSCODE, "开启成功");
			if(!result){
				actionResult = new ActionResult(ConstantString.FAILURECODE,"开启失败");
			}
			PrintWriter out = response.getWriter();
			out.print(ContextUtil.resultToJson(actionResult));
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	/**
	 * 暂停
	 */
	public void stop(){
		response.setContentType("text/html;charset=utf-8");
		boolean result = accountService.updateAccountStop(account.getId());
		try {
			ActionResult actionResult = new ActionResult(ConstantString.SUCCESSCODE, "暂停成功");
			if(!result){
				actionResult = new ActionResult(ConstantString.FAILURECODE,"暂停失败");
			}
			PrintWriter out = response.getWriter();
			out.print(ContextUtil.resultToJson(actionResult));
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	/**
	 * 删除
	 */
	public void delete(){
		response.setContentType("text/html;charset=utf-8");
		boolean result = accountService.delete(account.getId());
		try {
			ActionResult actionResult = new ActionResult(ConstantString.SUCCESSCODE, "删除成功");
			if(!result){
				actionResult = new ActionResult(ConstantString.FAILURECODE,"删除失败");
			}
			PrintWriter out = response.getWriter();
			out.print(ContextUtil.resultToJson(actionResult));
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 跳转到添加界面
	 * @return
	 */
	public String add(){
		return ConstantString.SUCCESS;
	}
	/**
	 * 添加操作
	 */
	public void addDo(){
		response.setContentType("text/html;charset=utf-8");
		boolean result = accountService.saveAccount(account);
		Account rec = accountService.getAccountByIdcard_no(account.getIdcard_no());
		//如果填写的推荐人身份证存在数据库中设置推荐人为该身份证所在记录的id，否则设置为自己的id
		if(rec.getRecommender_id()==null||"".equals(rec.getRecommender_id())){
			rec.setRecommender_id(rec.getId());
		}
		accountService.updateAccountRecommender_id(rec);
		try {
			ActionResult actionResult = new ActionResult(ConstantString.SUCCESSCODE, "添加成功");
			if(!result){
				actionResult = new ActionResult(ConstantString.FAILURECODE,"添加失败");
			}
			PrintWriter out = response.getWriter();
			out.print(ContextUtil.resultToJson(actionResult));
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public DCriteriaPageSupport<Account> getAccountList() {
		return accountList;
	}

	public void setAccountList(DCriteriaPageSupport<Account> accountList) {
		this.accountList = accountList;
	}

	public Account getForm() {
		return form;
	}

	public void setForm(Account form) {
		this.form = form;
	}

	public Account getAccount() {
		return account;
	}

	public void setAccount(Account account) {
		this.account = account;
	}

	public String getNewPwd() {
		return newPwd;
	}

	public void setNewPwd(String newPwd) {
		this.newPwd = newPwd;
	}

	public String getOldPwd() {
		return oldPwd;
	}

	public void setOldPwd(String oldPwd) {
		this.oldPwd = oldPwd;
	}
	
}
