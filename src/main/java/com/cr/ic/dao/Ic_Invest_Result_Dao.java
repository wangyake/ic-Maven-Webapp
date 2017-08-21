package com.cr.ic.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.cr.ic.pojo.Ic_Invest_Result;

public interface Ic_Invest_Result_Dao {
	//新建调查结果
	int insertInvestResult(Ic_Invest_Result invest_Result);
	//批量新建调查结果
	void insertInvestResultBatch(List<Ic_Invest_Result> list);
	//由审计项目id，审计模板项id获得内控调查和内容
	List<Ic_Invest_Result> getInvestAndResult(@Param("item_id") int item_id,
			@Param("audit_id") int audit_id);
	//批量更新调查结果
	void updateInvestResultBatch(List<Ic_Invest_Result> result);
	//批量删除调查结果
	void deleteInvestResultByInvestIds(List<Integer> invest_ids_list);
	//删除调查结果
	void deleteInvestResultByInvestId(Integer id);
}
