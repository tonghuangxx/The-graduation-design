package com.dlts.host.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

/**
 * 服务器实体类
 * @author CWB
 *
 */
@Entity
@Table(name="dlts_host")
public class Host {
	/**
	 * 主键id
	 */
	private String id;
	/**
	 * ip地址
	 */
	private String host_ip;
	/**
	 * 服务器名字
	 */
	private String name;
	/**
	 * 地点
	 */
	private String location;
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
	public String getHost_ip() {
		return host_ip;
	}
	public void setHost_ip(String hostIp) {
		host_ip = hostIp;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	
}
