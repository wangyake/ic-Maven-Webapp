package com.cr.ic.dao;

import java.util.List;
import com.cr.ic.pojo.Ic_Invest;

public interface Ic_Invest_Dao {
	//新建调查
	int insertInvest(Ic_Invest invest);
	//修改调查
	int modifyInvest(Ic_Invest invest);
	//删除调查
	int deleteInvest(int id);
	//获得模板项（ic_templet_item）下的调查
	List<Ic_Invest> getInvestByItemId(int item_id);
	//删除模板项数组下的调查
	void deleteInvestByItemIds(int item_ids[]);
	//获得模板项（ic_templet_item）list下的调查
	List<Integer> getInvestIdsByItemIds(List<Integer> ids);
	//批量新建内控调查
	void insertIc_InvestBatch(List<Ic_Invest> list);
	//批量更新内控调查
	void updateIcInvestBatch(List<Ic_Invest> list);
}
