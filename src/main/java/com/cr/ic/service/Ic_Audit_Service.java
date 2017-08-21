package com.cr.ic.service;

import java.util.List;

import com.cr.ic.pojo.Ic_Audit;

public interface Ic_Audit_Service {
	int createAudit(Ic_Audit ic_audit);

	List<Ic_Audit> queryAuditByUser(Integer create_id);

	List<Ic_Audit> queryAuditByName(String audit_name);
}
