package com.cr.ic.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.cr.ic.dao.Ic_Templet_Dao;
import com.cr.ic.pojo.Ic_Templet;
import com.cr.ic.service.Ic_Templet_Service;

@Service("Ic_Templet_Service")
public class Ic_Templet_ServiceImpl implements Ic_Templet_Service {
	@Resource
	private Ic_Templet_Dao ic_Templet_Dao;

	@Override
	public List<Ic_Templet> getAllTemplet() {
		return this.ic_Templet_Dao.queryAllTemplet();
	}

	@Override
	public List<Ic_Templet> queryTempletByName(String templet_keyword) {
		return this.ic_Templet_Dao.queryTempletByName(templet_keyword);
	}

	@Override
	public int insertTemplet(Ic_Templet templet) {
		return this.ic_Templet_Dao.addTemplet(templet);
	}

	@Override
	public void deleteTemplet(Integer id) {
		this.ic_Templet_Dao.deleteTemplet(id);
	}

	@Override
	public Ic_Templet queryIcTempletById(Integer id) {
		return this.ic_Templet_Dao.queryIcTempletById(id);
	}
}
