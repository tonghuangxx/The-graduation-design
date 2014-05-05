package com.dlts.adminrole.domain;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;

import com.dlts.admininfo.domain.AdminInfo;
import com.dlts.role.domain.Role;
/**
 * 用户角色类
 * @author CWB
 *
 */
@Entity
@Table(name="dlts_user_role")
public class AdminRole implements Serializable {
	private static final long serialVersionUID = 1L;
	/**
	 * 主键id
	 */
	private String id;
	/**
	 * 用户id
	 */
	private String usid;
	/**
	 * 角色id
	 */
	private String rid;
	
	/**
	 * 用户
	 */
	private AdminInfo adminInfo;
	/**
	 * 用户的角色
	 */
	private List<Role> role;
	public AdminRole() {
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
	public AdminInfo getAdminInfo() {
		return adminInfo;
	}
	public void setAdminInfo(AdminInfo adminInfo) {
		this.adminInfo = adminInfo;
	}
	@Transient
	public List<Role> getRole() {
		return role;
	}
	public void setRole(List<Role> role) {
		this.role = role;
	}

	public String getUsid() {
		return usid;
	}

	public void setUsid(String usid) {
		this.usid = usid;
	}

	public String getRid() {
		return rid;
	}

	public void setRid(String rid) {
		this.rid = rid;
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
		AdminRole other = (AdminRole) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		return true;
	}

}
