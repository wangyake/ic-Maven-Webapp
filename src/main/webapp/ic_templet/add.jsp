<%@ page language="java" import="java.util.*" pageEncoding="utf-8"
	contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()+ "/ic/";
%>
<!-- 正式模板编辑和新加页面 -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content_Type" content="text/html;charset=UTF-8"/>
<title>模板列表</title>
<script type="text/javascript" src="../script/jquery.js"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/common.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/zTreeStyle/zTreeStyle.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/main.css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/libs/modernizr.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/js/jquery.ztree.core.js"></script>
<style>
	html,body,.sidebar{
			height:100%
		}
	#tab {table-layout: fixed;}
	#tab td{overflow: hidden;text-overflow: ellipsis;white-space: nowrap; }
</style>
<script type="text/javascript">
	var $additem = $("#additem");
	var $addline = $("#addline");
	var $item_pop = $("#item_pop");
	var $type_head = $("#type_head");
	var $templet_id = $("#templet_id").val();
	var $item_confirm = $("#item_confirm");
	var $item_cancel=$("#item_cancel");
	var $invest_cancel=$("#invest_cancel");
	var $test_cancel=$("#test_cancel");
	var $unselect_div = $("#unselect_div");
	
	
	//通用弹出方程  
	function pop(window, focus) {
		if (window[0].style.display == "none") {
			window.css("display", "block");
			focus.focus();
		} else {
			window.css("display", "none");
		}
	}
	
	//树节点的构造方程
	function ZtreeNode(id,name,parent_id,templet_id) {
		this.id = id;
		this.parent_id = parent_id;
		this.name = name;
		this.templet_id=templet_id;
	}
	//树的初始参数：空节点
	var treeNodes = [];
	//树的setting
	var setting = {
		data : {
			simpleData : {
				enable : true,
				idKey : "id",
				pIdKey : "parent_id",
				rootPId : 0
			}
		},
		callback:{//回调函数
			onClick:onClick
		}
	};
	
	//获得选中节点和其下所有节点
	function getAllChildrenNodes(node,result){
		result.push(node.id);
		if(node.isParent){
			var childrenNodes=node.children;
			if(childrenNodes){
				for(var i=0;i<childrenNodes.length;i++){
					result=getAllChildrenNodes(childrenNodes[i],result);
				}
			}
		}
		return result;
	}
	
	//删除表项按钮
	$("#deleteitem").live("click",function(){
		var treeObj = $.fn.zTree.getZTreeObj("tree");
		var nodes = treeObj.getSelectedNodes();
		var result=[];
		var item_ids;
		if(nodes.length==0){
			return;
		}else{
			item_ids=getAllChildrenNodes(nodes[0],result);
		}
		
		$.ajax({
			url : "/ic/templet_item/deleteItemCascade.do",
			data: {"item_ids":item_ids},
			type : "post",
			dataType : "json",
			error : function() {
				window.confirm("表项删除失败！");
			},
			traditional: true,
			success : function(data) {
				treeObj.removeNode(nodes[0]);
				$('#tab tbody').empty();
			}
		});
	});
	
	
	//载入页面时初始化树
	$(document).ready(function() {
		var item_list='<%=request.getAttribute("item_list")%>';
		var obj=jQuery.parseJSON(item_list);
		if(item_list=='[]'){
			$.fn.zTree.init($("#tree"), setting,tInit);
		}else{
			$.fn.zTree.init($("#tree"),setting,obj);
		}
	});
	
	var tInit=[];
	
	//树节点绑定的onClick函数
	function onClick(e, treeId, treeNode) {
		var $audit_type = $("input[name='audit_type']:checked").val();
		var nodeId = treeNode.id;
		if ($audit_type == 0) {//查询本节点下的所有调查内容并展示(展示表头，展示数据)		
			$.ajax({
				url : "/ic/invest/queryInvestByItemId.do?item_id="
						+ nodeId,
				type : "post",
				dataType : "json",
				error : function() {
					window.confirm("调查内容查询失败！");
				},
				success : function(data) {
					//成功先清空tab
					$('#tab tbody').empty();
					//写表头
					$('#tab tbody').append(
									"<tr bgcolor='#ccc' height=30px>"
											+ "<th align='center' width='85%'>调查内容</th>"
											+ "<th align='center' width='15%'>操作</th>"
											+ "</tr>");
					$.each(data, function(i, ic_invest) {
						line="<tr>"+
							 "<td style='display:none;'><input value='"+ic_invest['id']+"' type='hidden' /></td>"+
							 "<td align='left' id='invest_"+ic_invest['id']+"'>"+ic_invest['invest_name']+"</td>"+
							 "<td align='center'><a onclick='modifyInvest(this)'>[编辑]</a>"+
							 "<a onclick='delInvest(this)'>[删除]</a></td></tr>";
						$('#tab tbody').append(line);
					});
				}
			});
		} else {//$audit_type == 1;查询本节点下的所有测试内容并展示(展示表头，展示数据)
			$.ajax({
				url : "/ic/tests/queryTestByItemId.do?item_id="+ nodeId,
				type : "post",
				dataType : "json",
				error : function() {
					window.confirm("测试内容查询失败！");
				},
				success : function(data) {
					//成功先清空tab
					$('#tab tbody').empty();
					//写表头
					$('#tab tbody').append(
									"<tr bgcolor='#ccc' height=30px>"
											+ "<th align='center' width='25%'>测试目标</th>"
											+ "<th align='center' width='25%'>弱点分析</th>"
											+ "<th align='center' width='35%'>测试方法</th>"
											+ "<th align='center' width='15%'>操作</th>"
											+ "</tr>");
					$.each(data, function(i, ic_test) {
						line="<tr align='left'>"+
							 "<td style='display:none;'><input value='"+ic_test['id']+"' type='hidden' /></td>"+
							 "<td id='test"+ic_test['id']+"target'>"+ic_test['test_target']+"</td>"+
							 "<td id='test"+ic_test['id']+"weakness'>"+ic_test['test_weakness']+"</td>"+
							 "<td id='test"+ic_test['id']+"method'>"+ic_test['test_method']+"</td>"+
							 "<td align='center' ><a onclick='modifyTest(this)'>[编辑]</a>"+
							 "<a onclick='delTest(this)'>[删除]</a></td></tr>";
						$('#tab tbody').append(line);
					});
				}
			});
		}
	};
	
	//点击树下方的空白取消节点选择
	$unselect_div.live("click", function() {
		var treeObj = $.fn.zTree.getZTreeObj("tree");
		var nodes = treeObj.getSelectedNodes();
		if (nodes.length > 0) {
			treeObj.cancelSelectedNode(nodes[0]);
		}
	});

	//三个弹出框的"取消"按钮，点击隐藏弹出窗口
	$item_cancel.live("click", function() {
		$("#item_pop").css("display", "none");
	});
	$invest_cancel.live("click", function() {
		$("#invest_id").attr("value","");
		$("#invest_name").attr("value","");
		$("#invest_pop").css("display", "none");
	});
	$test_cancel.live("click", function() {
		$("#test_id").attr("value","");
		$("#test_target").attr("value","");
		$("#test_weakness").attr("value","");
		$("#test_method").attr("value","");
		$("#test_pop").css("display", "none");
	});

	//"增加表项"按钮
	$additem.live("click",function() {
		var $audit_type = $("input[name='audit_type']:checked").val();
		if ($audit_type == 0) {
			document.getElementById("type_head").innerHTML = "<font size='3'>&nbsp&nbsp&nbsp&nbsp内控调查表项</font>";
		} else {
			document.getElementById("type_head").innerHTML = "<font size='3'>&nbsp&nbsp&nbsp&nbsp内控测试表项</font>";
		}
		;
		var $item_pop = $("#item_pop");
		var $test_pop = $("#test_pop");
		var $invest_pop = $("#invest_pop");
		
		if($test_pop[0].style.display=="block"){
			$test_pop.css("display","none");
		}if($invest_pop[0].style.display=="block"){
			$invest_pop.css("display","none");
		}
			pop($item_pop, $("#item_name"));
	});
	
	
	//添加表项弹出窗口的"确定"按钮，完成1：必填提示  2：根据本级/下级返回父级id 
	$item_confirm.live("click", function() {
		var treeObj = $.fn.zTree.getZTreeObj("tree");
		//选中的节点，是个集合。但是单选，，
		var nodes = treeObj.getSelectedNodes();
		//本级/下级
		var $level = $("input[name='level']:checked").val();
		//表项名称
		var $item_name = $("#item_name").val();
		var $parent_id;

		//模板名称不能为空
		if (!$item_name) {
			alert("请输入模板项名称！");
			return;
		} else {
			if ($level == 1) {//选择下级时必须选中父节点
				if (nodes.length == 0) {
					alert("请选择父级节点！");
					return;
				}
			}
		}

		//返回的父级节点id
		if (nodes.length > 0) {//有选中
			if ($level == 0) {//本级。新建node的父级
				if (nodes[0].getParentNode()) {//选中节点的父级存在
					$parent_id = nodes[0].getParentNode().id;
				} else {//选中节点的父级不存在。注意树的rootpid=0，故父级ID为0，而向数据库写数据时要把0改成null
					$parent_id = 0;
				}
			} else {//下级
				$parent_id = nodes[0].id;
			}
		} else {//未选中
			$parent_id = 0;
		};
		
		var templet_item = {
			"parent_id" : $parent_id,
			"templet_id" : $("#templet_id").val(),
			"item_name" : $item_name
		};

		$.ajax({
				url : "/ic/templet_item/addTemplet_Item.do",
				data : templet_item,
				type : "post",
				dataType : "json",
				error : function() {
					window.confirm("模板项写入失败！");
				},
				success : function(data) {
					//添加新节点
					var newNode = new ZtreeNode(data,$item_name,$parent_id,null);
					var parentNode = treeObj.getNodeByParam("id",$parent_id, null);
					treeObj.addNodes(parentNode, newNode, true);
					$("#item_name").attr("value", "");
					$("#item_pop").css("display", "none");
				}
			});
		});

	//"增加表行"按钮
	$addline.live("click", function() {
		var $audit_type = $("input[name='audit_type']:checked").val();
		var $invest_pop = $("#invest_pop");
		var $invest_name = $("#invest_name");
		var $test_pop = $("#test_pop");
		var $test_target = $("#test_target");
		var $item_pop = $("#item_pop");

		if ($item_pop[0].style.display == "block") {
			$item_pop.css("display", "none");
		}
		//根据调查/测试弹出不同输入框
		if ($audit_type == 0) {
			if ($test_pop[0].style.display == "block") {
				$test_pop.css("display", "none");
			}
			pop($invest_pop, $invest_name);
		} else {
			if ($invest_pop[0].style.display == "block") {
				$invest_pop.css("display", "none");
			}
			pop($test_pop, $test_target);
		}
	});
	
	//表行内容（调查）的“编辑”按钮
	function modifyInvest(obj){
	//这里用html(),innerHTML和innerText都不可以，fuck！
		var invest_name=$(obj).parent().prev().html();
		var invest_id=$(obj).parent().prev().prev().find("input").val();
		var $invest_id=$("#invest_id");
		var $invest_pop=$("#invest_pop");
		var $invest_name=$("#invest_name");
		pop($invest_pop, $invest_name);
		//给invest_pop中的id赋值
		$invest_id.attr("value",invest_id);
		$invest_name.attr("value",invest_name);
	}
	
	//表行内容（调查）的“删除”按钮
	function delInvest(obj){
		var invest_id=$(obj).parent().prev().prev().find("input").val();
		$.ajax({
			url : "/ic/invest/deleteInvest.do?id="+invest_id,
			type : "post",
			dataType : "json",
			error : function() {
				window.confirm("调查内容删除失败！");
			},
			success : function(data) {
				$(obj).parent().parent().remove();
			}
		});
	}
	
	//表行内容（测试test）的“编辑”按钮
	function modifyTest(obj){
		var test_target=$(obj).parent().prev().prev().prev().html();
		var test_weakness=$(obj).parent().prev().prev().html();
		var test_method=$(obj).parent().prev().html();
		var test_id=$(obj).parent().parent().find("input").val();
		
		pop($("#test_pop"), $("#test_target"));
		//给test_pop中的id赋值
		$("#test_id").attr("value",test_id);
		$("#test_target").attr("value",test_target);
		$("#test_weakness").attr("value",test_weakness);
		$("#test_method").attr("value",test_method);
	}
	
	//表行内容（测试test）的“删除”按钮
	function delTest(obj){
		var test_id=$(obj).parent().parent().find("input").val();
		$.ajax({
			url : "/ic/tests/deleteTest.do?id="+test_id,
			type : "post",
			dataType : "json",
			error : function() {
				window.confirm("测试内容删除失败！");
			},
			success : function(data) {
				$(obj).parent().parent().remove();
			}
		});
	}
	
	//调查输入框的“确认”按钮，根据输入框隐藏的id值的有无进行调查条目的增加/修改
	$("#invest_confirm").live("click", function() {
		var treeObj = $.fn.zTree.getZTreeObj("tree");
		var nodes = treeObj.getSelectedNodes();
		var $invest_pop=$("#invest_pop");
		var invest_name=$("#invest_name").val();
		var $tab=$("#tab");
		var $invest_id=$("#invest_id");
		var invest_id=$("#invest_id").val();
		
		if(!invest_name){
			alert("调查内容不能为空！");
			return;
		}
		if(nodes.length==0){
			alert("请选择所属表项！");
			return;
		}
		
		item_id=nodes[0].id;
		var ic_invest = {
			"item_id" : item_id,
			"invest_name" : invest_name
		};
		
		var ic_invest_update={
			"id" : invest_id,
			"invest_name" : invest_name
		};
		
		if(!$invest_id.val()){
			//invest_pop的id为空就新建项目
			$.ajax({
				url : "/ic/invest/addInvest.do",
				data : ic_invest,
				type : "post",
				dataType : "json",
				error : function() {
					window.confirm("调查内容写入失败！");
				},
				success : function(data) {
					//alert(data);
					//追加显示一行内控调查内容
					$tab.append("<tr align='left'>"+
						"<td style='display:none;'><input value='"+data+"' type='hidden' /></td>"+
						"<td id='invest_"+data+"'>"+invest_name+"</td>"+
						"<td align='center'><a onclick='modifyInvest(this)'>[编辑]</a>"+
						"<a onclick='delInvest(this)'>[删除]</a></td></tr>");
				}
			});
		}else{//invest_pop的id不为空就update这条invest，更新显示
			$.ajax({
				url : "/ic/invest/updateInvest.do",
				data : ic_invest_update,
				type : "post",
				dataType : "json",
				error : function() {
					window.confirm("调查内容修改失败！");
				},
				success : function(data) {
					$("#invest_"+invest_id+"").html(invest_name);
				}
			});
		}
		
		//最后应清空id值和内容栏
		$invest_id.attr("value","");
		$("#invest_name").attr("value","");
		$invest_pop.css("display","none");
	});

	//测试输入框的“确认”按钮，根据输入框隐藏的id值的有无进行测试条目的增加/修改
	$("#test_confirm").live("click", function() {
		var treeObj = $.fn.zTree.getZTreeObj("tree");
		var nodes = treeObj.getSelectedNodes();
		var test_target=$("#test_target").val();
		var test_weakness=$("#test_weakness").val();
		var test_method=$("#test_method").val();
		var test_id=$("#test_id").val();
		var $tab=$("#tab");
		
		if(!test_target){
			alert("请填写测试目标！");
			return;
		}if(!test_weakness){
			alert("请填写弱点分析！");
			return;
		}if(!test_method){
			alert("请填写测试方法！");
			return;
		}
		if(nodes.length==0){
			alert("请选择所属表项！");
			return;
		}
		item_id=nodes[0].id;
		var ic_test = {
			"item_id" : item_id,
			"test_target" : test_target,
			"test_weakness": test_weakness,
			"test_method":test_method
		};
		
		var ic_test_update={
			"id" : test_id,
			"test_target" : test_target,
			"test_weakness": test_weakness,
			"test_method":test_method
		};
		
		if(!test_id){
			//invest_pop的id为空就新建项目
			$.ajax({
				url : "/ic/tests/addTest.do",
				data : ic_test,
				type : "post",
				dataType : "json",
				error : function() {
					window.confirm("调查内容写入失败！");
				},
				success : function(data) {
					//追加显示一行内控测试test内容
					$tab.append("<tr align='left'>"+
							 "<td style='display:none;'><input value='"+data+"' type='hidden' /></td>"+
							 "<td id='test"+data+"target'>"+test_target+"</td>"+
							 "<td id='test"+data+"weakness'>"+test_weakness+"</td>"+
							 "<td id='test"+data+"method'>"+test_method+"</td>"+
							 "<td align='center'><a onclick='modifyTest(this)'>[编辑]</a>"+
							 "<a onclick='delTest(this)'>[删除]</a></td></tr>");
				}
			});
		}else{//test_pop的id不为空就update这条test，更新显示
			$.ajax({
				url : "/ic/tests/updateTest.do",
				data : ic_test_update,
				type : "post",
				dataType : "json",
				error : function() {
					window.confirm("调查内容修改失败！");
				},
				success : function(data) {
					$("#test"+test_id+"target").html(test_target);
					$("#test"+test_id+"weakness").html(test_weakness);
					$("#test"+test_id+"method").html(test_method);
				}
			});
		}
		
		//最后应清空id值和内容栏
		$("#test_id").attr("value","");
		$("#test_target").attr("value","");
		$("#test_weakness").attr("value","");
		$("#test_method").attr("value","");
		$("#test_pop").css("display","none");
	});
	
	//radio选中内控调查
	$("#invest_option").live("click", function() {
/* 		//如果已经选中invest，do nothing,因为点击后audit_type已经更改，这个判断暂时实现不了。思考下
		var audit_type = $("input[name='audit_type']:checked").val();
		if(audit_type==0){
			return;
		} */
		//获得item_id
		var treeObj = $.fn.zTree.getZTreeObj("tree");
		var nodes = treeObj.getSelectedNodes();
		//未选中任何节点
		if(nodes.length==0){
			//未选中任何节点清空tab
			$('#tab tbody').empty();
/* 			//写表头
			$('#tab tbody').append(
				"<tr bgcolor='#ccc'>"
				+ "<th align='center' width='85%'>调查内容</th>"
				+ "<th align='center' width='15%'>操作</th>"
				+ "</tr>"); */
		}else{//选中节点，查询，写表头，写数据
			var item_id=nodes[0].id;
			$.ajax({
				url : "/ic/invest/queryInvestByItemId.do?item_id="+ item_id,
				type : "post",
				dataType : "json",
				error : function() {
					window.confirm("调查内容查询失败！");
				},
				success : function(data) {
					//成功先清空tab
					$('#tab tbody').empty();
					//写表头
					$('#tab tbody').append(
						"<tr bgcolor='#ccc' height=30px>"
						+ "<th align='center' width='85%'>调查内容</th>"
						+ "<th align='center' width='15%'>操作</th>"
						+ "</tr>");
					$.each(data, function(i, ic_invest) {
						line="<tr align='left'>"+
							 "<td style='display:none;'><input value='"+ic_invest['id']+"' type='hidden' /></td>"+
							 "<td id='invest_"+ic_invest['id']+"'>"+ic_invest['invest_name']+"</td>"+
							 "<td align='center'><a onclick='modifyInvest(this)'>[编辑]</a>"+
							 "<a onclick='delInvest(this)'>[删除]</a></td></tr>";
						$('#tab tbody').append(line);
					});
				}
			});
		}
	});
	
	//radio选中内控测试
	$("#test_option").live("click",function(){
		//获得item_id
		var treeObj = $.fn.zTree.getZTreeObj("tree");
		var nodes = treeObj.getSelectedNodes();
		if(nodes.length==0){
			//未选中任何节点清空tab
			$('#tab tbody').empty();
		}else{
			var item_id=nodes[0].id;
			$.ajax({
				url : "/ic/tests/queryTestByItemId.do?item_id="+ item_id,
				type : "post",
				dataType : "json",
				error : function() {
					window.confirm("测试内容查询失败！");
				},
				success : function(data) {
					//成功先清空tab
					$('#tab tbody').empty();
					//写表头
					$('#tab tbody').append(
						"<tr bgcolor='#ccc' height=30px>"
						+ "<th align='center' width='25%'>测试目标</th>"
						+ "<th align='center' width='25%'>弱点分析</th>"
						+ "<th align='center' width='35%'>测试方法</th>"
						+ "<th align='center' width='15%'>操作</th>"
						+ "</tr>");
					$.each(data, function(i, ic_test) {
						line="<tr align='left'>"+
							 "<td style='display:none;'><input value='"+ic_test['id']+"' type='hidden' /></td>"+
							 "<td id='test"+ic_test['id']+"target'>"+ic_test['test_target']+"</td>"+
							 "<td id='test"+ic_test['id']+"weakness'>"+ic_test['test_weakness']+"</td>"+
							 "<td id='test"+ic_test['id']+"method'>"+ic_test['test_method']+"</td>"+
							 "<td align='center'><a onclick='modifyTest(this)'>[编辑]</a>"+
							 "<a onclick='delTest(this)'>[删除]</a></td></tr>";
						$('#tab tbody').append(line);
					});
				}
			});
		}
	});
	
</script>
</head>
<body>
	<!-- <div class="container clearfix"> -->
		<div class="sidebar" style="float:left;width:130px;min-height:700px;border-right:1px solid #ccc;">
			<div id="tree_div" 
				style="background-color:#f2f2f2;height:40px;padding:0 10px 0 10px;">
				<ul>
					<li style="height:30px;line-height:30px"><a href="#"
						style="height:40px;padding:13px 5px 0 5px;"><font size="3"
							color="#333">表项</font></a>
						<ul  id="tree" style="margin:10px 0 0 0" class="ztree"></ul></li>
				</ul>
			</div>
			<div id="unselect_div"
				style="height:auto;height:300px;min-height:300px;"></div>
		</div>

		<div class="add_button">
			<form action="#" method="post">
				<table class="search-tab">
					<tr>
						<th width="90"><input id="additem" type="button"
							style="width:85px" onclick="" class="btn btn-primary btn4"
							value="增加表项" /></th>
						<th width="90"><input id="deleteitem" type="button" style="width:85px"
							class="btn btn-primary btn4" name="" value="删除表项" /></th>
						<th width="90"><input id="addline" type="button"
							style="width:85px" class="btn btn-primary btn4" name=""
							value="增加表行" /></th>
					</tr>
				</table>
			</form>
		</div>

		<div class="result-title" style="line-height: 20px;overflow: hidden;">
			<div class="result-list" style="margin:10px 0 0 2%">
				<label><input id="invest_option" name="audit_type" type="radio" checked="checked" value="0"/>
					<font size='4'>内控调查</font></label> 
				<label><input id="test_option" name="audit_type" type="radio" value="1" />
					<font size='4'>内控测试</font></label>
			</div>

			<div id="cover_dad" style="position:relative">
				<!-- 内控表项输入窗口 -->
				<div id="item_pop"
					style="z-index:999;position:fixed;top:30;display:none;background:#ffffff;
						margin:0 50% 0 25%;width:400px;height:150px;border:3px solid #ccc;padding:10 auto">
					<div id="type_head"></div>
					<form>
						<table align="center">
							<tr>
								<td height="10px" width="1px"></td>
								<td></td>
							</tr>
							<tr>
								<td><label><input name="level" type="radio"
										value="0" checked="checked" /><font size='4'>本级</font></label></td>
								<td><label><input name="level" type="radio"
										value="1" /><font size='4'>下级</font></label></td>
							</tr>
							<tr>
								<td height="10px"><input type="hidden" id="parent_id"
									name="parent_id" value=''></input></td>
								<td><input type="hidden" id="templet_id" name="templet_id"
									value='${templet_id}'></input></td>
							</tr>
							<tr>
								<td><font size="3">表项名称：</font></td>
								<td></td>
							</tr>
							<tr>
								<td colspan="2"><input size="30" name="item_name" value=""
									id="item_name" type="text" /></td>
							</tr>
							<tr>
								<td><input type="button" style="width:85px"
									id="item_confirm" class="btn btn-primary btn4" name=""
									value="确定" onclick="" /></td>
								<td><input id="item_cancel" type="button" style="width:85px"
									class="btn btn-primary btn4" name="" value="取消"
									onclick="" /></td>
							</tr>
							<tr>
								<td height="10px"></td>
								<td></td>
							</tr>
						</table>
					</form>
				</div>
				<!-- 内控调查输入窗口 -->
				<div id="invest_pop"
					style="z-index:999;position:fixed;top:30;display:none;background:#ffffff;
						margin:0 50% 0 25%;width:400px;height:120px;border:3px solid #ccc;padding:10 auto">
					<form>
						<table align="center">
							<tr>
								<td height="10px" width="1px">
									<input type="hidden" id="invest_id" name="invest_id" value="" /></td>
								<td></td>
							</tr>
							<tr>
								<td><font size="3">调查内容：</font></td>
								<td></td>
							</tr>
							<tr>
								<td colspan="2"><input size="30" name="invest_name"
									value="" id="invest_name" type="text" /></td>
							</tr>
							<tr>
								<td height="10px"></td>
								<td></td>
							</tr>
							<tr>
								<td><input id="invest_confirm" type="button" style="width:85px" 
									class="btn btn-primary btn4" name="" value="确定" onclick="" /></td>
								<td><input id="invest_cancel" type="button" style="width:85px"
									class="btn btn-primary btn4" name="" value="取消"
									onclick="" /></td>
							</tr>
							<tr>
								<td height="10px"></td>
								<td></td>
							</tr>
						</table>
					</form>
				</div>
				<!-- 内控测试输入窗口 -->
				<div id="test_pop"
					style="z-index:999;position:fixed;top:30;display:none;background:#ffffff;
						margin:0 50% 0 25%;width:500px;height:400px;border:3px solid #ccc;padding:10 auto">
					<form>
						<table align="center">
							<tr>
								<td height="5px" width="1px"><input type="hidden" id="test_id" name="test_id" value="" /></td>
								<td></td>
							</tr>
							<tr>
								<td colspan="2"><font size="3">测试目标：</font></td>
							</tr>
							<tr>
								<td colspan="2"><input id="test_target" size="30"  value="" type="text" /></td>
							</tr>

							<tr>
								<td colspan="2"><font size="3">弱点分析：</font></td>
							</tr>
							<tr>
								<td colspan="2"><input id="test_weakness" size="30"
									name="test_weakness" value="" type="text" /></td>
							</tr>

							<tr>
								<td colspan="2"><font size="3">内控测试方法：</font></td>
							</tr>
							<tr>
								<td colspan="2"><textarea id="test_method" rows="10"
										cols="50" class="text"></textarea></td>
							</tr>
							<tr>
								<td height="5px"></td>
								<td></td>
							</tr>
							<tr>
								<td><input id="test_confirm" type="button" style="width:85px" id="confirm" class="btn btn-primary btn4" name="" value="确定" onclick="" /></td>
								<td><input id="test_cancel" type="button" style="width:85px" class="btn btn-primary btn4" name="" value="取消"
									onclick="" /></td>
							</tr>
							<tr>
								<td height="5px"></td>
								<td></td>
							</tr>
						</table>
					</form>
				</div>
			</div>

			<div id="main_div" style="height:300px;min-height:300px;overflow-y:scroll;">
				<table id="tab" border="1"  style="margin:10px 10% 0 20px;line-height:20px;width:90%;">
					<tbody>
					</tbody>
				</table>
			</div>
		</div>
	<!-- </div> -->
</body>
</html>
