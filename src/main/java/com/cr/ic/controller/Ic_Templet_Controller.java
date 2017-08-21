package com.cr.ic.controller;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cr.ic.pojo.Ic_Templet;
import com.cr.ic.pojo.Ic_Templet_Item;
import com.cr.ic.service.impl.Ic_Templet_Item_ServiceImpl;
import com.cr.ic.service.impl.Ic_Templet_ServiceImpl;
import com.cr.ic.service.impl.Ic_Invest_ServiceImpl;
import com.cr.ic.service.impl.Ic_Test_ServiceImpl;

@Controller
@RequestMapping("/ic_templet")
public class Ic_Templet_Controller {
	@Resource
	private Ic_Templet_ServiceImpl ic_Templet_ServceImpl;
	@Resource
	private Ic_Templet_Item_ServiceImpl ic_Templet_Item_ServiceImp;
	@Resource
	private Ic_Invest_ServiceImpl invest_ServceImpl;
	@Resource
	private Ic_Test_ServiceImpl test_ServceImpl;
	
	//查询所有模板
	@RequestMapping("/queryAllTemplet.do")
	public String toIndex(HttpServletRequest req, Model model,
			HttpSession session) {
		String templet = req.getParameter("templet");
		String create_id = req.getParameter("create_id");
		List<Ic_Templet> ic_Templet_List = this.ic_Templet_ServceImpl
				.getAllTemplet();
		model.addAttribute("ic_Templet_List", ic_Templet_List);
		model.addAttribute("create_id", create_id);
		if (templet.equals("true")) {
			return "/ic_templet/list_manage";
		} else {
			return "/ic_templet/list";
		}
	}

	//删除模板
	@RequestMapping("/deleteTemplet.do")
	@ResponseBody
	public void deleteTemplet(HttpServletRequest req, Model model) {
		int templet_id = Integer.parseInt(req.getParameter("templet_id"));
		// 由templet_id查所有ic_templet_item
		List<Ic_Templet_Item> item_list = this.ic_Templet_Item_ServiceImp
				.queryItemByTempletId(templet_id);
		if (item_list.size() == 0) {
			this.ic_Templet_ServceImpl.deleteTemplet(templet_id);
		} else {
			int[] ids = new int[item_list.size()];
			int i = 0;
			// 将id存入数组（dao内删除方法接受参数为数据，so）
			for (Ic_Templet_Item item : item_list) {
				ids[i] = item.getId();
				i++;
			}

			// 从最末级开删，invest和test
			// 根据templet_item的id删除test和invest
			this.invest_ServceImpl.deleteInvestByItemIds(ids);
			this.test_ServceImpl.deleteTestByItemIds(ids);
			// 根据templet_item的id删除item
			this.ic_Templet_Item_ServiceImp.deleteItemByItemIds(ids);
			// 最后删除ic_templet
			this.ic_Templet_ServceImpl.deleteTemplet(templet_id);
		}
	}

	//模板的模糊查询
	@RequestMapping("/queryTempletByName.do")
	public String getTempletByName(HttpServletRequest req, Model model) {
		String list = req.getParameter("list");
		String templet_keyword = req.getParameter("templet_keyword");
		req.setAttribute("templet_keyword", templet_keyword);
		List<Ic_Templet> ic_Templet_List = this.ic_Templet_ServceImpl
				.queryTempletByName(templet_keyword);
		model.addAttribute("ic_Templet_List", ic_Templet_List);
		if (list.equals("true")) {
			return "/ic_templet/list";
		} else {
			return "/ic_templet/list_manage";
		}
	}
	
	//新建模板
	@RequestMapping("/addTemplet.do")
	public String addTemplet(HttpServletRequest req, Model model) {
		Ic_Templet templet = new Ic_Templet();
		templet.setCreate_name("");
		templet.setTemplet_name(req.getParameter("templet_name"));
		templet.setCreate_date(new Date());
		this.ic_Templet_ServceImpl.insertTemplet(templet);
		System.out.println("templet_id=" + templet.getId());
		model.addAttribute("templet_id", templet.getId());
		return "/ic_templet/add";
	}
}
