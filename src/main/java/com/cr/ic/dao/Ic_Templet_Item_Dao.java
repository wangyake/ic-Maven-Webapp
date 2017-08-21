package com.cr.ic.dao;

import java.util.List;
import com.cr.ic.pojo.Ic_Templet_Item;

public interface Ic_Templet_Item_Dao {
	//新建模板项
	int addTemplet_Item(Ic_Templet_Item ic_templet_item);
	//批量删除模板项
	void deleteItemByItemIds(int item_ids[]);
	//由模板id获得其下的模板项
	List<Ic_Templet_Item> queryItemByTempletId(int templet_id);
	//获得子级模板项
	List<Ic_Templet_Item> getKidsItems(Integer id);
}
