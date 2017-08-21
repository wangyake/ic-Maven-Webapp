package com.cr.ic.pojo;

import java.util.Date;
import java.util.List;

/*==============================================================
 /* Table: "ic_audit"                                            
 /*==============================================================
 /* 审计项目表
 * 
 */
public class Ic_Audit {
	private Integer id;
	private Integer templet_id;
	private Date audit_date;
	private String audit_name;
	private Integer create_id;
	private Ic_User ic_user;
	private List<Ic_Test_Result> ic_test_results;
	private List<Ic_Invest_Result> ic_invest_results;
	// 模板templet和审计项目audit是一对多的关系，这里先在audit中设置关系
	private Ic_Templet ic_templet;

	public Integer getCreate_id() {
		return create_id;
	}

	public Ic_User getIc_user() {
		return ic_user;
	}

	public void setIc_user(Ic_User ic_user) {
		this.ic_user = ic_user;
	}

	public void setCreate_id(Integer create_id) {
		this.create_id = create_id;
	}

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

	public Date getAudit_date() {
		return audit_date;
	}

	public void setAudit_date(Date audit_date) {
		this.audit_date = audit_date;
	}

	public String getAudit_name() {
		return audit_name;
	}

	public void setAudit_name(String audit_name) {
		this.audit_name = audit_name;
	}

	public Ic_Templet getIc_templet() {
		return ic_templet;
	}

	public void setIc_templet(Ic_Templet ic_templet) {
		this.ic_templet = ic_templet;
	}

	public List<Ic_Test_Result> getIc_test_results() {
		return ic_test_results;
	}

	public void setIc_test_results(List<Ic_Test_Result> ic_test_results) {
		this.ic_test_results = ic_test_results;
	}

	public List<Ic_Invest_Result> getIc_invest_results() {
		return ic_invest_results;
	}

	public void setIc_invest_results(List<Ic_Invest_Result> ic_invest_results) {
		this.ic_invest_results = ic_invest_results;
	}
}
