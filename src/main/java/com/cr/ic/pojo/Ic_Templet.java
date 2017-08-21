package com.cr.ic.pojo;

import java.util.Date;
import java.util.List;
import com.cr.ic.pojo.Ic_Templet_Item;

/**
 * @author bluewater
 * @description 作业模板库，有前缀ic.
 * 与项目绑定，新建项目时从正式模板库中复制过来.
 * 类似的 ic_templet_item,ic_invest,ic_test构成一套
 */
public class Ic_Templet {
	private Integer id;

	private Date create_date;

	private String create_name;

	private String templet_name;

	// 模板和模板项是一对多的关系
	private List<Ic_Templet_Item> ic_templet_items;

	public String getTemplet_name() {
		return templet_name;
	}

	public void setTemplet_name(String templet_name) {
		this.templet_name = templet_name;
	}

	public List<Ic_Templet_Item> getIc_templet_items() {
		return ic_templet_items;
	}

	public void setIc_templet_items(List<Ic_Templet_Item> ic_templet_items) {
		this.ic_templet_items = ic_templet_items;
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
