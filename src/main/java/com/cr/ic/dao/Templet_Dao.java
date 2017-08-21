package com.cr.ic.dao;

import java.util.List;
import com.cr.ic.pojo.Templet;

public interface Templet_Dao {
	//查询所有模板
	List<Templet> queryAllTemplet();
	//由模板名关键词获得模板
	List<Templet> queryTempletByName(String templet_keyword);
	//新建模板，返回模板id
	int addTemplet(Templet templet);
	//删除模板
	void deleteTemplet(Integer id);
	//查询模板
	Templet queryTempletById(Integer id);
}
