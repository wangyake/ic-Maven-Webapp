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
import com.cr.ic.pojo.Ic_Test;
import com.cr.ic.pojo.Ic_Test_Result;
import com.cr.ic.service.impl.Ic_Test_Result_ServiceImpl;
import com.cr.ic.service.impl.Ic_Test_ServiceImpl;

@Controller
@RequestMapping("/ic_test")
public class Ic_Test_Controller {
	@Resource
	private Ic_Test_ServiceImpl test_ServiceImpl;
	@Resource
	private Ic_Test_Result_ServiceImpl ic_Test_Result_ServiceImpl;
	
	//新建测试
	@RequestMapping("/addTest.do")
	@ResponseBody
	public Integer addTest(Ic_Test test) {
		this.test_ServiceImpl.add_Test(test);
		return test.getId();
	}
	
	//新建测试和结果
	@RequestMapping("/addTestAndResult.do")
	@ResponseBody
	public String addTestAndResult(Ic_Test ic_Test, HttpServletRequest req) {
		// 插入新增的调查条目
		this.test_ServiceImpl.add_Test(ic_Test);
		// 初始化对应调查结果并插入
		Integer audit_id = Integer.parseInt(req.getParameter("audit_id"));
		Ic_Test_Result ic_Test_Result = new Ic_Test_Result();
		ic_Test_Result.setAudit_id(audit_id);
		ic_Test_Result.setIc_test(ic_Test);
		ic_Test_Result.setTest_id(ic_Test.getId());
		ic_Test_Result.setTest_effect(" ");
		ic_Test_Result.setTest_risk(" ");
		ic_Test_Result.setTest_record(" ");
		this.ic_Test_Result_ServiceImpl.insertTestResult(ic_Test_Result);

		return JSON.toJSONString(ic_Test_Result);
	}

	//更新测试
	@RequestMapping("/updateTest.do")
	@ResponseBody
	public void updateTest(Ic_Test test) {
		this.test_ServiceImpl.update_Test(test);
	}

	//批量更新测试
	@RequestMapping("/updateTestList.do")
	@ResponseBody
	public void updateTestList(String list) {
		System.out
				.println("更新testtemplet更新testtemplet更新testtemplet更新testtemplet更新testtemplet更新testtemplet");
		JSONArray jsonArray = JSON.parseArray(list);
		JSONObject jsonObject = null;
		String test_target = null;
		String test_weakness = null;
		String test_method = null;

		List<Ic_Test> test_List = new ArrayList<Ic_Test>();
		for (int i = 0; i < jsonArray.size(); i++) {
			jsonObject = jsonArray.getJSONObject(i);
			test_target = (String) jsonObject.get("test_target");
			test_weakness = (String) jsonObject.get("test_weakness");
			test_method = (String) jsonObject.get("test_method");

			Ic_Test ic_Test = new Ic_Test();
			ic_Test.setId((Integer) jsonObject.getInteger("id"));
			if (test_method.equals("")) {
				ic_Test.setTest_method(" ");
			} else {
				ic_Test.setTest_method(test_method);
			}

			if (test_target.equals("")) {
				ic_Test.setTest_target(" ");
			} else {
				ic_Test.setTest_target(test_target);
			}

			if (test_weakness.equals("")) {
				ic_Test.setTest_weakness(" ");
			} else {
				ic_Test.setTest_weakness(test_weakness);
			}
			// System.out.println(result);
			test_List.add(ic_Test);
		}
		// 批量update invest_result的 invest_remark invest_result
		this.test_ServiceImpl.updateIcTestBatch(test_List);
	}
	
	//删除测试
	@RequestMapping("/deleteTest.do")
	@ResponseBody
	public void deleteTest(Integer id) {
		this.test_ServiceImpl.delete_Test(id);
	}

	//删除测试和结果
	@RequestMapping("/deleteTestAndResult.do")
	@ResponseBody
	public void deleteTestAndResult(Integer test_id) {
		this.ic_Test_Result_ServiceImpl.deleteTestResultByTestId(test_id);
		this.test_ServiceImpl.delete_Test(test_id);
	}

	//获得模板项下的所有测试
	@RequestMapping("/queryTestByItemId.do")
	@ResponseBody
	public List<Ic_Test> queryTestByItemIds(Integer item_id) {
		return this.test_ServiceImpl.queryTestByItemId(item_id);
	}
}
