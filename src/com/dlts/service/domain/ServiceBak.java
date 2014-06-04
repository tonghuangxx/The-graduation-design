package com.dlts.service.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
/**
 * 业务资费更新备份实体类
 * @author CWB
 *
 */
@Entity
@Table(name="DLTS_SERVICE_UPDATE_BAK")
public class ServiceBak {
	/**
	 * 主键
	 */
	private String id;
	/**
	 * 业务id
	 */
	private String service_id;
	/**
	 * 资费id
	 */
	private String cost_id;
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
	public String getService_id() {
		return service_id;
	}
	public void setService_id(String serviceId) {
		service_id = serviceId;
	}
	public String getCost_id() {
		return cost_id;
	}
	public void setCost_id(String costId) {
		cost_id = costId;
	}
	
}
