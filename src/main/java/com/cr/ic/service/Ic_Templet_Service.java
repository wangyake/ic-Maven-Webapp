package com.cr.ic.service;

import java.util.List;

import com.cr.ic.pojo.Ic_Templet;

public interface Ic_Templet_Service {
	public List<Ic_Templet> getAllTemplet();

	public List<Ic_Templet> queryTempletByName(String templet_keyword);

	public int insertTemplet(Ic_Templet templet);

	public void deleteTemplet(Integer id);

	Ic_Templet queryIcTempletById(Integer id);
}
