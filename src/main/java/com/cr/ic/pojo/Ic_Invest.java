package com.cr.ic.pojo;

public class Ic_Invest {
	private Integer id;
	private Integer item_id;
	private String invest_name;
	private Ic_Templet_Item ic_templet_item;

	public String getInvest_name() {
		return invest_name;
	}

	public void setInvest_name(String invest_name) {
		this.invest_name = invest_name;
	}

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

	public Ic_Templet_Item getIc_templet_item() {
		return ic_templet_item;
	}

	public void setIc_templet_item(Ic_Templet_Item ic_templet_item) {
		this.ic_templet_item = ic_templet_item;
	}

}
