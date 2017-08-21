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
import com.cr.ic.service.Ic_Templet_Item_Service;

@Service("Ic_Templet_Item_Service")
public class Ic_Templet_Item_ServiceImpl implements Ic_Templet_Item_Service {
	@Resource
	private Ic_Templet_Item_Dao ic_templet_item_Dao;
	@Resource
	private Templet_Item_Dao templet_Item_Dao;
	@Resource
	private Ic_Test_ServiceImpl ic_Test_ServiceImpl;
	@Resource
	private Tests_ServiceImpl tests_ServiceImpl;
	@Resource
	private Ic_Invest_ServiceImpl ic_Invest_ServiceImpl;
	@Resource
	private Invest_ServiceImpl invest_ServiceImpl;

	@Override
	public int add_Templet_Item(Ic_Templet_Item templet_item) {
		return this.ic_templet_item_Dao.addTemplet_Item(templet_item);
	}

	@Override
	public void deleteItemByItemIds(int item_ids[]) {
		this.ic_templet_item_Dao.deleteItemByItemIds(item_ids);
	}

	@Override
	public List<Ic_Templet_Item> queryItemByTempletId(int templet_id) {
		return this.ic_templet_item_Dao.queryItemByTempletId(templet_id);
	}

	/*
	 * 复制Templet_Item和其下的invest、tests到Ic_Templet_Item
	 */
	@Override
	public void copyIc_Templet_Item(List<Ic_Templet_Item> ic_Templet_Item_List,
			Integer templet_id) {
		for (Ic_Templet_Item ic_Templet_Item : ic_Templet_Item_List) {
			if (ic_Templet_Item.getParent_id() == 0) {// 如果是根
				copyIc_Templet_Item_Branch(ic_Templet_Item, 0, templet_id);
			}
		}
	}

	/**
	 * @param item
	 * @param parent_id
	 *            --->父级id
	 * @return
	 */
	public void copyIc_Templet_Item_Branch(Ic_Templet_Item ic_Templet_Item,
			Integer parent_id, Integer templet_id) {
		// 复制单个节点
		Integer id = insertTemplet_Item(ic_Templet_Item, parent_id, templet_id);
		// 复制test
		List<Ic_Test> ic_Test_List = this.ic_Test_ServiceImpl
				.queryTestByItemId(ic_Templet_Item.getId());
		List<Tests> tests_List = new ArrayList<Tests>();
		if ((ic_Test_List.size() != 0) && (ic_Test_List != null)) {
			for (Ic_Test ic_Test : ic_Test_List) {
				Tests tests = new Tests();
				tests.setItem_id(id);
				tests.setTest_method(ic_Test.getTest_method());
				tests.setTest_target(ic_Test.getTest_target());
				tests.setTest_weakness(ic_Test.getTest_weakness());
				tests_List.add(tests);
			}
			this.tests_ServiceImpl.add_Tests_List(tests_List);
		}

		// 复制invest
		List<Ic_Invest> ic_Invest_List = this.ic_Invest_ServiceImpl
				.queryInvestByItemId(ic_Templet_Item.getId());
		List<Invest> invest_List = new ArrayList<Invest>();
		if ((ic_Invest_List.size() != 0) && (ic_Invest_List != null)) {
			for (Ic_Invest ic_Invest : ic_Invest_List) {
				Invest invest = new Invest();
				invest.setInvest_name(ic_Invest.getInvest_name());
				invest.setItem_id(id);
				invest_List.add(invest);
			}
			this.invest_ServiceImpl.add_Invest_List(invest_List);
		}

		// 得到子节点
		List<Ic_Templet_Item> kids_Ic_Item_List = this
				.getKids_Item_List(ic_Templet_Item.getId());
		if (kids_Ic_Item_List.size() != 0) {// 子节点非空
			for (Ic_Templet_Item ic_Item : kids_Ic_Item_List) {
				// 递归复制
				copyIc_Templet_Item_Branch(ic_Item, id, templet_id);
			}
		}
	}

	/**
	 * @param item
	 *            --->要复制的Ic_Templet_Item
	 * @param parent_id
	 *            --->父级id
	 * @return 插入Templet_Item的id
	 */
	public Integer insertTemplet_Item(Ic_Templet_Item item, Integer parent_id,
			Integer templet_id) {
		Templet_Item templet_Item = new Templet_Item();
		templet_Item.setItem_name(item.getItem_name());
		templet_Item.setParent_id(parent_id);
		templet_Item.setTemplet_id(templet_id);
		this.templet_Item_Dao.addTemplet_Item(templet_Item);
		return templet_Item.getId();
	}

	@Override
	public List<Ic_Templet_Item> getKids_Item_List(Integer id) {
		return this.ic_templet_item_Dao.getKidsItems(id);
	}
}
