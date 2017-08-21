package com.cr.ic.controller;

import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.alibaba.fastjson.JSON;
import com.cr.ic.pojo.Templet_Item;
import com.cr.ic.service.impl.Invest_ServiceImpl;
import com.cr.ic.service.impl.Templet_Item_ServiceImpl;
import com.cr.ic.service.impl.Tests_ServiceImpl;

@Controller
@RequestMapping("/templet_item")
public class Templet_Item_Controller {
	@Resource
	private Templet_Item_ServiceImpl templet_Item_ServceImpl;
	@Resource
	private Invest_ServiceImpl invest_ServceImpl;
	@Resource
	private Tests_ServiceImpl tests_ServceImpl;

	@RequestMapping("/addTemplet_Item.do")
	@ResponseBody
	public Integer addTemplet_Item(Templet_Item templet_item) {
		this.templet_Item_ServceImpl.add_Templet_Item(templet_item);
		return templet_item.getId();
	}

	//级联删除模板项
	@RequestMapping("/deleteItemCascade.do")
	@ResponseBody
	public void deleteItemCascade(int item_ids[]) {
		// 根据templet_item的id删除test和invest
		this.invest_ServceImpl.deleteInvestByItemIds(item_ids);
		this.tests_ServceImpl.deleteTestByItemIds(item_ids);
		// 根据templet_item的id删除item
		this.templet_Item_ServceImpl.deleteItemByItemIds(item_ids);
	}

	//获得模板下的所有模板项
	@RequestMapping("/queryItemByTempletId.do")
	public String toIndex(HttpServletRequest req, Model model) {
		int templet_id = Integer.parseInt(req.getParameter("templet_id"));
		List<Templet_Item> list = this.templet_Item_ServceImpl
				.queryItemByTempletId(templet_id);
		if (list == null) {
			model.addAttribute("item_list", "[]");
		} else {
			String item_list = JSON.toJSONString(list).replaceAll("item_name",
					"name");
			// System.out.println(item_list);
			model.addAttribute("item_list", item_list);
			model.addAttribute("templet_id", templet_id);
		}
		return "/ic_templet/add";
	}
}
