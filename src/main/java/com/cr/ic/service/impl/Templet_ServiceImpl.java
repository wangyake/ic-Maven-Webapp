package com.cr.ic.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.cr.ic.dao.Templet_Dao;
import com.cr.ic.pojo.Templet;
import com.cr.ic.service.Templet_Service;

@Service("Templet_Service")
public class Templet_ServiceImpl implements Templet_Service {
	@Resource
	private Templet_Dao templet_Dao;

	@Override
	public List<Templet> getAllTemplet() {
		return this.templet_Dao.queryAllTemplet();
	}

	@Override
	public List<Templet> queryTempletByName(String templet_keyword) {
		return this.templet_Dao.queryTempletByName(templet_keyword);
	}

	@Override
	public int insertTemplet(Templet templet) {
		return this.templet_Dao.addTemplet(templet);
	}

	@Override
	public void deleteTemplet(Integer id) {
		this.templet_Dao.deleteTemplet(id);
	}

	@Override
	public Templet queryTempletById(Integer id) {
		return this.templet_Dao.queryTempletById(id);
	}
}
