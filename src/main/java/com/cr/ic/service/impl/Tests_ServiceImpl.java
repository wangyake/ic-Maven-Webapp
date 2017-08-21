package com.cr.ic.service.impl;

import java.util.List;

import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.cr.ic.dao.Tests_Dao;
import com.cr.ic.pojo.Tests;
import com.cr.ic.service.Tests_Service;

@Service("Tests_Service")
public class Tests_ServiceImpl implements Tests_Service {
	@Resource
	private Tests_Dao tests_Dao;

	@Override
	public int add_Test(Tests tests) {
		return this.tests_Dao.insertTest(tests);
	}

	@Override
	public int update_Test(Tests tests) {
		return this.tests_Dao.modifyTest(tests);
	}

	@Override
	public int delete_Test(int id) {
		return this.tests_Dao.deleteTest(id);
	}

	@Override
	public List<Tests> queryTestByItemId(int item_id) {
		return this.tests_Dao.getTestByItemId(item_id);
	}

	@Override
	public void deleteTestByItemIds(int item_ids[]) {
		this.tests_Dao.deleteTestByItemIds(item_ids);
	}

	@Override
	public List<Integer> queryTestIdsByItemIds(List<Integer> ids) {
		return this.tests_Dao.getTestIdsByItemIds(ids);
	}

	@Override
	public void add_Tests_List(List<Tests> tests_List) {
		this.tests_Dao.insertTestsBatch(tests_List);
	}
}
