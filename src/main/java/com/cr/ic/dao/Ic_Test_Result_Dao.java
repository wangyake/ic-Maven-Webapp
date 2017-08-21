package com.cr.ic.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.cr.ic.pojo.Ic_Test_Result;

public interface Ic_Test_Result_Dao {
	//新建测试结果
	int insertTestResult(Ic_Test_Result test_Result);
	//批量新建测试结果
	void insertTestResultBatch(List<Ic_Test_Result> list);
	//由模板项id和审计项目id获得test和对应的结果
	List<Ic_Test_Result> getTestAndResult(@Param("item_id") int item_id,
			@Param("audit_id") int audit_id);
	//批量更新测试结果
	void updateTestResultBatch(List<Ic_Test_Result> list);
	//删除多个测试对应的测试结果
	void deleteTestResultByTestIds(List<Integer> test_ids_list);
	//删除测试对应的测试结果
	void deleteTestResultByTestId(Integer id);
}
