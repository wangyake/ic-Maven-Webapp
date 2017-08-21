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
import com.cr.ic.pojo.Ic_Invest;
import com.cr.ic.pojo.Ic_Invest_Result;
import com.cr.ic.service.impl.Ic_Invest_Result_ServiceImpl;
import com.cr.ic.service.impl.Ic_Invest_ServiceImpl;

@Controller
@RequestMapping("/ic_invest")
public class Ic_Invest_Controller {
	@Resource
	private Ic_Invest_ServiceImpl invest_ServiceImpl;
	@Resource
	private Ic_Invest_Result_ServiceImpl ic_Invest_Result_ServiceImpl;
	
	//新建调查和结果
	@RequestMapping("/addInvestAndResult.do")
	@ResponseBody
	public String addInvestAndResult(Ic_Invest ic_Invest,HttpServletRequest req){
		//插入新增的调查条目
		this.invest_ServiceImpl.add_Invest(ic_Invest);
		//初始化对应调查结果并插入
		Integer audit_id=Integer.parseInt(req.getParameter("audit_id"));
		Ic_Invest_Result ic_Invest_Result=new Ic_Invest_Result();
		ic_Invest_Result.setAudit_id(audit_id);
		ic_Invest_Result.setIc_invest(ic_Invest);
		ic_Invest_Result.setInvest_id(ic_Invest.getId());
		ic_Invest_Result.setInvest_remark(" ");
		ic_Invest_Result.setInvest_result(" ");
		this.ic_Invest_Result_ServiceImpl.insertInvestResult(ic_Invest_Result);
		
		return JSON.toJSONString(ic_Invest_Result);
	}
	
	//更新调查
	@RequestMapping("/updateInvest.do")
	@ResponseBody
	public void updateInvest(Ic_Invest invest){
		this.invest_ServiceImpl.update_Invest(invest);
	}
	
	//批量更新调查
	@RequestMapping("/updateInvestList.do")
	@ResponseBody
	public void updateInvestList(String list){
		System.out.println("更新investtemplet更新investtemplet更新investtemplet更新investtemplet更新investtemplet更新investtemplet");
		JSONArray jsonArray=JSON.parseArray(list);
		JSONObject jsonObject=null;
		String invest_name=null;
		List<Ic_Invest> invest_List=new ArrayList<Ic_Invest>();
		for(int i=0;i<jsonArray.size();i++){
			jsonObject=jsonArray.getJSONObject(i);
			Ic_Invest ic_Invest=new Ic_Invest();
			ic_Invest.setId((Integer)jsonObject.getInteger("id"));
			invest_name=(String)jsonObject.get("invest_name");
			if(invest_name.equals("")){
				ic_Invest.setInvest_name(" ");
			}else{
				ic_Invest.setInvest_name(invest_name);
			}
			//System.out.println(result);
			invest_List.add(ic_Invest);
		}
		//批量update invest_result的 invest_remark   invest_result
		this.invest_ServiceImpl.updateIcInvestBatch(invest_List);
	}

	//删除调查
	@RequestMapping("/deleteInvest.do")
	@ResponseBody
	public void deleteInvest(Integer id){
		this.invest_ServiceImpl.delete_Invest(id);
	}
	
	//删除调查和对应的调查结果
	@RequestMapping("/deleteInvestAndResult.do")
	@ResponseBody
	public void deleteInvestAndResult(Integer invest_id){
		this.ic_Invest_Result_ServiceImpl.deleteInvestResultByInvestId(invest_id);
		this.invest_ServiceImpl.delete_Invest(invest_id);
	}
	
	//查询模板项下的调查
	@RequestMapping("/queryInvestByItemId.do")
	@ResponseBody
	public List<Ic_Invest> queryInvestByItemIds(Integer item_id){
		return this.invest_ServiceImpl.queryInvestByItemId(item_id);
	}
}
