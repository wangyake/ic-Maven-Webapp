<%@ page language="java" import="java.util.*" pageEncoding="utf-8"
	contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ "/ic/";
%>
<!-- 正式模板列表页面 -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta content="text/html;charset=UTF-8" />
<title>模板列表</title>
<script type="text/javascript" src="../script/jquery.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/common.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/main.css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/libs/modernizr.min.js"></script>
<script type="text/javascript">
	$add_templet = $("#add_templet");
	//增加模板按钮
	$add_templet.live("click", function() {
		$templet_pop = $("#templet_pop");
		if ($templet_pop[0].style.display == "none") {
			$templet_pop.css("display", "block");
			$("#templet_name").focus();
		} else {
			$templet_pop.css("display", "none");
		}
	});
	
	
	function bcancel() {
		$templet_pop = $("#templet_pop");
		$("#templet_name").attr("value", "");
		$templet_pop.css("display", "none");
	}

	function submitedit() {
		if (!$("#templet_id").val()) {
		} else {
			$("#editTemplet").submit();
		}
	}

	//验证输入框是否为空
	$("#addconfirm").live("click", function() {
		if (!$("#templet_name").val()) {
			alert("请输入模板名称");
		} else {
			$("#addsubmit").submit();
		}
	});

	//删除模板按钮
	$("#deleteTemplet").live("click", function() {
		if (!$("#templet_id").val()) {
		} else {
			if (!window.confirm("确认删除模板和其下所有信息么？")) {
				return;
			}
			var templet_id = $("#templet_id").val();
			$.ajax({
				url : "/ic/templet/deleteTemplet.do?templet_id=" + templet_id,
				type : "post",
				dataType : "json",
				error : function() {
					window.confirm("模板删除失败！");
				},
				//关掉深度序列化
				traditional : true,
				success : function(data) {
					$("#" + templet_id).remove();
					var trs = $("#tbody").children("tr");
					for (var i = 0; i < trs.length; i++) {
						$(trs[i]).find('td').eq(0).html("" + (i + 1));
					}
					for (var i = 0; i < trs.length; i++) {
						if ($(trs[i]).find('td').eq(0).html() % 2 != 0) {
							trs[i].style.background = "";
						} else {
							trs[i].style.background = "#f5f5f5";
						}
					}
				}
			});
		}
	});

	//选中某一条模板变色	
	function setLineNum(line) {
		var id = line.id;
		var box = $("#templet_id");
		box.attr("value", id);
		$(line).css("background", "#B0C4DE");

		var trs = $("#tbody").children("tr");
		for (var i = 0; i < trs.length; i++) {
			if (trs[i] != line) {//这里使用find需要dom对象，$转化之
				if ($(trs[i]).find('td').eq(0).html() % 2 != 0) {
					trs[i].style.background = "";
				} else {
					trs[i].style.background = "#f5f5f5";
				}
			}
		}
	}
</script>
</head>
<body>
	<div class="search-wrap">
		<div class="search-content">
			<form
				action="${pageContext.request.contextPath}/templet/queryTempletByName.do?list=false"
				method="post">
				<table class="search-tab">
					<tr>
						<th width="70">关键字:</th>
						<td><input class="common-text" name="templet_keyword"
							value="${templet_keyword}" id="" type="text"></input></td>
						<td><input class="btn btn-primary btn2" name="sub" value="查询"
							type="submit"></input></td>
						<td width="25px"></td>
						<td><input type="button" class="btn btn-primary btn2"
							value="新建" id="add_templet" name="add_templet" onclick="" /></td>
						<%-- onclick="window.location.href='/ic/ic_templet/add.jsp' " --%>
						<td align="center"><input type="button"
							class="btn btn-primary btn2" name="" value="编辑"
							onclick="submitedit()" /></td>
						<td><input type="button" id="deleteTemplet"
							class="btn btn-primary btn2" name="" value="删除" onclick="" /></td>
					</tr>
				</table>
			</form>
			<!-- 编辑按钮 -->
			<form
				action="${pageContext.request.contextPath}/templet_item/queryItemByTempletId.do"
				id="editTemplet" method="post" style="display:'none'">
				<input type="hidden" id="templet_id" value="" name="templet_id"></input>
			</form>
		</div>
	</div>
	<div id="cover_dad" style="position:relative">
		<div id="templet_pop"
			style="z-index:999;display:none;position:fixed;top:30;background:#ffffff;
        		width:400px;height:150px;margin:0 50% 0 25%;border:3px solid #ccc;">
			<form id="addsubmit"
				action="${pageContext.request.contextPath}/templet/addTemplet.do"
				method="post">
				<table align="center">
					<tr>
						<td height="30px"><input type="hidden" id="creat_name"
							name="creat_name" value=''></input></td>
						<td></td>
					</tr>
					<tr>
						<td colspan="2"><input id="templet_name" name="templet_name"
							size="18" placeholder="模板名称" value=''></input></td>
					</tr>
					<tr>
						<td height="15px"><input type="hidden" id=''></input></td>
						<td></td>
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
		<div id="list_templet" style="position:absolute;top:0;width:100%;">
			<form id="listForm" action="" method="get">
				<table width="100%">
					<thead>
						<tr style='background-color:#e5e5e5;#'>
							<th align="center">序号</th>
							<th align="center">模板名称</th>
						</tr>
					</thead>
					<tbody id='tbody'>
						<c:forEach items="${Templet_List}" var="templet"
							varStatus="status">
							<tr id="${templet.id}" onclick="setLineNum(this);"
								<c:if test="${status.index%2!=0}">style='background-color:#f5f5f5;#'</c:if>
								align="center">
								<td>${status.index+1}</td>
								<td>${templet.templet_name}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</form>
		</div>
	</div>
</body>
</html>
