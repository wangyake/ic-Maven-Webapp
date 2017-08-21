package com.cr.ic.service;

import java.util.List;
import com.cr.ic.pojo.Tests;

public interface Tests_Service {
	public int add_Test(Tests tests);

	public int update_Test(Tests tests);

	public int delete_Test(int id);

	public List<Tests> queryTestByItemId(int item_id);

	public void deleteTestByItemIds(int item_ids[]);

	public List<Integer> queryTestIdsByItemIds(List<Integer> ids);

	public void add_Tests_List(List<Tests> tests_List);
}
