package com.cr.ic.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.cr.ic.dao.Ic_Audit_Dao;
import com.cr.ic.pojo.Ic_Audit;
import com.cr.ic.service.Ic_Audit_Service;

@Service("Audit_Service")
public class Ic_Audit_ServiceImpl implements Ic_Audit_Service {
	@Resource
	private Ic_Audit_Dao audit_Dao;

	@Override
	public int createAudit(Ic_Audit ic_audit) {
		return this.audit_Dao.insertAudit(ic_audit);
	}

	@Override
	public List<Ic_Audit> queryAuditByUser(Integer create_id) {
		return this.audit_Dao.getAuditByUser(create_id);
	}

	@Override
	public List<Ic_Audit> queryAuditByName(String audit_name) {
		return this.audit_Dao.getAuditByName(audit_name);
	}
}
