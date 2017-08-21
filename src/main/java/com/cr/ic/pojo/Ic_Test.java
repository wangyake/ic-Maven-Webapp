package com.cr.ic.pojo;

public class Ic_Test {
	private Integer id;
	private Integer item_id;
	private String test_target;
	private String test_weakness;
	private String test_method;
	private Ic_Templet_Item ic_templet_item;

	public Integer getId() {
		return id;
	}

	public Ic_Templet_Item getIc_templet_item() {
		return ic_templet_item;
	}

	public void setIc_templet_item(Ic_Templet_Item ic_templet_item) {
		this.ic_templet_item = ic_templet_item;
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

	public String getTest_target() {
		return test_target;
	}

	public void setTest_target(String test_target) {
		this.test_target = test_target;
	}

	public String getTest_weakness() {
		return test_weakness;
	}

	public void setTest_weakness(String test_weakness) {
		this.test_weakness = test_weakness;
	}

	public String getTest_method() {
		return test_method;
	}

	public void setTest_method(String test_method) {
		this.test_method = test_method;
	}
}
