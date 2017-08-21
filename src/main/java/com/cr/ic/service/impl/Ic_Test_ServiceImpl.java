package com.cr.ic.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.cr.ic.dao.Ic_Test_Dao;
import com.cr.ic.pojo.Ic_Test;
import com.cr.ic.service.Ic_Test_Service;

@Service("Ic_Test_Service")
public class Ic_Test_ServiceImpl implements Ic_Test_Service {
	@Resource
	private Ic_Test_Dao test_Dao;

	@Override
	public int add_Test(Ic_Test Test) {
		return this.test_Dao.insertTest(Test);
	}

	@Override
	public int update_Test(Ic_Test Test) {
		return this.test_Dao.modifyTest(Test);
	}

	@Override
	public int delete_Test(int id) {
		return this.test_Dao.deleteTest(id);
	}

	@Override
	public List<Ic_Test> queryTestByItemId(int item_id) {
		return this.test_Dao.getTestByItemId(item_id);
	}

	@Override
	public void deleteTestByItemIds(int item_ids[]) {
		this.test_Dao.deleteTestByItemIds(item_ids);
	}

	@Override
	public List<Integer> queryTestIdsByItemIds(List<Integer> ids) {
		return this.test_Dao.getTestIdsByItemIds(ids);
	}

	@Override
	public void add_Ic_Test_List(List<Ic_Test> list) {
		this.test_Dao.insertIc_TestBatch(list);
	}

	@Override
	public void updateIcTestBatch(List<Ic_Test> list) {
		this.test_Dao.updateIcTestBatch(list);
	}
}
