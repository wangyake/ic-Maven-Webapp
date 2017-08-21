package com.cr.ic.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.cr.ic.pojo.Ic_Audit;
import com.cr.ic.pojo.Ic_Invest_Result;
import com.cr.ic.pojo.Ic_Templet;
import com.cr.ic.pojo.Ic_Templet_Item;
import com.cr.ic.pojo.Ic_Test_Result;
import com.cr.ic.pojo.Templet;
import com.cr.ic.pojo.Templet_Item;
import com.cr.ic.service.impl.Ic_Audit_ServiceImpl;
import com.cr.ic.service.impl.Ic_Templet_Item_ServiceImpl;
import com.cr.ic.service.impl.Ic_Invest_Result_ServiceImpl;
import com.cr.ic.service.impl.Ic_Invest_ServiceImpl;
import com.cr.ic.service.impl.Ic_Templet_ServiceImpl;
import com.cr.ic.service.impl.Ic_Test_Result_ServiceImpl;
import com.cr.ic.service.impl.Ic_Test_ServiceImpl;
import com.cr.ic.service.impl.Invest_ServiceImpl;
import com.cr.ic.service.impl.Templet_Item_ServiceImpl;
import com.cr.ic.service.impl.Templet_ServiceImpl;
import com.cr.ic.service.impl.Tests_ServiceImpl;

@Controller
@RequestMapping("/ic_audit")
public class Ic_Audit_Controller {
	@Resource
	private Ic_Audit_ServiceImpl ic_Audit_ServiceImpl;
	@Resource
	private Ic_Templet_ServiceImpl ic_Templet_ServiceImpl;
	@Resource
	private Ic_Templet_Item_ServiceImpl ic_Templet_Item_ServceImpl;
	@Resource
	private Ic_Invest_ServiceImpl ic_Invest_ServiceImpl;
	@Resource
	private Ic_Invest_Result_ServiceImpl invest_Result_ServiceImpl;
	@Resource
	private Ic_Test_ServiceImpl ic_Test_ServiceImpl;
	@Resource
	private Ic_Test_Result_ServiceImpl test_Result_ServiceImpl;
	@Resource
	private Templet_ServiceImpl templet_ServiceImpl;
	@Resource
	private Templet_Item_ServiceImpl templet_Item_ServiceImpl;
	@Resource
	private Invest_ServiceImpl invest_ServiceImpl;
	@Resource
	private Tests_ServiceImpl tests_ServiceImpl;

	//新建审计项目
	@RequestMapping("/createAudit.do")
	@ResponseBody
	public String createAudit(HttpServletRequest req, Model model) {
		int templet_id = Integer.parseInt(req.getParameter("templet_id"));
		String audit_name = req.getParameter("audit_name");
		Integer create_id = Integer.valueOf(req.getParameter("create_id"));
		// 由templet_id获得templet
		Templet templet = this.templet_ServiceImpl.queryTempletById(templet_id);
		// 插入ic_Templet
		Ic_Templet ic_Templet = new Ic_Templet();
		ic_Templet.setCreate_date(templet.getCreate_date());
		ic_Templet.setCreate_name(templet.getCreate_name());
		ic_Templet.setTemplet_name(templet.getTemplet_name());
		this.ic_Templet_ServiceImpl.insertTemplet(ic_Templet);
		Integer ic_templet_id = ic_Templet.getId();

		// 由templet_id获得其下的item
		List<Templet_Item> templet_Item_List = this.templet_Item_ServiceImpl
				.queryItemByTempletId(templet_id);
		// 复制templet_item下所有节点到ic_templet_item
		this.templet_Item_ServiceImpl.copyTemplet_Item(templet_Item_List,
				ic_templet_id);
		
		Ic_Audit audit = new Ic_Audit();
		audit.setTemplet_id(ic_templet_id);
		audit.setAudit_date(new Date());
		audit.setAudit_name(audit_name);
		audit.setCreate_id(create_id);

		this.ic_Audit_ServiceImpl.createAudit(audit);
		
		//新建空的测试结果和调查结果
		List<Ic_Templet_Item> list = this.ic_Templet_Item_ServceImpl
				.queryItemByTempletId(ic_templet_id);
		List<Integer> ids = new ArrayList<Integer>();
		List<Ic_Invest_Result> invest_Result_List = new ArrayList<Ic_Invest_Result>();
		List<Ic_Test_Result> test_Result_List = new ArrayList<Ic_Test_Result>();

		if ((list != null) && (list.size() != 0)) {
			for (Ic_Templet_Item item : list) {
				ids.add(item.getId());
			}
			// 得到itemlist对应的所有invest的id
			List<Integer> investids = this.ic_Invest_ServiceImpl
					.queryInvestIdsByItemIds(ids);
			for (Integer id : investids) {
				Ic_Invest_Result invest_Result = new Ic_Invest_Result();
				// 新建所有invest的空记录 形如 id,audit_id,invest_id null null
				invest_Result.setAudit_id(audit.getId());
				invest_Result.setInvest_id(id);
				invest_Result.setInvest_remark(" ");
				invest_Result.setInvest_result(" ");
				invest_Result_List.add(invest_Result);
			}
			// 得到itemlist对应item其下所有的test的id
			List<Integer> testids = this.ic_Test_ServiceImpl
					.queryTestIdsByItemIds(ids);
			for (Integer id : testids) {
				Ic_Test_Result test_Result = new Ic_Test_Result();
				test_Result.setAudit_id(audit.getId());
				test_Result.setTest_id(id);
				test_Result.setTest_effect(" ");
				test_Result.setTest_record(" ");
				test_Result.setTest_risk(" ");
				test_Result_List.add(test_Result);
			}
			if (test_Result_List.size() != 0) {
				this.test_Result_ServiceImpl
						.insertTestResultBatch(test_Result_List);
			}
			if (invest_Result_List.size() != 0) {
				this.invest_Result_ServiceImpl
						.insertInvestResultBatch(invest_Result_List);
			}
		}
		//返回新建的审计项目id，作业模板id
		String param = "{\"audit_id\":\"" + audit.getId()
				+ "\",\"ic_templet_id\":\"" + ic_templet_id + "\"}";
		return param;
	}
	
	//获得审计作业需要的数据
	@RequestMapping("/audit.do")
	public String audit(HttpServletRequest req, Model model) {
		int ic_templet_id = Integer.parseInt(req.getParameter("ic_templet_id"));
		int audit_id = Integer.parseInt(req.getParameter("audit_id"));
		//获得作业模板名
		String ic_templet_name = this.ic_Templet_ServiceImpl
				.queryIcTempletById(ic_templet_id).getTemplet_name();
		//获得所有模板项（以备页面生成树）
		List<Ic_Templet_Item> list = this.ic_Templet_Item_ServceImpl
				.queryItemByTempletId(ic_templet_id);
		String item_list = JSON.toJSONString(list).replaceAll("item_name",
				"name");
		model.addAttribute("item_list", item_list);
		model.addAttribute("templet_id", ic_templet_id);
		model.addAttribute("templet_name", "\"" + ic_templet_name + "\"");
		model.addAttribute("audit_id", audit_id);
		return "/ic_audit/audit";
	}
	
	//查询所有的审计项目
	@RequestMapping("/queryAllAudit.do")
	public String queryAllAudit(HttpServletRequest req, Model model) {
		Integer create_id = Integer.parseInt(req.getParameter("create_id"));
		if (create_id == null) {
			return null;
		}
		List<Ic_Audit> list = this.ic_Audit_ServiceImpl
				.queryAuditByUser(create_id);
		model.addAttribute("audit_list", list);
		return "/ic_audit/list";
	}

	//由关键词查询审计项目
	@RequestMapping("/queryAuditByName.do")
	public String queryAuditByName(HttpServletRequest req, Model model) {
		String audit_keyword = req.getParameter("audit_keyword");
		req.setAttribute("audit_keyword", audit_keyword);
		List<Ic_Audit> ic_Audit_List = this.ic_Audit_ServiceImpl
				.queryAuditByName(audit_keyword);
		model.addAttribute("audit_list", ic_Audit_List);
		return "/ic_audit/list";
	}
}
