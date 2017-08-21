package com.cr.ic.test;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.alibaba.fastjson.JSON;
import com.cr.ic.pojo.Ic_Templet;
import com.cr.ic.pojo.Templet;
import com.cr.ic.pojo.Templet_Item;
import com.cr.ic.service.impl.Ic_Templet_Item_ServiceImpl;
import com.cr.ic.service.impl.Ic_Templet_ServiceImpl;
import com.cr.ic.service.impl.Templet_Item_ServiceImpl;
import com.cr.ic.service.impl.Templet_ServiceImpl;

@RunWith(SpringJUnit4ClassRunner.class)		//表示继承了SpringJUnit4ClassRunner类
@ContextConfiguration(locations = {"classpath:spring-mybatis.xml"})
public class Test_ic {
	//private static Logger logger = Logger.getLogger(Test_ic.class);
//	private ApplicationContext ac = null;
	@Resource
	//private Invest_Dao dao ;
	private Templet_Item_ServiceImpl service1;
	@Resource
	private Ic_Templet_Item_ServiceImpl service2;
	@Resource
	private Templet_ServiceImpl templet_ServiceImpl;
	@Resource
	private Ic_Templet_ServiceImpl ic_Templet_ServiceImpl;

	@Test
	public void test1() {
		Templet templet=this.templet_ServiceImpl.queryTempletById(2);
		//插入ic_Templet
		Ic_Templet ic_Templet=new Ic_Templet();
			ic_Templet.setCreate_date(templet.getCreate_date());
			ic_Templet.setCreate_name(templet.getCreate_name());
			ic_Templet.setTemplet_name(templet.getTemplet_name());
		System.out.println(templet.getCreate_date());
		//System.out.println(ic_Templet.getCreate_date());
		this.ic_Templet_ServiceImpl.insertTemplet(ic_Templet);
//		List<Integer> ids=new ArrayList<Integer>();
//		ids.add(0);
		/*List<Templet_Item> templet_Item_List=
				this.service1.queryItemByTempletId(13);
		this.service1.copyTemplet_Item(templet_Item_List,105);*/
		
		/*Ic_Templet_Item item=new Ic_Templet_Item();
		item.setItem_name("11");
		item.setParent_id(0);
		item.setTemplet_id(104);
		
		this.service2.add_Templet_Item(item);
		System.out.println(item.getId());*/
		
		/*Map<String,Integer> param=new HashMap<String,Integer>();
		param.put("templet_id", 104);
		param.put("audit_id", 14);
		
		String json=JSON.toJSONString(param);
		System.out.println(json);*/
		//System.out.println(this.dao.getInvestAndResult(82));
	}
}


