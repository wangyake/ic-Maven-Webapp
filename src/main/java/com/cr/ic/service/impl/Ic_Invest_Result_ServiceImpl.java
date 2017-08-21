package com.cr.ic.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.cr.ic.dao.Ic_Invest_Result_Dao;
import com.cr.ic.pojo.Ic_Invest_Result;
import com.cr.ic.service.Ic_Invest_Result_Service;

@Service("Invest_Result_Service")
public class Ic_Invest_Result_ServiceImpl implements Ic_Invest_Result_Service {
	@Resource
	private Ic_Invest_Result_Dao invest_Result_Dao;

	@Override
	public int insertInvestResult(Ic_Invest_Result invest_Result) {
		return this.invest_Result_Dao.insertInvestResult(invest_Result);
	}

	@Override
	public void insertInvestResultBatch(List<Ic_Invest_Result> list) {
		this.invest_Result_Dao.insertInvestResultBatch(list);
	}

	@Override
	public List<Ic_Invest_Result> queryInvestAndResult(int item_id, int audit_id) {
		return this.invest_Result_Dao.getInvestAndResult(item_id, audit_id);
	}

	@Override
	public void updateInvestResultBatch(List<Ic_Invest_Result> result) {
		this.invest_Result_Dao.updateInvestResultBatch(result);
	}

	@Override
	public void deleteInvestResultByInvestIds(List<Integer> invest_ids_list) {
		this.invest_Result_Dao.deleteInvestResultByInvestIds(invest_ids_list);
	}

	@Override
	public void deleteInvestResultByInvestId(Integer id) {
		this.invest_Result_Dao.deleteInvestResultByInvestId(id);
	}
}
