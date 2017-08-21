package com.cr.ic.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.cr.ic.dao.Ic_User_Dao;
import com.cr.ic.pojo.Ic_User;
import com.cr.ic.service.Ic_User_Service;

@Service("User_Service")
public class Ic_User_ServiceImpl implements Ic_User_Service {
	@Resource
	private Ic_User_Dao dao;

	@Override
	public Ic_User login(Ic_User user) {
		return this.dao.login(user);
	}
}
