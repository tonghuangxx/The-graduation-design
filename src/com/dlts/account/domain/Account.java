package com.dlts.account.domain;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;
/**
 * 账务实体类
 * @author CWB
 *
 */
@Entity
@Table(name="dlts_account")
public class Account {
	/**
	 * 主键
	 */
	private String id;
	/**
	 * 推荐人id
	 */
	private String recommender_id;
	/**
	 * 登录名
	 */
	private String login_name;
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
	 * 真实姓名
	 */
	private String real_name;
	/**
	 * 身份证号
	 */
	private String idcard_no;
	/**
	 * 生日
	 */
	private Date birthdate;
	/**
	 * 性别
	 */
	private char gender;
	/**
	 * 职业
	 */
	private String occupation;
	/**
	 * 电话
	 */
	private String telephone;
	/**
	 * 邮箱
	 */
	private String email;
	/**
	 * 通讯地址
	 */
	private String mailaddress;
	/**
	 * 邮编
	 */
	private String zipcode;
	/**
	 * qq号
	 */
	private String qq;
	/**
	 * 上次登录时间
	 */
	private Date last_login_time;
	/**
	 * 上次登录ip
	 */
	private String last_login_ip;
	/**
	 * 推荐人
	 */
	private Account recommender;
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
	public String getRecommender_id() {
		return recommender_id;
	}
	public void setRecommender_id(String recommenderId) {
		recommender_id = recommenderId;
	}
	public String getLogin_name() {
		return login_name;
	}
	public void setLogin_name(String loginName) {
		login_name = loginName;
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
	public String getReal_name() {
		return real_name;
	}
	public void setReal_name(String realName) {
		real_name = realName;
	}
	
	public String getIdcard_no() {
		return idcard_no;
	}
	public void setIdcard_no(String idcardNo) {
		idcard_no = idcardNo;
	}
	public Date getBirthdate() {
		return birthdate;
	}
	public void setBirthdate(Date birthdate) {
		this.birthdate = birthdate;
	}
	public char getGender() {
		return gender;
	}
	public void setGender(char gender) {
		this.gender = gender;
	}
	public String getOccupation() {
		return occupation;
	}
	public void setOccupation(String occupation) {
		this.occupation = occupation;
	}
	public String getTelephone() {
		return telephone;
	}
	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getMailaddress() {
		return mailaddress;
	}
	public void setMailaddress(String mailaddress) {
		this.mailaddress = mailaddress;
	}
	
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public String getQq() {
		return qq;
	}
	public void setQq(String qq) {
		this.qq = qq;
	}
	public Date getLast_login_time() {
		return last_login_time;
	}
	public void setLast_login_time(Date lastLoginTime) {
		last_login_time = lastLoginTime;
	}
	public String getLast_login_ip() {
		return last_login_ip;
	}
	public void setLast_login_ip(String lastLoginIp) {
		last_login_ip = lastLoginIp;
	}
	@Transient
	public Account getRecommender() {
		return recommender;
	}
	public void setRecommender(Account recommender) {
		this.recommender = recommender;
	}
	
}
