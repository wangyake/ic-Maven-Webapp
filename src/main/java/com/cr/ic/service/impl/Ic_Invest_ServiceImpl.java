package com.cr.ic.service.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.cr.ic.dao.Ic_Invest_Dao;
import com.cr.ic.pojo.Ic_Invest;
import com.cr.ic.service.Ic_Invest_Service;

@Service("Ic_Invest_Service")
public class Ic_Invest_ServiceImpl implements Ic_Invest_Service {
	@Resource
	private Ic_Invest_Dao ic_Invest_Dao;

	@Override
	public int add_Invest(Ic_Invest invest) {
		return this.ic_Invest_Dao.insertInvest(invest);
	}

	@Override
	public int update_Invest(Ic_Invest invest) {
		return this.ic_Invest_Dao.modifyInvest(invest);
	}

	@Override
	public int delete_Invest(int id) {
		return this.ic_Invest_Dao.deleteInvest(id);
	}

	@Override
	public List<Ic_Invest> queryInvestByItemId(int item_id) {
		return this.ic_Invest_Dao.getInvestByItemId(item_id);
	}

	@Override
	public void deleteInvestByItemIds(int item_ids[]) {
		this.ic_Invest_Dao.deleteInvestByItemIds(item_ids);
	}

	@Override
	public List<Integer> queryInvestIdsByItemIds(List<Integer> ids) {
		return this.ic_Invest_Dao.getInvestIdsByItemIds(ids);
	}

	@Override
	public void add_Ic_Invest_List(List<Ic_Invest> list) {
		this.ic_Invest_Dao.insertIc_InvestBatch(list);
	}

	@Override
	public void updateIcInvestBatch(List<Ic_Invest> list) {
		this.ic_Invest_Dao.updateIcInvestBatch(list);
	}
}
