package com.cr.ic.pojo;

import java.util.Date;
import java.util.List;

/**
 * @author bluewater
 * @description 正式模板库，无前缀ic.新建审计项目时从此库中选择模板.与无ic前缀的templet_item,invest,test构成一套
 */
public class Templet {
	private Integer id;

	private Date create_date;

	private String create_name;

	public String getTemplet_name() {
		return templet_name;
	}

	public void setTemplet_name(String templet_name) {
		this.templet_name = templet_name;
	}

	private String templet_name;
	// 模板和模板项是一对多的关系
	private List<Templet_Item> templet_items;

	public List<Templet_Item> getTemplet_items() {
		return templet_items;
	}

	public void setTemplet_items(List<Templet_Item> templet_items) {
		this.templet_items = templet_items;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Date getCreate_date() {
		return create_date;
	}

	public void setCreate_date(Date create_date) {
		this.create_date = create_date;
	}

	public String getCreate_name() {
		return create_name;
	}

	public void setCreate_name(String create_name) {
		this.create_name = create_name;
	}
}
