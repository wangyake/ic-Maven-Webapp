package com.cr.ic.controller;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.cr.ic.pojo.Invest;
import com.cr.ic.service.impl.Invest_ServiceImpl;

@Controller
@RequestMapping("/invest")
public class Invest_Controller {
	@Resource
	private Invest_ServiceImpl invest_ServiceImpl;
	
	//新建调查
	@RequestMapping("/addInvest.do")
	@ResponseBody
	public Integer addInvest(Invest invest){
		this.invest_ServiceImpl.add_Invest(invest);
		return invest.getId();
	}
	
	//更新调查
	@RequestMapping("/updateInvest.do")
	@ResponseBody
	public void updateInvest(Invest invest){
		this.invest_ServiceImpl.update_Invest(invest);
	}
	
	//删除调查
	@RequestMapping("/deleteInvest.do")
	@ResponseBody
	public void deleteInvest(Integer id){
		this.invest_ServiceImpl.delete_Invest(id);
	}
	
	//由模板项获得其下的调查
	@RequestMapping("/queryInvestByItemId.do")
	@ResponseBody
	public List<Invest> queryInvestByItemIds(Integer item_id){
		return this.invest_ServiceImpl.queryInvestByItemId(item_id);
	}
}
