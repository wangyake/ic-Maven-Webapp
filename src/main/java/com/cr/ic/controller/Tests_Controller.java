package com.cr.ic.controller;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.cr.ic.pojo.Tests;
import com.cr.ic.service.impl.Tests_ServiceImpl;

@Controller
@RequestMapping("/tests")
public class Tests_Controller {
	@Resource
	private Tests_ServiceImpl tests_ServiceImpl;
	
	@RequestMapping("/addTest.do")
	@ResponseBody
	public Integer addTest(Tests tests) {
		this.tests_ServiceImpl.add_Test(tests);
		return tests.getId();
	}

	@RequestMapping("/updateTest.do")
	@ResponseBody
	public void updateTest(Tests tests) {
		this.tests_ServiceImpl.update_Test(tests);
	}

	@RequestMapping("/deleteTest.do")
	@ResponseBody
	public void deleteTest(Integer id) {
		this.tests_ServiceImpl.delete_Test(id);
	}

	//获得模板项下的所有测试
	@RequestMapping("/queryTestByItemId.do")
	@ResponseBody
	public List<Tests> queryTestByItemIds(Integer item_id) {
		return this.tests_ServiceImpl.queryTestByItemId(item_id);
	}
}
