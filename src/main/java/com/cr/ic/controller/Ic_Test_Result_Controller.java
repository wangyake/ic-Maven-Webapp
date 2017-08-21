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
import com.cr.ic.pojo.Ic_Test_Result;
import com.cr.ic.service.impl.Ic_Test_Result_ServiceImpl;

@Controller
@RequestMapping("/test_result")
public class Ic_Test_Result_Controller {
	@Resource
	private Ic_Test_Result_ServiceImpl result_Service;

	@RequestMapping("/queryTestAndResult.do")
	@ResponseBody
	public List<Ic_Test_Result> queryTestAndResult(HttpServletRequest req) {
		int item_id = Integer.parseInt(req.getParameter("item_id"));
		int audit_id = Integer.parseInt(req.getParameter("audit_id"));
		List<Ic_Test_Result> list = this.result_Service.queryTestAndResult(
				item_id, audit_id);
		return list;
	}

	@RequestMapping("/updateTestResult.do")
	@ResponseBody
	public void updateTestResult(String list) {
		System.out.println("更新test更新test更新test更新test更新test更新test更新test更新test");
		JSONArray jsonArray = JSON.parseArray(list);
		JSONObject jsonObject = null;
		String test_effect = null;
		String test_risk = null;
		String test_record = null;
		List<Ic_Test_Result> test_Result_List = new ArrayList<Ic_Test_Result>();
		for (int i = 0; i < jsonArray.size(); i++) {
			jsonObject = jsonArray.getJSONObject(i);
			Ic_Test_Result result = new Ic_Test_Result();
			result.setTrid((Integer) jsonObject.getInteger("id"));
			test_effect = (String) jsonObject.get("test_effect");
			test_risk = (String) jsonObject.get("test_risk");
			test_record = (String) jsonObject.get("test_record");
			if (test_record.equals("")) {
				result.setTest_record(" ");
			} else {
				result.setTest_record(test_record);
			}
			result.setTest_risk(test_risk);
			result.setTest_effect(test_effect);
			test_Result_List.add(result);
		}
		// 批量update invest_result的 invest_remark invest_result
		this.result_Service.updateTestResultBatch(test_Result_List);
	}
}
