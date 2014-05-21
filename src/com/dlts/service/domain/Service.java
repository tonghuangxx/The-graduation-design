package com.dlts.service.domain;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;

import com.dlts.account.domain.Account;
import com.dlts.fee.domain.Fee;
import com.dlts.host.domain.Host;
/**
 * 业务实体类
 * @author CWB
 *
 */
@Entity
@Table(name="dlts_service")
public class Service {
	/**
	 * 主键
	 */
	private String id;
	/**
	 * 账务id
	 */
	private String account_id;
	/**
	 * 服务器id
	 */
	private String unix_host;
	/**
	 * 登录账号
	 */
	private String os_username;
	/**
	 * 登录密码
	 */
	private String login_passwd;
	/**
	 * 状态 0：开通 1：暂停 2：删除
	 */
	private String status;
	/**
	 * 创建时间
	 */
	private Date create_date;
	/**
	 * 暂停时间
	 */
	private Date pause_date;
	/**
	 * 删除时间
	 */
	private Date close_date;
	/**
	 * 资费id
	 */
	private String cost_id;
	/**
	 * 资费
	 */
	private Fee fee;
	/**
	 * 账务
	 */
	private Account account;
	/**
	 * 服务器
	 */
	private Host host;
	@Id
	@GeneratedValue(generator = "uuidGenerator")
	@GenericGenerator(name = "uuidGenerator", strategy = "uuid")
	@Column(name = "id", unique = true, nullable = false, insertable = true, updatable = true, length = 32)
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
	public String getUnix_host() {
		return unix_host;
	}
	public void setUnix_host(String unixHost) {
		unix_host = unixHost;
	}
	public String getOs_username() {
		return os_username;
	}
	public void setOs_username(String osUsername) {
		os_username = osUsername;
	}
	public String getLogin_passwd() {
		return login_passwd;
	}
	public void setLogin_passwd(String loginPasswd) {
		login_passwd = loginPasswd;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Date getCreate_date() {
		return create_date;
	}
	public void setCreate_date(Date createDate) {
		create_date = createDate;
	}
	public Date getPause_date() {
		return pause_date;
	}
	public void setPause_date(Date pauseDate) {
		pause_date = pauseDate;
	}
	public Date getClose_date() {
		return close_date;
	}
	public void setClose_date(Date closeDate) {
		close_date = closeDate;
	}
	public String getCost_id() {
		return cost_id;
	}
	public void setCost_id(String costId) {
		cost_id = costId;
	}
	@Transient
	public Fee getFee() {
		return fee;
	}
	public void setFee(Fee fee) {
		this.fee = fee;
	}
	@Transient
	public Account getAccount() {
		return account;
	}
	public void setAccount(Account account) {
		this.account = account;
	}
	@Transient
	public Host getHost() {
		return host;
	}
	public void setHost(Host host) {
		this.host = host;
	}
	
}
