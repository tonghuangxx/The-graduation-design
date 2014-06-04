package com.dlts.monthduration.domain;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
/**
 * 时长实体类
 * @author Administrator
 *
 */
@Entity
@Table(name="dlts_month_duration")
public class MonthDuration {
	private MonthDurationId id;
	private String service_detail_id;
	/**
	 * 所用的时长
	 */
	private int sofar_duration;
	@Id
	public MonthDurationId getId() {
		return id;
	}
	public void setId(MonthDurationId id) {
		this.id = id;
	}
	public String getService_detail_id() {
		return service_detail_id;
	}
	public void setService_detail_id(String serviceDetailId) {
		service_detail_id = serviceDetailId;
	}
	public int getSofar_duration() {
		return sofar_duration;
	}
	public void setSofar_duration(int sofarDuration) {
		sofar_duration = sofarDuration;
	}
	
}
