package com.cr.ic.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.cr.ic.dao.Ic_Templet_Item_Dao;
import com.cr.ic.dao.Templet_Item_Dao;
import com.cr.ic.pojo.Ic_Invest;
import com.cr.ic.pojo.Ic_Templet_Item;
import com.cr.ic.pojo.Ic_Test;
import com.cr.ic.pojo.Invest;
import com.cr.ic.pojo.Templet_Item;
import com.cr.ic.pojo.Tests;
import com.cr.ic.service.Templet_Item_Service;

@Service("Templet_Item_Service")
public class Templet_Item_ServiceImpl implements Templet_Item_Service {
	@Resource
	private Templet_Item_Dao templet_item_Dao;
	@Resource
	private Ic_Templet_Item_Dao ic_templet_item_dao;
	@Resource
	private Invest_ServiceImpl invest_ServiceImpl;
	@Resource
	private Tests_ServiceImpl tests_ServiceImpl;
	@Resource
	private Ic_Invest_ServiceImpl ic_Invest_ServiceImpl;
	@Resource
	private Ic_Test_ServiceImpl ic_Test_ServiceImpl;

	@Override
	public int add_Templet_Item(Templet_Item templet_item) {
		return this.templet_item_Dao.addTemplet_Item(templet_item);
	}

	@Override
	public void deleteItemByItemIds(int item_ids[]) {
		this.templet_item_Dao.deleteItemByItemIds(item_ids);
	}

	@Override
	public List<Templet_Item> queryItemByTempletId(int templet_id) {
		return this.templet_item_Dao.queryItemByTempletId(templet_id);
	}

	/*
	 * 复制Templet_Item和其下的invest、tests到Ic_Templet_Item
	 */
	@Override
	public void copyTemplet_Item(List<Templet_Item> templet_Item_List,
			Integer templet_id) {
		for (Templet_Item templet_Item : templet_Item_List) {
			if (templet_Item.getParent_id() == 0) {// 如果是根
				copyTemplet_Item_Branch(templet_Item, 0, templet_id);
			}
		}
	}

	/**
	 * @param item
	 * @param parent_id
	 *            --->父级id
	 * @return
	 */
	public void copyTemplet_Item_Branch(Templet_Item templet_Item,
			Integer parent_id, Integer templet_id) {
		// 复制单个节点
		Integer id = insertIc_Templet_Item(templet_Item, parent_id, templet_id);
		// 复制test
		List<Tests> tests_List = this.tests_ServiceImpl
				.queryTestByItemId(templet_Item.getId());
		List<Ic_Test> ic_Test_List = new ArrayList<Ic_Test>();
		if ((tests_List.size() != 0) && (tests_List != null)) {
			for (Tests tests : tests_List) {
				Ic_Test ic_Test = new Ic_Test();
				ic_Test.setItem_id(id);
				ic_Test.setTest_method(tests.getTest_method());
				ic_Test.setTest_target(tests.getTest_target());
				ic_Test.setTest_weakness(tests.getTest_weakness());
				ic_Test_List.add(ic_Test);
			}
			this.ic_Test_ServiceImpl.add_Ic_Test_List(ic_Test_List);
		}

		// 复制invest
		List<Invest> invest_List = this.invest_ServiceImpl
				.queryInvestByItemId(templet_Item.getId());
		List<Ic_Invest> ic_invest_List = new ArrayList<Ic_Invest>();
		if ((invest_List.size() != 0) && (invest_List != null)) {
			for (Invest invest : invest_List) {
				Ic_Invest ic_Invest = new Ic_Invest();
				ic_Invest.setInvest_name(invest.getInvest_name());
				ic_Invest.setItem_id(id);
				ic_invest_List.add(ic_Invest);
			}
			this.ic_Invest_ServiceImpl.add_Ic_Invest_List(ic_invest_List);
		}

		// 得到子节点
		List<Templet_Item> kids_Item_List = this.getKids_Item_List(templet_Item
				.getId());
		if (kids_Item_List.size() != 0) {// 子节点非空
			for (Templet_Item item : kids_Item_List) {
				// 递归复制
				copyTemplet_Item_Branch(item, id, templet_id);
			}
		}
	}

	/**
	 * @param item
	 *            --->要复制的Templet_Item
	 * @param parent_id
	 *            --->父级id
	 * @return 插入Ic_Templet_Item的id
	 */
	public Integer insertIc_Templet_Item(Templet_Item item, Integer parent_id,
			Integer templet_id) {
		Ic_Templet_Item ic_Templet_Item = new Ic_Templet_Item();
		ic_Templet_Item.setItem_name(item.getItem_name());
		ic_Templet_Item.setParent_id(parent_id);
		ic_Templet_Item.setTemplet_id(templet_id);
		this.ic_templet_item_dao.addTemplet_Item(ic_Templet_Item);
		return ic_Templet_Item.getId();
	}

	@Override
	public List<Templet_Item> getKids_Item_List(Integer id) {
		return this.templet_item_Dao.getKidsItems(id);
	}
}
