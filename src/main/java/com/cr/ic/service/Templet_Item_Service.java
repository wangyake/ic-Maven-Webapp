package com.cr.ic.service;

import java.util.List;
import com.cr.ic.pojo.Templet_Item;

public interface Templet_Item_Service {
	public int add_Templet_Item(Templet_Item templet_item);

	public void deleteItemByItemIds(int item_ids[]);

	public List<Templet_Item> queryItemByTempletId(int templet_id);

	public void copyTemplet_Item(List<Templet_Item> templet_Item_List,
			Integer templet_id);

	public List<Templet_Item> getKids_Item_List(Integer id);
}
