package com.dlts.monthduration.domain;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Embeddable;
/**
 * 时长表的主键
 * @author Administrator
 *
 */
@Embeddable
public class MonthDurationId implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * 业务id
	 */
	private String service_id;
	/**
	 * 月份
	 */
	private Date month_id;
	public String getService_id() {
		return service_id;
	}
	public void setService_id(String serviceId) {
		service_id = serviceId;
	}
	public Date getMonth_id() {
		return month_id;
	}
	public void setMonth_id(Date monthId) {
		month_id = monthId;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((month_id == null) ? 0 : month_id.hashCode());
		result = prime * result
				+ ((service_id == null) ? 0 : service_id.hashCode());
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
		MonthDurationId other = (MonthDurationId) obj;
		if (month_id == null) {
			if (other.month_id != null)
				return false;
		} else if (!month_id.equals(other.month_id))
			return false;
		if (service_id == null) {
			if (other.service_id != null)
				return false;
		} else if (!service_id.equals(other.service_id))
			return false;
		return true;
	}
	
}
