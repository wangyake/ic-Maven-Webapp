package com.cr.ic.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.cr.ic.dao.Ic_Test_Result_Dao;
import com.cr.ic.pojo.Ic_Test_Result;
import com.cr.ic.service.Ic_Test_Result_Service;

@Service("Test_Result_ServiceImpl")
public class Ic_Test_Result_ServiceImpl implements Ic_Test_Result_Service {
	@Resource
	private Ic_Test_Result_Dao test_Result_Dao;

	@Override
	public int insertTestResult(Ic_Test_Result test_Result) {
		return this.test_Result_Dao.insertTestResult(test_Result);
	}

	@Override
	public void insertTestResultBatch(List<Ic_Test_Result> list) {
		this.test_Result_Dao.insertTestResultBatch(list);
	}

	@Override
	public List<Ic_Test_Result> queryTestAndResult(int item_id, int audit_id) {
		return this.test_Result_Dao.getTestAndResult(item_id, audit_id);
	}

	@Override
	public void updateTestResultBatch(List<Ic_Test_Result> list) {
		this.test_Result_Dao.updateTestResultBatch(list);
	}

	@Override
	public void deleteTestResultByTestIds(List<Integer> test_ids_list) {
		this.test_Result_Dao.deleteTestResultByTestIds(test_ids_list);
	}

	@Override
	public void deleteTestResultByTestId(Integer id) {
		this.test_Result_Dao.deleteTestResultByTestId(id);
	}
}
