package com.cr.ic.dao;

import java.util.List;
import com.cr.ic.pojo.Templet_Item;

public interface Templet_Item_Dao {
	//新建模板
	int addTemplet_Item(Templet_Item templet_item);
	//批量删除模板项
	void deleteItemByItemIds(int item_ids[]);
	//查询模板下的所有模板项
	List<Templet_Item> queryItemByTempletId(int templet_id);
	//获得子级模板项
	List<Templet_Item> getKidsItems(Integer id);
}
