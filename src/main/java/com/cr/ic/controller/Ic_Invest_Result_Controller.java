package com.cr.ic.controller;

import java.util.ArrayList;
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.cr.ic.pojo.Ic_Invest_Result;
import com.cr.ic.service.impl.Ic_Invest_Result_ServiceImpl;

@Controller
@RequestMapping("/invest_result")
public class Ic_Invest_Result_Controller {
	@Resource
	private Ic_Invest_Result_ServiceImpl result_Service;

	//查询调查和对应的结果
	@RequestMapping("/queryInvestAndResult.do")
	@ResponseBody
	public List<Ic_Invest_Result> queryInvestAndResult(HttpServletRequest req) {
		int item_id = Integer.parseInt(req.getParameter("item_id"));
		int audit_id = Integer.parseInt(req.getParameter("audit_id"));
		List<Ic_Invest_Result> list = this.result_Service.queryInvestAndResult(
				item_id, audit_id);
		return list;
	}

	//更新调查和对应的结果
	@RequestMapping("/updateInvestResult.do")
	@ResponseBody
	public void updateInvestResult(String list) {
		System.out.println("更新invest更新invest更新invest更新invest更新invest更新invest");
		JSONArray jsonArray = JSON.parseArray(list);
		JSONObject jsonObject = null;
		String invest_remark = null;
		String invest_result = null;
		List<Ic_Invest_Result> invest_Result_List = new ArrayList<Ic_Invest_Result>();
		for (int i = 0; i < jsonArray.size(); i++) {
			jsonObject = jsonArray.getJSONObject(i);
			Ic_Invest_Result result = new Ic_Invest_Result();
			result.setIrid((Integer) jsonObject.getInteger("id"));
			invest_remark = (String) jsonObject.get("invest_remark");
			invest_result = (String) jsonObject.get("invest_result");
			if (invest_remark.equals("")) {
				result.setInvest_remark(" ");
			} else {
				result.setInvest_remark(invest_remark);
			}
			result.setInvest_result(invest_result);
			invest_Result_List.add(result);
		}
		// 批量update invest_result的 invest_remark invest_result
		this.result_Service.updateInvestResultBatch(invest_Result_List);
	}
}
