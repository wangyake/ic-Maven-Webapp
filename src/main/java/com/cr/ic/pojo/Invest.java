package com.cr.ic.pojo;

/**
 * @author bluewater
 * 模板调查表
 */
public class Invest {
	private Integer id;
	private Integer item_id;
	private String invest_name;
	private Templet_Item templet_item;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getItem_id() {
		return item_id;
	}
	public void setItem_id(Integer item_id) {
		this.item_id = item_id;
	}
	public String getInvest_name() {
		return invest_name;
	}
	public void setInvest_name(String invest_name) {
		this.invest_name = invest_name;
	}
	public Templet_Item getTemplet_item() {
		return templet_item;
	}
	public void setTemplet_item(Templet_Item templet_item) {
		this.templet_item = templet_item;
	}
}
