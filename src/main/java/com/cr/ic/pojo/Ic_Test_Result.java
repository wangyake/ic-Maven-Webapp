package com.cr.ic.pojo;

public class Ic_Test_Result {
	private Integer trid;
	private Integer audit_id;
	private Integer test_id;
	private String test_effect;
	private String test_risk;
	private String test_record;
	// 测试结果和测试一对一
	private Ic_Test ic_test;

	public Ic_Test getIc_test() {
		return ic_test;
	}

	public Integer getTrid() {
		return trid;
	}

	public void setTrid(Integer trid) {
		this.trid = trid;
	}

	public void setIc_test(Ic_Test ic_test) {
		this.ic_test = ic_test;
	}

	public Integer getAudit_id() {
		return audit_id;
	}

	public void setAudit_id(Integer audit_id) {
		this.audit_id = audit_id;
	}

	public Integer getTest_id() {
		return test_id;
	}

	public void setTest_id(Integer test_id) {
		this.test_id = test_id;
	}

	public String getTest_effect() {
		return test_effect;
	}

	public void setTest_effect(String test_effect) {
		this.test_effect = test_effect;
	}

	public String getTest_risk() {
		return test_risk;
	}

	public void setTest_risk(String test_risk) {
		this.test_risk = test_risk;
	}

	public String getTest_record() {
		return test_record;
	}

	public void setTest_record(String test_record) {
		this.test_record = test_record;
	}
}
