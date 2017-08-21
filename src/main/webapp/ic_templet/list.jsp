<%@ page language="java" import="java.util.*" pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+"/ic/";
%>
<!-- 新建内控项目页面，展示正式模板列表 -->
<html xmlns="http://www.w3.org/1999/xhtml">
   <head> 
    <meta http-equiv="Content_Type" content="text/html;charset=UTF-8"/>
    <title>模板列表</title>
    <script type="text/javascript" src="../script/jquery.js"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main.css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/libs/modernizr.min.js"></script>
	<script type="text/javascript">
		//选中某一条模板变色	
		function setLineNum(line){
			var id=line.id;
			var box=$("#templet_id");
			box.attr("value",id);
			$(line).css("background","#B0C4DE");
			
			var trs=$("#tbody").children("tr");
			for(var i=0;i<trs.length;i++){
				if(trs[i]!=line){//这里使用find需要dom对象，$转化之
					if($(trs[i]).find('td').eq(0).html()%2!=0){
						trs[i].style.background="";
					}else{
						trs[i].style.background="#f5f5f5";
					}
				}
			}
		}
		
		//通用弹出方程
		function pop(window, focus) {
			if (window[0].style.display == "none") {
				window.css("display", "block");
				focus.focus();
			} else {
				window.css("display", "none");
			}
		}
		
		//新建项目按钮
		$("#createbutton").live("click",function(){
			if($("#templet_id").val()){
				pop($("#audit_pop"),$("#audit_name"));
			}else{
				alert("请选择模板");
			}
		});
		
		//弹出项目名输入框的“取消”按钮
		function bcancel(){
			$audit_pop=$("#audit_pop");
			$("#audit_name").attr("value","");
			$audit_pop.css("display","none");
		}
		
		//弹出项目名输入框的“确认”按钮
		$("#addconfirm").live("click",function(){
			var audit_name=$("#audit_name").val();
			var templet_id=$("#templet_id").val();
			var $audit_pop=$("#audit_pop");
			if(!audit_name){
				alert("请输入项目名称");
			}else{
				//应对浏览器拦截窗口
				var result="";
				$.ajax({
					url : "/ic/ic_audit/createAudit.do?templet_id="+templet_id+"&audit_name="+audit_name+"&create_id="+'<%=request.getAttribute("create_id")%>',
					type : "post",
					dataType : "json",
					async:false,
					error : function() {
						window.confirm("新建审计项目错误！");
					},
					success : function(data) {
						$audit_pop.css("display","none");
						var param = jQuery.parseJSON(data); 
						result=encodeURI("/ic/ic_audit/audit.do?ic_templet_id="+param.ic_templet_id+"&audit_id="+param.audit_id
							+"&audit_name="+audit_name);
					}
				});
				window.open(result,"_blank");
			}
		});
	</script>
  </head>

<body>
	<div class="search-wrap">
		<div class="search-content">
			<form
				action="${pageContext.request.contextPath}/templet/queryTempletByName.do?list=true"
				method="post">
				<table class="search-tab">
					<tr>
						<th width="70">关键字:</th>
						<td><input class="common-text" placeholder="模板名"
							name="templet_keyword" value="${templet_keyword}" id=""
							type="text"></input></td>
						<td><input class="btn btn-primary btn2" name="sub" value="查询"
							type="submit"></input></td>
						<td width="90px"></td>
						<td><input id="createbutton" class="btn btn-primary btn2"
							name="sub" value="新建项目" type="button" onclick=""></input></td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	<!-- 新建审计项目名称录入 -->
	<div id="audit_pop"
		style="z-index:999;display:none;position:fixed;top:30;background:#ffffff;
       		width:400px;height:180px;margin:0 50% 0 25%;border:3px solid #ccc;">
		<form id="addsubmit"
			action="${pageContext.request.contextPath}/ic_audit/createAudit.do"
			method="post">
			<table align="center">
				<tr>
					<td height="30px" colspan="2"></td>
				</tr>
				<tr>
					<td height="30px" colspan="2"><input placeholder="被审单位" id=""
						name="" value='' size="18"></input></td>
				</tr>
				<tr>
					<td height="10px" colspan="2"></td>
				</tr>
				<tr>
					<td colspan="2"><input id="audit_name" name="audit_name"
						size="18" placeholder="项目名称" value=''></input></td>
				</tr>
				<tr>
					<td height="15px"><input type="hidden" id="templet_id"
						value="" name="templet_id"></input></td>
					<!-- 预留的建项人名称input -->
					<td><input type="hidden" id="create_name" value=""
						name="create_name"></input></td>
				</tr>
				<tr>
					<td><input id="addconfirm" type="button" style="width:80px"
						id="confirm" class="btn btn-primary btn4" name="" value="确定"
						onclick="" /></td>
					<td><input type="button" style="width:80px"
						class="btn btn-primary btn4" name="" value="取消"
						onclick="bcancel();" /></td>
				</tr>
			</table>
		</form>
	</div>
	<div>
		<form id="listForm" action="" method="get">
			<table width="100%">
				<thead>
					<tr style='background-color:#e5e5e5;#'>
						<th align="center">序号</th>
						<th align="center">模板名称</th>
					</tr>
				</thead>
				<tbody id='tbody'>
					<c:forEach items="${Templet_List}" var="ic_Templet"
						varStatus="status">
						<tr id="${ic_Templet.id}" onclick="setLineNum(this);"
							<c:if test="${status.index%2!=0}">style='background-color:#f5f5f5;#'</c:if>
							align="center">
							<td>${status.index+1}</td>
							<td>${ic_Templet.templet_name}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</form>
	</div>
</body>
</html>
