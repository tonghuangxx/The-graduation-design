package com.dlts.acl.domain;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;

import com.dlts.admininfo.domain.AdminInfo;
import com.dlts.module.domain.Module;
import com.dlts.role.domain.Role;
/**
 * 访问控制类
 * @author CWB
 *
 */
@Entity
@Table(name="dlts_acl")
public class Acl implements Serializable{
	private static final long serialVersionUID = 1L;
	/**
	 * 主键id
	 */
	private String id;
	/**
	 * 用户
	 */
	private AdminInfo adminInfo;
	/**
	 * 角色
	 */
	private Role role;
	/**
	 * 模块
	 */
	private Module module;
	/**
	 * 角色id
	 */
	private String rid;
	/**
	 * 模块id
	 */
	private String mid;
	/**
	 * 添加
	 */
	private int c;
	/**
	 * 读取
	 */
	private int r;
	/**
	 * 跟新
	 */
	private int u;
	/**
	 * 删除
	 */
	private int d;
	public Acl() {
		super();
	}
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
	@Transient
	public Role getRole() {
		return role;
	}
	public void setRole(Role role) {
		this.role = role;
	}
	@Transient
	public Module getModule() {
		return module;
	}
	public void setModule(Module module) {
		this.module = module;
	}
	public int getC() {
		return c;
	}
	public void setC(int c) {
		this.c = c;
	}
	public int getR() {
		return r;
	}
	public void setR(int r) {
		this.r = r;
	}
	public int getU() {
		return u;
	}
	public void setU(int u) {
		this.u = u;
	}
	public int getD() {
		return d;
	}
	public void setD(int d) {
		this.d = d;
	}
	
	public String getRid() {
		return rid;
	}
	public void setRid(String rid) {
		this.rid = rid;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	@Transient
	public AdminInfo getAdminInfo() {
		return adminInfo;
	}
	public void setAdminInfo(AdminInfo adminInfo) {
		this.adminInfo = adminInfo;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Acl other = (Acl) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		return true;
	}
	
}
