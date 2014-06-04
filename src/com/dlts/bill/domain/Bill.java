package com.dlts.bill.domain;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;

import com.dlts.account.domain.Account;

/**
 * 账单实体类
 * @author Administrator
 *
 */
@Entity
@Table(name="DLTS_BILL")
public class Bill {
	/**
	 * 主键
	 */
	private String id;
	/**
	 * 账务id
	 */
	private String account_id;
	/**
	 * 账单月份
	 */
	private Date bill_month;
	/**
	 * 花费
	 */
	private float cost;
	/**
	 * 支付方式
	 */
	private String payment_mode;
	/**
	 * 是否支付(0:未支付 1：支付)
	 */
	private String pay_state;
	/**
	 * 账务信息	
	 */
	private Account account;
	@Id
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getAccount_id() {
		return account_id;
	}
	public void setAccount_id(String accountId) {
		account_id = accountId;
	}
	public Date getBill_month() {
		return bill_month;
	}
	public void setBill_month(Date billMonth) {
		bill_month = billMonth;
	}
	public float getCost() {
		return cost;
	}
	public void setCost(float cost) {
		this.cost = cost;
	}
	public String getPayment_mode() {
		return payment_mode;
	}
	public void setPayment_mode(String paymentMode) {
		payment_mode = paymentMode;
	}
	public String getPay_state() {
		return pay_state;
	}
	public void setPay_state(String payState) {
		pay_state = payState;
	}
	@Transient
	public Account getAccount() {
		return account;
	}
	public void setAccount(Account account) {
		this.account = account;
	}
	
}
