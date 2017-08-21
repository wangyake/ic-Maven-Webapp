package com.cr.ic.dao;

import java.util.List;
import com.cr.ic.pojo.Tests;

public interface Tests_Dao {
	//新建测试
	int insertTest(Tests tests);
	//更新测试
	int modifyTest(Tests tests);
	//删除测试
	int deleteTest(int id);
	//由模板项获得其下的测试
	List<Tests> getTestByItemId(int item_id);
	//删除多个模板项下的测试
	void deleteTestByItemIds(int item_ids[]);
	//获得多个模板项下的测试
	List<Integer> getTestIdsByItemIds(List<Integer> ids);
	//批量新建测试
	void insertTestsBatch(List<Tests> tests_List);
}
