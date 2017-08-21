package com.cr.ic.pojo;

/**
 * @author bluewater 模板项表
 */

public class Templet_Item {
	private Integer id;

	private Integer templet_id;

	private Integer parent_id;

	private Integer item_order;

	private String item_name;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getTemplet_id() {
		return templet_id;
	}

	public void setTemplet_id(Integer templet_id) {
		this.templet_id = templet_id;
	}

	public Integer getParent_id() {
		return parent_id;
	}

	public void setParent_id(Integer parent_id) {
		this.parent_id = parent_id;
	}

	public Integer getItem_order() {
		return item_order;
	}

	public void setItem_order(Integer item_order) {
		this.item_order = item_order;
	}

	public String getItem_name() {
		return item_name;
	}

	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}
}
