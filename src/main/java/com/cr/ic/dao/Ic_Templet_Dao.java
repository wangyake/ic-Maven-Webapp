package com.cr.ic.dao;

import java.util.List;
import com.cr.ic.pojo.Ic_Templet;

public interface Ic_Templet_Dao {
	//查询所有内控模板
	List<Ic_Templet> queryAllTemplet();
	//由模板名关键字查询模板
	List<Ic_Templet> queryTempletByName(String templet_keyword);
	//插入模板
	int addTemplet(Ic_Templet ic_templet);
	//删除模板
	void deleteTemplet(Integer id);
	//查询内控模板
	Ic_Templet queryIcTempletById(Integer id);
}
