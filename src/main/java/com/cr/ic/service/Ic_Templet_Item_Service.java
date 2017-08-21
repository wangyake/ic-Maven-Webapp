package com.cr.ic.service;

import java.util.List;
import com.cr.ic.pojo.Ic_Templet_Item;

public interface Ic_Templet_Item_Service {
	public int add_Templet_Item(Ic_Templet_Item templet_item);

	public void deleteItemByItemIds(int item_ids[]);

	List<Ic_Templet_Item> queryItemByTempletId(int templet_id);

	public void copyIc_Templet_Item(List<Ic_Templet_Item> ic_Templet_Item_List,
			Integer templet_id);

	public List<Ic_Templet_Item> getKids_Item_List(Integer id);
}
