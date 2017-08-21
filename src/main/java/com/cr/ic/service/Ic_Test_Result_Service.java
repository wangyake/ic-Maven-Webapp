package com.cr.ic.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cr.ic.pojo.Ic_Test_Result;

public interface Ic_Test_Result_Service {
	int insertTestResult(Ic_Test_Result test_Result);

	void insertTestResultBatch(List<Ic_Test_Result> list);

	List<Ic_Test_Result> queryTestAndResult(@Param("item_id") int item_id,
			@Param("audit_id") int audit_id);

	public void updateTestResultBatch(List<Ic_Test_Result> list);

	void deleteTestResultByTestIds(List<Integer> test_ids_list);

	void deleteTestResultByTestId(Integer id);
}
