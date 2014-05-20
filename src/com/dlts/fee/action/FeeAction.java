package com.dlts.fee.action;

import java.io.IOException;
import java.io.PrintWriter;

import com.dlts.fee.domain.Fee;
import com.dlts.fee.service.FeeService;
import com.dlts.util.ContextUtil;
import com.dlts.util.SpringUtil;
import com.dlts.util.dao.DCriteriaPageSupport;
import com.dlts.util.string.ConstantString;
import com.dlts.web.action.ActionResult;
import com.dlts.web.action.BaseAction;

public class FeeAction extends BaseAction{
	private FeeService feeService = (FeeService) SpringUtil.getWebApplicationContext().getBean("feeService");
	/**
	 * 显示index页面的内容
	 */
	private String indexList;
	/**
	 * 显示数据
	 */
	private DCriteriaPageSupport<Fee> feeList;
	/**
	 * 增加页面的数据
	 */
	private Fee fee;
	/**
	 * 显示界面的排序条件
	 */
	private String[] con_sort;
	/**
	 * 跳转到显示页面
	 * @return
	 */
	public String list(){
		indexList=this.getIndexList();
		return ConstantString.SUCCESS;
	}
	
	/**
	 * 分页显示数据
	 * @return
	 */
	public String listData(){
		feeList = feeService.list(pageNum, numPerPage);
		total = feeList.getTotalCount();
		countPageCount();
		return ConstantString.SUCCESS;
	}
	/**
	 * 排序
	 * @return
	 */
	public String sort(){
		feeList = feeService.sort(con_sort,pageNum, numPerPage);
		total = feeList.getTotalCount();
		countPageCount();
		return ConstantString.SUCCESS;
	}
	
	/**
	 * 跳转到增加页面
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
		boolean result = feeService.saveFee(fee);
		ActionResult actionResult = new ActionResult(ConstantString.SUCCESSCODE, "添加成功");
		try {
			if(!result){
				actionResult = new ActionResult(ConstantString.FAILURECODE, "添加失败");
			}
			PrintWriter out = response.getWriter();
			out.print(ContextUtil.resultToJson(actionResult));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 跳转到修改页面
	 * @return
	 */
	public String edit(){
		fee = feeService.getFeeById(fee.getId());
		return ConstantString.SUCCESS;
	}
	/**
	 * 修改操作
	 */
	public void editDo(){
		response.setContentType("text/html;charset=utf-8");
		try {
			boolean result = feeService.updateFee(fee);
			ActionResult actionResult = new ActionResult(ConstantString.SUCCESSCODE, "修改成功");
			if(!result){
				actionResult = new ActionResult(ConstantString.FAILURECODE, "修改失败");
			}
			PrintWriter out = response.getWriter();
			out.print(ContextUtil.resultToJson(actionResult));
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	/**
	 * 删除操作
	 */
	public void delete(){
		response.setContentType("text/html;charset=utf-8");
		boolean result = feeService.deleteFee(fee.getId());
		ActionResult actionResult = new ActionResult(ConstantString.SUCCESSCODE, "删除成功");
		try {
			if(!result){
				actionResult = new ActionResult(ConstantString.FAILURECODE, "删除失败");
			}
			PrintWriter out = response.getWriter();
			out.print(ContextUtil.resultToJson(actionResult));
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	/**
	 * 启用资费
	 */
	public void start(){
		response.setContentType("text/html;charset=utf-8");
		boolean result = feeService.updateFeeStart(fee.getId());
		ActionResult actionResult = new ActionResult(ConstantString.SUCCESSCODE, "启用成功");
		try {
			if(!result){
				actionResult = new ActionResult(ConstantString.FAILURECODE, "启用失败");
			}
			PrintWriter out = response.getWriter();
			out.print(ContextUtil.resultToJson(actionResult));
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 显示某条资费的具体信息
	 * @return
	 */
	public String detail(){
		numPerPage = this.getNumPerPage();
		pageNum = this.getPageNum();
		fee = feeService.getFeeById(fee.getId());
		return ConstantString.SUCCESS;
	}
	
	public String getIndexList() {
		return indexList;
	}
	public void setIndexList(String indexList) {
		this.indexList = indexList;
	}
	public DCriteriaPageSupport<Fee> getFeeList() {
		return feeList;
	}
	public void setFeeList(DCriteriaPageSupport<Fee> feeList) {
		this.feeList = feeList;
	}

	public Fee getFee() {
		return fee;
	}

	public void setFee(Fee fee) {
		this.fee = fee;
	}

	public String[] getCon_sort() {
		return con_sort;
	}

	public void setCon_sort(String[] conSort) {
		con_sort = conSort;
	}

	
}
