package com.cr.ic.dao;

import java.util.List;
import com.cr.ic.pojo.Invest;

public interface Invest_Dao {
	//新建调查
	int insertInvest(Invest invest);
	//更新调查
	int modifyInvest(Invest invest);
	//删除调查
	int deleteInvest(int id);
	//由模板项获得其下的调查
	List<Invest> getInvestByItemId(int item_id);
	//由多个模板项删除其下的调查
	void deleteInvestByItemIds(int item_ids[]);
	//由多个模板项获得其下的调查
	List<Integer> getInvestIdsByItemIds(List<Integer> ids);
	//批量新建调查
	void insertInvestBatch(List<Invest> invest_List);
}
