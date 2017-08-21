package com.cr.ic.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.cr.ic.pojo.Ic_Templet_Item;
import com.cr.ic.service.impl.Ic_Invest_Result_ServiceImpl;
import com.cr.ic.service.impl.Ic_Templet_Item_ServiceImpl;
import com.cr.ic.service.impl.Ic_Invest_ServiceImpl;
import com.cr.ic.service.impl.Ic_Test_Result_ServiceImpl;
import com.cr.ic.service.impl.Ic_Test_ServiceImpl;

@Controller
@RequestMapping("/ic_templet_item")
public class Ic_Templet_Item_Controller {
	@Resource
	private Ic_Templet_Item_ServiceImpl ic_Templet_Item_ServceImpl;
	@Resource
	private Ic_Invest_ServiceImpl ic_invest_ServceImpl;
	@Resource
	private Ic_Test_ServiceImpl ic_test_ServceImpl;
	@Resource
	private Ic_Invest_Result_ServiceImpl ic_invest_result_ServiceImpl;
	@Resource
	private Ic_Test_Result_ServiceImpl ic_test_result_ServiceImpl;
	
	//新建模板项
	@RequestMapping("/addTemplet_Item.do")
	@ResponseBody
	public Integer addTemplet_Item(Ic_Templet_Item templet_item){
		this.ic_Templet_Item_ServceImpl.add_Templet_Item(templet_item);
		return templet_item.getId();
	}
	
	//级联删除模板项
	@RequestMapping("/deleteItemCascade.do")
	@ResponseBody
	public void deleteItemCascade(int item_ids[]){
		List<Integer> item_ids_list=new ArrayList<Integer>();
		for(int i=0;i<item_ids.length;i++){
			item_ids_list.add(item_ids[i]);
		}
		
		//根据templet_item的id获得所有invest和test的id
		List<Integer> invest_ids_list=this.ic_invest_ServceImpl.queryInvestIdsByItemIds(item_ids_list);
		List<Integer> test_ids_list=this.ic_test_ServceImpl.queryTestIdsByItemIds(item_ids_list);
		//由invest和test的id删除ic_invest_result和ic_test_result
		if(invest_ids_list.size()!=0){
			this.ic_invest_result_ServiceImpl.deleteInvestResultByInvestIds(invest_ids_list);
		}
		if(test_ids_list.size()!=0){
			this.ic_test_result_ServiceImpl.deleteTestResultByTestIds(test_ids_list);
		}
		
		//根据templet_item的id删除test和invest
		this.ic_invest_ServceImpl.deleteInvestByItemIds(item_ids);
		this.ic_test_ServceImpl.deleteTestByItemIds(item_ids);
		//根据templet_item的id删除item
		this.ic_Templet_Item_ServceImpl.deleteItemByItemIds(item_ids);
	}
	
	//查询模板下的所有模板项
	@RequestMapping("/queryItemByTempletId.do")
	public String toIndex(HttpServletRequest req,Model model){
		int templet_id=Integer.parseInt(req.getParameter("templet_id"));
		List<Ic_Templet_Item> list=this.ic_Templet_Item_ServceImpl.queryItemByTempletId(templet_id);
		if(list==null){
			model.addAttribute("item_list","[]");
		}else{
			String item_list=JSON.toJSONString(list).replaceAll("item_name", "name");
			//System.out.println(item_list);
			model.addAttribute("item_list",item_list);
			model.addAttribute("templet_id",templet_id);
		}
		return "/ic_templet/add";
	}
}

