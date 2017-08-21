package com.cr.ic.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.cr.ic.dao.Invest_Dao;
import com.cr.ic.pojo.Invest;
import com.cr.ic.service.Invest_Service;

@Service("Invest_Service")
public class Invest_ServiceImpl implements Invest_Service {
	@Resource
	private Invest_Dao invest_Dao;

	@Override
	public int add_Invest(Invest invest) {
		return this.invest_Dao.insertInvest(invest);
	}

	@Override
	public int update_Invest(Invest invest) {
		return this.invest_Dao.modifyInvest(invest);
	}

	@Override
	public int delete_Invest(int id) {
		return this.invest_Dao.deleteInvest(id);
	}

	@Override
	public List<Invest> queryInvestByItemId(int item_id) {
		return this.invest_Dao.getInvestByItemId(item_id);
	}

	@Override
	public void deleteInvestByItemIds(int item_ids[]) {
		this.invest_Dao.deleteInvestByItemIds(item_ids);
	}

	@Override
	public List<Integer> queryInvestIdsByItemIds(List<Integer> ids) {
		return this.invest_Dao.getInvestIdsByItemIds(ids);
	}

	@Override
	public void add_Invest_List(List<Invest> invest_List) {
		this.invest_Dao.insertInvestBatch(invest_List);
	}
}
