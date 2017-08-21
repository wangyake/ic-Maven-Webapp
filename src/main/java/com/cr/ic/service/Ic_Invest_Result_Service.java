package com.cr.ic.service;

import java.util.List;

import com.cr.ic.pojo.Ic_Invest_Result;

public interface Ic_Invest_Result_Service {
	public int insertInvestResult(Ic_Invest_Result invest_Result);

	public void insertInvestResultBatch(List<Ic_Invest_Result> list);

	public List<Ic_Invest_Result> queryInvestAndResult(int item_id, int audit_id);

	public void updateInvestResultBatch(List<Ic_Invest_Result> result);

	void deleteInvestResultByInvestIds(List<Integer> invest_ids_list);

	void deleteInvestResultByInvestId(Integer id);
}
