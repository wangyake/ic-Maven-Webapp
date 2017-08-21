package com.cr.ic.pojo;

public class Ic_Invest_Result {
	private Integer irid;
	private Integer audit_id;
	private Integer invest_id;
	private String invest_result;
	private String invest_remark;
	// 调查结果和调查是一对一
	private Ic_Invest ic_invest;

	public Integer getIrid() {
		return irid;
	}

	public void setIrid(Integer irid) {
		this.irid = irid;
	}

	public Ic_Invest getIc_invest() {
		return ic_invest;
	}

	public void setIc_invest(Ic_Invest ic_invest) {
		this.ic_invest = ic_invest;
	}

	@Override
	public String toString() {
		return "Ic_Invest_Result [irid=" + irid + ", audit_id=" + audit_id
				+ ", invest_id=" + invest_id + ", invest_result="
				+ invest_result + ", invest_remark=" + invest_remark + "]";
	}

	public Integer getAudit_id() {
		return audit_id;
	}

	public void setAudit_id(Integer audit_id) {
		this.audit_id = audit_id;
	}

	public Integer getInvest_id() {
		return invest_id;
	}

	public void setInvest_id(Integer invest_id) {
		this.invest_id = invest_id;
	}

	public String getInvest_result() {
		return invest_result;
	}

	public void setInvest_result(String invest_result) {
		this.invest_result = invest_result;
	}

	public String getInvest_remark() {
		return invest_remark;
	}

	public void setInvest_remark(String invest_remark) {
		this.invest_remark = invest_remark;
	}

}
