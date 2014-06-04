package com.dlts.billitem.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;

import com.dlts.bill.domain.Bill;
import com.dlts.monthduration.domain.MonthDuration;
import com.dlts.service.domain.Service;
/**
 * 账单条目实体类
 * @author Administrator
 *
 */
@Entity
@Table(name="DLTS_BILL_ITEM")
public class BillItem {
	/**
	 * 主键
	 */
	private String id;
	/**
	 * 账单id
	 */
	private String bill_id;
	/**
	 * 业务id
	 */
	private String service_id;
	/**
	 * 花费
	 */
	private float cost;
	/**
	 * 业务
	 */
	private Service service;
	/**
	 * 账单
	 */
	private Bill bill;
	/**
	 * 时长
	 */
	private MonthDuration monthDuration;
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
	public String getBill_id() {
		return bill_id;
	}
	public void setBill_id(String billId) {
		bill_id = billId;
	}
	public String getService_id() {
		return service_id;
	}
	public void setService_id(String serviceId) {
		service_id = serviceId;
	}
	public float getCost() {
		return cost;
	}
	public void setCost(float cost) {
		this.cost = cost;
	}
	@Transient
	public Service getService() {
		return service;
	}
	public void setService(Service service) {
		this.service = service;
	}
	@Transient
	public Bill getBill() {
		return bill;
	}
	public void setBill(Bill bill) {
		this.bill = bill;
	}
	@Transient
	public MonthDuration getMonthDuration() {
		return monthDuration;
	}
	public void setMonthDuration(MonthDuration monthDuration) {
		this.monthDuration = monthDuration;
	}
}
