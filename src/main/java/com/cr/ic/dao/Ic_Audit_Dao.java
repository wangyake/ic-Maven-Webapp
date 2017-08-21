package com.cr.ic.dao;

import java.util.List;

import com.cr.ic.pojo.Ic_Audit;

public interface Ic_Audit_Dao {
	//新建审计项目
	int insertAudit(Ic_Audit ic_audit);
	//获得用户的审计项目
	List<Ic_Audit> getAuditByUser(Integer create_id);
	//由审计项目名称关键词获得审计项目
	List<Ic_Audit> getAuditByName(String audit_name);
}
