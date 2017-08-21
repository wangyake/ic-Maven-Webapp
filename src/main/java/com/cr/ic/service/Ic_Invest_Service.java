package com.cr.ic.service;

import java.util.List;
import com.cr.ic.pojo.Ic_Invest;

public interface Ic_Invest_Service {
	public int add_Invest(Ic_Invest invest);

	public int update_Invest(Ic_Invest invest);

	public int delete_Invest(int id);

	public List<Ic_Invest> queryInvestByItemId(int item_id);

	public void deleteInvestByItemIds(int item_ids[]);

	public List<Integer> queryInvestIdsByItemIds(List<Integer> ids);

	public void add_Ic_Invest_List(List<Ic_Invest> list);

	public void updateIcInvestBatch(List<Ic_Invest> list);
}
