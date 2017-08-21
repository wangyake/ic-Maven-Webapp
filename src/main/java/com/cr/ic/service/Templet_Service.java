package com.cr.ic.service;

import java.util.List;
import com.cr.ic.pojo.Templet;

public interface Templet_Service {
	public List<Templet> getAllTemplet();

	public List<Templet> queryTempletByName(String templet_keyword);

	public int insertTemplet(Templet templet);

	public void deleteTemplet(Integer id);

	public Templet queryTempletById(Integer id);
}
