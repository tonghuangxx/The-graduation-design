package com.dlts.fee.domain;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;


@Entity
@Table(name="DLTS_COST")
public class Fee {
	private String id;
	private String name;
	private int base_duration;
	private float base_cost;
	private float unit_cost;
	private char status;
	private String descr;
	private Date creatime;
	private Date startime;
	private char cost_type;
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getBase_duration() {
		return base_duration;
	}
	public void setBase_duration(int baseDuration) {
		base_duration = baseDuration;
	}
	public float getBase_cost() {
		return base_cost;
	}
	public void setBase_cost(float baseCost) {
		base_cost = baseCost;
	}
	public float getUnit_cost() {
		return unit_cost;
	}
	public void setUnit_cost(float unitCost) {
		unit_cost = unitCost;
	}
	public char getStatus() {
		return status;
	}
	public void setStatus(char status) {
		this.status = status;
	}
	public String getDescr() {
		return descr;
	}
	public void setDescr(String descr) {
		this.descr = descr;
	}
	
	public Date getCreatime() {
		return creatime;
	}
	public void setCreatime(Date creatime) {
		this.creatime = creatime;
	}
	public Date getStartime() {
		return startime;
	}
	public void setStartime(Date startime) {
		this.startime = startime;
	}
	public char getCost_type() {
		return cost_type;
	}
	public void setCost_type(char costType) {
		cost_type = costType;
	}
	
}
