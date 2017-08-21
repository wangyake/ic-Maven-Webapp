package com.cr.ic.service;

import java.util.List;

import com.cr.ic.pojo.Ic_Test;

public interface Ic_Test_Service {
	public int add_Test(Ic_Test Test);

	public int update_Test(Ic_Test Test);

	public int delete_Test(int id);

	public List<Ic_Test> queryTestByItemId(int item_id);

	public void deleteTestByItemIds(int item_ids[]);

	public List<Integer> queryTestIdsByItemIds(List<Integer> ids);

	public void add_Ic_Test_List(List<Ic_Test> list);

	public void updateIcTestBatch(List<Ic_Test> list);
}
