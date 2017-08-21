<%@ page language="java" import="java.util.*" pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+"/ic/";
%>
<!-- 内控项目列表页面 -->
<html xmlns="http://www.w3.org/1999/xhtml">
   <head> 
    <meta http-equiv="Content_Type" content="text/html;charset=UTF-8"/>
    <title>模板列表</title>
    <script type="text/javascript" src="../script/jquery.js"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main.css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/libs/modernizr.min.js"></script>
	<script type="text/javascript">
		//选中某一条项目变色	
		function setLineNum(line){
			var audit_id=line.id;
			var $templet_id=$("#templet_id");
			var $audit_id=$("#audit_id");
			var $audit_name=$("#audit_name");
			//得到选中项目的项目id和模板id
			$audit_id.attr("value",audit_id);
			$templet_id.attr("value",$(line).children("td").eq(0).find("input").val());
			$audit_name.attr("value",$(line).children("td").eq(2).html());
			
			$(line).css("background","#B0C4DE");
			var trs=$("#tbody").children("tr");
			for(var i=0;i<trs.length;i++){
				if(trs[i]!=line){//这里使用find需要dom对象，$转化之
					if($(trs[i]).find('td').eq(1).html()%2!=0){
						trs[i].style.background="";
					}else{
						trs[i].style.background="#f5f5f5";
					}
				}
			}
		}
		
		//编辑项目按钮
		$("#editAudit").live("click",function(){
			var audit_id=$("#audit_id").val();
			var templet_id=$("#templet_id").val();
			var audit_name=$("#audit_name").val();
			if(!audit_id){
				return;
			}else{
				result="/ic/ic_audit/audit.do?ic_templet_id="+templet_id+"&audit_id="+audit_id
					+"&audit_name="+audit_name;
				window.open(result,"_blank");
			}
		});
	</script>
	
</head>
	<body>
 		<div class="search-wrap">
	       <form action="${pageContext.request.contextPath}/ic_audit/queryAuditByName.do" method="post">
	           <table class="search-tab">
	           	<tr>
	           		<th width="70">关键字:</th>
	                   <td><input class="common-text" placeholder="项目名" name="audit_keyword"  value="${audit_keyword}" id="" type="text"></input></td>
	                   <td><input class="btn btn-primary btn2" name="sub" value="查询" type="submit" ></input></td>
	                   <td width="90px"></td>
	           		<td><input id="editAudit" class="btn btn-primary btn2" name="sub" value="编辑项目" type="button"  onclick=""></input></td>
	           	</tr>
	           </table>
	       </form>
   	    </div>
   	    
        <div id="hidden" align="center" style="display:none">
	        <form>
	        	<table>
	        		<tr>
	        			<td><input id='audit_id' value=''/></td>
	        			<td><input id='templet_id' value=''/></td>
	        			<td><input id='audit_name' value=''/></td>
	        		</tr>
	        	</table>
	        </form>
        </div>
        
    	<div>
			<form id="listForm" action="" method="get">
				<table width="100%" style="overflow:scroll;">
					<thead>
						<tr style='background-color:#e5e5e5;#'>
		               		<th align="center">序号</th>
		               		<th align="center">项目名称</th>
		               		<th align="center">建立日期</th>
		           		</tr>
					</thead>
				  <tbody id='tbody'>
			  		<c:forEach items="${audit_list}" var="ic_audit" varStatus="status" >
			  			<tr id="${ic_audit.id}" onclick="setLineNum(this);"
			  				<c:if test="${status.index%2!=0}">style='background-color:#f5f5f5;#'</c:if> align="center">
			  				<td style='display:none'> <input id='templet_id' value='${ic_audit.templet_id}'/></td>
			  				<td>${status.index+1}</td>
			  				<td>${ic_audit.audit_name}</td>
			  				<td><fmt:formatDate value="${ic_audit.audit_date}" pattern="yy年MM月dd日 HH:mm"/></td>
			  			</tr>
			    	</c:forEach>
				  </tbody>
		    	</table>
			</form>
		</div>
  	</body>
</html>
