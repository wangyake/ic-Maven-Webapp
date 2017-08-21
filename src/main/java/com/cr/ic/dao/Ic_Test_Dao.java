package com.cr.ic.dao;

import java.util.List;

import com.cr.ic.pojo.Ic_Test;

public interface Ic_Test_Dao {
	//新建测试
	int insertTest(Ic_Test Test);
	//更新测试
	int modifyTest(Ic_Test Test);
	//删除测试
	int deleteTest(int id);
	//由模板项获得其下的测试
	List<Ic_Test> getTestByItemId(int item_id);
	//删除多个模板项下的测试
	void deleteTestByItemIds(int item_ids[]);
	//获得多个模板项下的测试
	List<Integer> getTestIdsByItemIds(List<Integer> ids);
	//批量新建测试
	void insertIc_TestBatch(List<Ic_Test> list);
	//批量更新测试
	void updateIcTestBatch(List<Ic_Test> list);
}
