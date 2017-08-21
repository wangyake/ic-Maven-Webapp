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
import com.cr.ic.pojo.Templet;
import com.cr.ic.pojo.Templet_Item;
import com.cr.ic.service.impl.Ic_Templet_Item_ServiceImpl;
import com.cr.ic.service.impl.Ic_Templet_ServiceImpl;
import com.cr.ic.service.impl.Invest_ServiceImpl;
import com.cr.ic.service.impl.Templet_Item_ServiceImpl;
import com.cr.ic.service.impl.Templet_ServiceImpl;
import com.cr.ic.service.impl.Tests_ServiceImpl;

@Controller
@RequestMapping("/templet")
public class Templet_Controller {
	@Resource
	private Templet_ServiceImpl templet_ServiceImpl;
	@Resource
	private Ic_Templet_ServiceImpl ic_Templet_ServiceImpl;
	@Resource
	private Templet_Item_ServiceImpl templet_Item_ServiceImp;
	@Resource
	private Ic_Templet_Item_ServiceImpl ic_Templet_Item_ServiceImpl;
	@Resource
	private Invest_ServiceImpl invest_ServceImpl;
	@Resource
	private Tests_ServiceImpl tests_ServceImpl;

	
	@RequestMapping("/queryAllTemplet.do")
	public String toIndex(HttpServletRequest req, Model model,
			HttpSession session) {
		String templet = req.getParameter("templet");
		String create_id = req.getParameter("create_id");
		List<Templet> templet_List = this.templet_ServiceImpl.getAllTemplet();
		model.addAttribute("Templet_List", templet_List);
		model.addAttribute("create_id", create_id);
		if (templet.equals("true")) {
			return "/ic_templet/list_manage";
		} else {
			return "/ic_templet/list";
		}
	}

	//新建项目时，复制正式模板到作业模板
	@RequestMapping("/copyIctempletToTemplet.do")
	@ResponseBody
	public void copyIctempletToTemplet(HttpServletRequest req, Model model) {
		int ic_templet_id = Integer.parseInt(req.getParameter("templet_id"));
		String templet_name = req.getParameter("templet_name");
		// 取得保存模板的人员id，这里templet的表结构中还是存的create_name.需改成create_id
		// HttpSession session=req.getSession(true);
		// String create_id=(String)session.getAttribute("userid");
		// 由templet_id获得ic_templet
		Ic_Templet ic_Templet = this.ic_Templet_ServiceImpl
				.queryIcTempletById(ic_templet_id);

		// 插入Templet
		Templet templet = new Templet();
		templet.setCreate_date(new Date());
		// 建templet人员的记录需要修改
		templet.setCreate_name(ic_Templet.getCreate_name());
		templet.setTemplet_name(templet_name);
		this.templet_ServiceImpl.insertTemplet(templet);

		Integer templet_id = templet.getId();
		// String ic_templet_name=templet.getTemplet_name();
		// 由ic_templet_id获得其下的item
		List<Ic_Templet_Item> ic_Templet_Item_List = this.ic_Templet_Item_ServiceImpl
				.queryItemByTempletId(ic_templet_id);
		// 复制ic_templet_item下所有节点到templet_item
		this.ic_Templet_Item_ServiceImpl.copyIc_Templet_Item(
				ic_Templet_Item_List, templet_id);

	}

	//删除模板
	@RequestMapping("/deleteTemplet.do")
	@ResponseBody
	public void deleteTemplet(HttpServletRequest req, Model model) {
		int templet_id = Integer.parseInt(req.getParameter("templet_id"));
		// 由templet_id查所有ic_templet_item
		List<Templet_Item> item_list = this.templet_Item_ServiceImp
				.queryItemByTempletId(templet_id);
		if (item_list.size() == 0) {
			this.templet_ServiceImpl.deleteTemplet(templet_id);
		} else {
			int[] ids = new int[item_list.size()];
			int i = 0;
			// 将id存入数组（dao内删除方法接受参数为数据，so）
			for (Templet_Item item : item_list) {
				ids[i] = item.getId();
				i++;
			}

			// 从最末级开删，invest和test
			// 根据templet_item的id删除test和invest
			this.invest_ServceImpl.deleteInvestByItemIds(ids);
			this.tests_ServceImpl.deleteTestByItemIds(ids);
			// 根据templet_item的id删除item
			this.templet_Item_ServiceImp.deleteItemByItemIds(ids);
			// 最后删除ic_templet
			this.templet_ServiceImpl.deleteTemplet(templet_id);
		}
	}

	//模糊查询模板
	@RequestMapping("/queryTempletByName.do")
	public String getTempletByName(HttpServletRequest req, Model model) {
		String list = req.getParameter("list");
		String templet_keyword = req.getParameter("templet_keyword");
		req.setAttribute("templet_keyword", templet_keyword);
		List<Templet> templet_List = this.templet_ServiceImpl
				.queryTempletByName(templet_keyword);
		model.addAttribute("Templet_List", templet_List);
		if (list.equals("true")) {
			return "/ic_templet/list";
		} else {
			return "/ic_templet/list_manage";
		}
	}

	@RequestMapping("/addTemplet.do")
	public String addTemplet(HttpServletRequest req, Model model) {
		Templet templet = new Templet();
		templet.setCreate_name("");
		templet.setTemplet_name(req.getParameter("templet_name"));
		templet.setCreate_date(new Date());
		this.templet_ServiceImpl.insertTemplet(templet);
		System.out.println("templet_id=" + templet.getId());
		model.addAttribute("templet_id", templet.getId());
		return "/ic_templet/add";
	}
}
