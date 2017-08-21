package com.cr.ic.pojo;


public class Ic_Templet_Item {
	private Integer id;
	
	private Integer templet_id;
	
	private Integer parent_id;
	
	private Integer item_order;
	
	private String item_name;
	
	@Override
	public String toString() {
		return "Ic_Templet_Item [id=" + id + ", templet_id=" + templet_id
				+ ", parent_id=" + parent_id + ", item_order=" + item_order
				+ ", item_name=" + item_name + "]";
	}
	
	//父级模板项一对一，可为空
	//private Ic_Templet_Item parent_templet_item;
	//模板项和测试一对多
	//private List<Ic_Test> Ic_Tests;
	//模板项和调查一对多
	//private List<Ic_Invest> Ic_Invests;
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
	public Ic_Templet_Item() {
		super();
	}
	
	public Ic_Templet_Item(Integer id, Integer templet_id, Integer parent_id,
				Integer item_order, String item_name) {
			super();
			this.id = id;
			this.templet_id = templet_id;
			this.parent_id = parent_id;
			this.item_order = item_order;
			this.item_name = item_name;
		}
}
