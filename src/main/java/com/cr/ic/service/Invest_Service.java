package com.cr.ic.service;

import java.util.List;
import com.cr.ic.pojo.Invest;

public interface Invest_Service {
	public int add_Invest(Invest invest);

	public int update_Invest(Invest invest);

	public int delete_Invest(int id);

	public List<Invest> queryInvestByItemId(int item_id);

	public void deleteInvestByItemIds(int item_ids[]);

	List<Integer> queryInvestIdsByItemIds(List<Integer> ids);

	void add_Invest_List(List<Invest> invest_List);
}
