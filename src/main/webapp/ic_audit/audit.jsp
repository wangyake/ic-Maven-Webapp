<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()+ "/ic/";
%>
<!-- 内控作业页面 -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content_Type" content="text/html;charset=UTF-8"/>
<title>结果录入</title>
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

	#tab {table-layout: fixed;}
	#tab td{overflow: hidden;text-overflow: ellipsis;white-space: nowrap; }
</style>
<script type="text/javascript">
	var $unselect_div = $("#unselect_div");
	var tInit=[];
	var $savethis=$("#savethis");
	var $additem=$("#additem");
	var $addline=$("#addline");
	var $item_cancel=$("#item_cancel");
	var $invest_cancel=$("#invest_cancel");
	var $test_cancel=$("#test_cancel");
	var $item_confirm=$("#item_confirm");
	var $savetemplet_cancel=$("#savetemplet_cancel");
		
	//通用弹出方程  
	function pop(window, focus) {
		if (window[0].style.display == "none") {
			window.css("display", "block");
			focus.focus();
		} else {
			window.css("display", "none");
		}
	}
	
	//载入页面时初始化树
	$(document).ready(function() {
		var $typestatus=$("#typestatus");
		var item_list='<%=request.getAttribute("item_list")%>';
		var $audit_id=$("#audit_id");
		var $templet_id=$("#templet_id");
		var $templet_name=$("#templet_name");
		
		$typestatus.attr("value",$("input[name='audit_type']:checked").val());
		$audit_id.attr("value",<%=request.getAttribute("audit_id")%>);
		$("#audit_name").html(""+getUrlParam("audit_name")+"");
		$templet_id.attr("value",<%=request.getAttribute("templet_id")%>);
		$templet_name.attr("value",<%=request.getAttribute("templet_name")%>);
		var obj=jQuery.parseJSON(item_list);
		if(item_list=='[]'){
			$.fn.zTree.init($("#tree"), setting,tInit);
		}else{
			$.fn.zTree.init($("#tree"),setting,obj);
		}
	});
	
	function getUrlParam(name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
            var r = window.location.search.substr(1).match(reg);  //匹配目标参数
            if (r != null) return decodeURI(r[2]); return null; //返回参数值
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
	
	function iiresultchange(obj){
		var $obj=$(obj);
		$("#editflag").attr("value",1);
		if($obj.html()==" "){
			$obj.html("是");	
		}else if($obj.html()=="是"){
			$obj.html("弱");
		}else if($obj.html()=="弱"){
			$obj.html("否");
		}else if($obj.html()=="否"){
			$obj.html(" ");
		}
	}
	
	function itresultchange(obj){
	 	var $obj=$(obj);
	 	$("#editflag").attr("value",1);
		if($obj.html()==" "){
			$obj.html("有效");	
		}else if($obj.html()=="有效"){
			$obj.html("较弱");
		}else if($obj.html()=="较弱"){
			$obj.html("无效");
		}else if($obj.html()=="无效"){
			$obj.html(" ");
		}
	}
	
	function itriskchange(obj){
		var $obj=$(obj);
		$("#editflag").attr("value",1);
		if($obj.html()==" "){
			$obj.html("高");	
		}else if($obj.html()=="高"){
			$obj.html("中");
		}else if($obj.html()=="中"){
			$obj.html("低");
		}else if($obj.html()=="低"){
			$obj.html(" ");
		}
	}
	
	//点击调查中的某一行，背景变色且给页面隐藏invest_result_id赋值
	function click_invest_result(obj){
		var $obj=$(obj);
		var $invest_result_id=$("#invest_result_id");
		var $invest_id=$("#invest_id");		
		var id=$obj.attr("id");
		var invest_id=$obj.children("td").eq(0).find("input").attr("id");
		//有点击则认为有编辑，editflag置为1
		//var $editflag=$("#editflag");
		//$editflag.attr("value",1);
		
		$invest_result_id.attr("value",id);
		$invest_id.attr("value",invest_id);
		$obj.css("background","#B0C4DE");
		
		var trs=$('#tab tbody').children("tr");
			for(var i=0;i<trs.length;i++){
				if(trs[i]!=obj){
					trs[i].style.background="";				
				};
			};
	}
	
	function clicktestresult(obj){
		$obj=$(obj);
		var trid=$obj.attr("id");
		var test_id_on=$obj.children("td").eq(2).find("input").val();
		var $test_method=$("#test_method");
		var $test_result_id=$("#test_result_id");
		var $test_id=$("#test_id");
		var $test_record=$("#test_record");
		var test_result_id=$test_result_id.val();
		var $result_on=$("#"+test_result_id+"");//点击之前选中的行
		
		//保存test_record的内容到对应的行
		$result_on.children("td").eq(1).find("input").val($test_record.val());
		//保存test_method的内容到对应行
		$result_on.children('td').eq(0).find("input").val($test_method.val());
		//点击的行设为选中行
		$test_result_id.attr("value",trid);
		$test_id.attr("value",test_id_on);
		$obj.css("background","#B0C4DE");
		
		var trs=$('#tab tbody').children("tr");
		for(var i=0;i<trs.length;i++){
			if(trs[i]!=obj){
				trs[i].style.background="";				
			}
		}
		//测试方法的显示
		$test_method.attr("value",""+$obj.children('td').eq(0).find("input").val()+"");	
		$test_record.val($obj.children('td').eq(1).find("input").val());
	}
	
	$("#deleteline").live("click",function(){
		var audit_type = $("input[name='audit_type']:checked").val();
		var invest_id=$("#invest_id").val();
		var test_id=$("#test_id").val();
		var invest_result_id=$("#invest_result_id").val();
		var test_result_id=$("#test_result_id").val();
		var $invest_tr=$("#"+invest_result_id+"");
		var $test_tr=$("#"+test_result_id+"");
		var $test_method=$("#test_method");
		var $test_record=$("#test_record");
		
		if(audit_type==0){//内控调查（invest）
			if(invest_id!=""){
				$.ajax({
					url:"/ic/ic_invest/deleteInvestAndResult.do?invest_id="+invest_id,
					type:"post",
					dataType:"json",
					error : function() {
						window.confirm("删除调查失败！");
					},
					success:function(data){
						$invest_tr.remove();
					}
				});
			}
		}else{//内控测试（test）
			if(test_id!=""){
				$.ajax({
					url:"/ic/ic_test/deleteTestAndResult.do?test_id="+test_id,
					//type:"post",				
					dataType:"json",
					error:function(){
						window.confirm("删除测试失败");
					},
					success:function(data){
						$test_tr.remove();
						$test_method.attr("value","");
						$test_record.attr("value","");
					}
				}
				);
			}
		}
	});
	
	//保存按钮
	function saveinvests(){
		var invest_result_list=[];
		var result;
		var trs=$('#tab tbody').children("tr");
		
		for(var i=1;i<trs.length;i++){
			result=new Object();
			result.id= $(trs[i]).attr("id");
			result.invest_result=$(trs[i]).children('td').eq(1).html();
			result.invest_remark= $(trs[i]).children('td').eq(2).find("input").val();
			invest_result_list.push(result);
		};
		$.ajax({
			url:"/ic/invest_result/updateInvestResult.do",
			data:{"list":JSON.stringify(invest_result_list)},
			dataType:"text",
			error : function() {
				window.confirm("更新调查内容失败！");
			},
			success:function(data){
			}
		});
	};
	
	function savetests(){
		var test_result_list=[];
		var result;
		var trs=$('#tab tbody').children("tr");
		var $test_result_id=$("#test_result_id");
		var $test_record=$("#test_record");
		var test_result_id=$test_result_id.val();
		var $result_on=$("#"+test_result_id+"");//选中状态的行
		//首先同步test_record的内容
		$result_on.children("td").eq(1).find("input").val($test_record.val());
		//alert($result_on.children("td").eq(1).find("input").val());
		for(var i=1;i<trs.length;i++){
			result=new Object();
			result.id= $(trs[i]).attr("id");
			result.test_effect=$(trs[i]).children('td').eq(5).html();
			result.test_risk= $(trs[i]).children('td').eq(6).html();
			result.test_record=$(trs[i]).children('td').eq(1).find("input").val();
			test_result_list.push(result);
		};
		$.ajax({
			url:"/ic/test_result/updateTestResult.do",
			data:{"list":JSON.stringify(test_result_list)},
			dataType:"text",
			error : function() {
				window.confirm("更新测试内容失败！");
			},
			success:function(data){
			}
		});
	}
	
	function saveinveststemplet(){
		var invest_list=[];
		var invest;
		var trs=$('#tab tbody').children("tr");
		
		for(var i=1;i<trs.length;i++){
			invest=new Object();
			invest.id= $(trs[i]).children('td').eq(0).find("input").attr("id");
			invest.invest_name=$(trs[i]).children('td').eq(0).find("input").val();
			invest_list.push(invest);
		};
		$.ajax({
			url:"/ic/ic_invest/updateInvestList.do",
			data:{"list":JSON.stringify(invest_list)},
			dataType:"text",
			error : function() {
				window.confirm("更新调查模板失败！");
			},
			success:function(data){
			}
		});
	};
	
	function saveteststemplet(){
		var test_list=[];
		var test;
		var trs=$('#tab tbody').children("tr");
		var test_result_id=$("#test_result_id").val();
		var $result_on=$("#"+test_result_id+"");
		var new_test_method=$("#test_method").val();
		//alert("new_test_method===="+new_test_method);
		//首先保存方法框内内容到对应行
		$result_on.children('td').eq(0).find("input").attr("value",new_test_method);
		
		for(var i=1;i<trs.length;i++){
			test=new Object();
			test.id= $(trs[i]).children('td').eq(2).find("input").val();
			test.test_target=$(trs[i]).children('td').eq(3).find("input").val();
			test.test_weakness=$(trs[i]).children('td').eq(4).find("input").val();
			test.test_method=$(trs[i]).children('td').eq(0).find("input").val();
			test_list.push(test);
		};
		$.ajax({
			url:"/ic/ic_test/updateTestList.do",
			data:{"list":JSON.stringify(test_list)},
			dataType:"text",
			type:"post",
			error : function() {
				window.confirm("更新测试模板失败！");
			},
			success:function(data){
			}
		});
	};
	
	//保存
 	$savethis.live("click",function(){
 		var trs=$('#tab tbody').children("tr");
 		var $audit_type = $("input[name='audit_type']:checked").val();
 		if(trs.length==1||trs.length==0){
 			return;
 		}
 		if($audit_type==0){
 			saveinvests();
 			saveinveststemplet();
 		}else{
 			savetests();
 			saveteststemplet();
 		};
	}); 
	
	
	//树节点绑定的onClick函数,增加   
	function onClick(e, treeId, treeNode) {
		var $audit_type = $("input[name='audit_type']:checked").val();
		var $editflag=$("#editflag");//页面是否编辑（点击）标志
		var $edittempletflag=$("#edittempletflag");
		var $test_result_id=$("#test_result_id");
		var $audit_id=$("#audit_id");
		var $big=$("#big");
		var $tab_div=$("#tab_div");
		var $test_method=$("#test_method");
		var nodeId = treeNode.id;
		var $test_record=$("#test_record");
		var $invest_id=$("#invest_id");
		
		$invest_id.attr("value","");
		if($editflag.val()==0){//先判断审计结果是否改变
		}else{//标志为1，更新结果表
			if($audit_type==0){
				saveinvests();
			}else{
				savetests();
			};
		}
		
		if($edittempletflag.val()==0){
		}else{//标志为1，更新模板表
			if($audit_type==0){
				saveinveststemplet();
			}else{
				saveteststemplet();
			}
		}
		
		$editflag.attr("value",0);//每次点击节点后置为0，未编辑状态
		$edittempletflag.attr("value",0);
		//成功先清空tab
		$('#tab tbody').empty();
		$test_method.attr("value","");
		$test_record.val("");
		if ($audit_type == 0) {//查询本节点下的所有调查invest内容并展示(展示表头，展示数据)
			$tab_div.css("height","500px");
			//内控测试页面下大窗口
			$big.css("display","none");
			$.ajax({
				url : "/ic/invest_result/queryInvestAndResult.do?item_id="+ nodeId+"&audit_id="+$audit_id.val(),
				type : "post",
				dataType : "json",
				error : function() {
					window.confirm("调查内容查询失败！");
				},
				success : function(data) {
					//写表头
					$('#tab tbody').append(
									"<tr bgcolor='#ccc' height=30px>"
											+ "<th align='center' width='50%'>调查内容</th>"
											+ "<th align='center' width='10%'>调查结果</th>"
											+ "<th align='center' width='40%'>备注</th>"
											+ "</tr>");
					$.each(data, function(i, invest_result) {
						line="<tr onclick='click_invest_result(this)' id='"+invest_result.irid+"'>"+
							 "<td align='left'><input onchange='changetemplet()' id='"+invest_result.ic_invest.id+"' style='border:none;width:100%' value='"+invest_result.ic_invest.invest_name+"'></input></td>"+
							 "<td align='center' id=''  onclick='iiresultchange(this)'>"+invest_result.invest_result+"</td>"+
							 "<td align='left' id=''><input onchange='changethis()' style='border:none;width:100%' value='"+invest_result.invest_remark+"'/></td>"+
							 "</tr>";
						$('#tab tbody').append(line);
					});
				}
			});
		} else {//$audit_type == 1;查询本节点下的所有测试内容并展示(展示表头，展示数据)
			$tab_div.css("height","350px");
		//页面下部两窗口pop显示出来
			$big.css("display","block");
			$.ajax({
				url : "/ic/test_result/queryTestAndResult.do?item_id="+ nodeId+"&audit_id="+$audit_id.val(),
				type : "post",
				dataType : "json",
				error : function() {
					window.confirm("测试内容查询失败！");
				},
				success : function(data) {
					//写表头
					$('#tab tbody').append(
									"<tr bgcolor='#ccc' height=30px>"
											+ "<th align='center' width='40%'>测试目标</th>"
											+ "<th align='center' width='40%'>弱点分析</th>"
											+ "<th align='center' width='10%'>运行效果</th>"
											+ "<th align='center' width='10%'>风险评估</th>"
											+ "</tr>");
					$.each(data, function(i, test_result) {
						line="<tr onclick='clicktestresult(this)' id='"+test_result.trid+"'>"+
							 "<td style='display:none'><input value='"+test_result.ic_test.test_method+"'></input></td>"+
							 "<td style='display:none'><input value='"+test_result.test_record+"'></input></td>"+
							 "<td style='display:none'><input id='' name='' value='"+test_result.ic_test.id+"'></input></td>"+
							 "<td align='left'><input onchange='changetemplet()' style='border:none;width:100%' value='"+test_result.ic_test.test_target+"'></input></td>"+
							 "<td align='left'><input onchange='changetemplet()' style='border:none;width:100%' value='"+test_result.ic_test.test_weakness+"'></input></td>"+
							 "<td align='center' onclick='itresultchange(this)' id=''>"+test_result.test_effect+"</td>"+
							 "<td align='center' onclick='itriskchange(this)' id=''>"+test_result.test_risk+"</td></tr>";
						$('#tab tbody').append(line);
						if(data==""){
						 	
						}else{
						 	 if(i==0){//点击节点后默认选中第一行
								$test_method.attr("value",test_result.ic_test.test_method);
								$test_record.val(test_result.test_record);
								$test_result_id.attr("value",test_result.trid);
								$('#tab tbody').children("tr").eq(1).css("background","#B0C4DE");
							 } 
						 }
					});
				}
			});
		}
	};
	
	
	function changethis(){
		$("#editflag").attr("value",1);
	}
	
	function changetemplet(){
		$("#edittempletflag").attr("value",1);
	}
	
	//radio选中内控调查
	$("#invest_option").live("click", function() {
		var $big=$("#big");
		$big.css("display","none");
		var $editflag=$("#editflag");
		var $edittempletflag=$("#edittempletflag");
		var $typestatus=$("#typestatus");
		var $tab_div=$("#tab_div");
		//获得item_id
		var treeObj = $.fn.zTree.getZTreeObj("tree");
		var nodes = treeObj.getSelectedNodes();
		var $invest_id=$("#invest_id");
		
		$invest_id.attr("value","");
		$audit_id=$("#audit_id");
		$tab_div.css("height","500px");
		if($editflag.val()==1){//审计结果有过编辑
			if($typestatus.val()==1){//之前在测试(test)页面
				savetests();//保存测试结果
				$editflag.attr("value",0);//修改状态为未修改
			}else{
				return;
			}
		}
		//审计模板有过编辑
		if($edittempletflag.val()==1){
			if($typestatus.val()==1){//之前在测试(test)页面
				saveteststemplet();//保存测试结果
				$edittempletflag.attr("value",0);//修改状态为未修改
			}else{
				return;
			}
		}
		
		$typestatus.attr("value",0);//修改状态为调查
		//未选中任何节点
		if(nodes.length==0){
			//未选中任何节点清空tab
			$('#tab tbody').empty();
			
		}else{//选中节点，查询，写表头，写数据
			var item_id=nodes[0].id;
			$.ajax({
				url : "/ic/invest_result/queryInvestAndResult.do?item_id="+ item_id+"&audit_id="+$audit_id.val(),
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
						+ "<th align='center' width='50%'>调查内容</th>"
						+ "<th align='center' width='10%'>调查结果</th>"
						+ "<th align='center' width='40%'>备注</th>"
						+ "</tr>");
					$.each(data, function(i, invest_result) {
						line="<tr  onclick='click_invest_result(this)' id='"+invest_result.irid+"'>"+
							 "<td align='left' ><input onchange='changetemplet()' id='"+invest_result.ic_invest.id+"' style='border:none;width:100%' value='"+invest_result.ic_invest.invest_name+"'></input></td>"+
							 "<td align='center' id='' onclick='iiresultchange(this)'>"+invest_result.invest_result+"</td>"+
							 "<td align='left' id=''><input style='border:none;width:100%' value='"+invest_result.invest_remark+"'/></td>"+
							 "</tr>";
						$('#tab tbody').append(line);
					});
				}
			});
		};
	});
	
	//radio选中内控测试
	$("#test_option").live("click",function(){
		var $big=$("#big");
		var $typestatus=$("#typestatus");
		var $editflag=$("#editflag");
		var $edittempletflag=$("#edittempletflag");
		var $audit_id=$("#audit_id");
		var $tab_div=$("#tab_div");
		var $test_method=$("#test_method");
		var $test_record=$("#test_record");
		var $test_result_id=$("#test_result_id");
		
		$tab_div.css("height","350px");
		$big.css("display","block");
		//获得item_id
		var treeObj = $.fn.zTree.getZTreeObj("tree");
		var nodes = treeObj.getSelectedNodes();
		if($editflag.val()==1){
			if($typestatus.val()==0){
				saveinvests();
				$editflag.attr("value",0);
			}else{
				return;
			};
		}
		
		//审计模板有过编辑
		if($edittempletflag.val()==1){
			if($typestatus.val()==0){
				saveinveststemplet();
				$edittempletflag.attr("value",0);
			}else{
				return;
			};
		}
		
		$typestatus.attr("value",1);
		
		if(nodes.length==0){
			//未选中任何节点清空tab
			$('#tab tbody').empty();
		}else{
			var item_id=nodes[0].id;
			$.ajax({
				url : "/ic/test_result/queryTestAndResult.do?item_id="+ item_id+"&audit_id="+$audit_id.val(),
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
											+ "<th align='center' width='40%'>测试目标</th>"
											+ "<th align='center' width='40%'>弱点分析</th>"
											+ "<th align='center' width='10%'>运行效果</th>"
											+ "<th align='center' width='10%'>风险评估</th>"
											+ "</tr>");
					$.each(data, function(i, test_result) {
						line="<tr onclick='clicktestresult(this)' id='"+test_result.trid+"'>"+
							 "<td style='display:none'><input id='' name='' value='"+test_result.ic_test.test_method+"'></input></td>"+
							 "<td style='display:none'><input id='' name='' value='"+test_result.test_record+"'></input></td>"+
							 "<td style='display:none'><input id='' name='' value='"+test_result.ic_test.id+"'></input></td>"+
							 "<td align='left'><input onchange='changetemplet()' style='border:none;width:100%' value='"+test_result.ic_test.test_target+"'></input></td>"+
							 "<td align='left'><input onchange='changetemplet()' style='border:none;width:100%' value='"+test_result.ic_test.test_weakness+"'></input></td>"+
							 "<td align='center' onclick='itresultchange(this)' id=''>"+test_result.test_effect+"</td>"+
							 "<td align='center' onclick='itriskchange(this)' id=''>"+test_result.test_risk+"</td></tr>";
						$('#tab tbody').append(line);
						if(i==0){//点击节点后默认选中第一行
							$test_method.attr("value",test_result.ic_test.test_method);
							$test_record.val(test_result.test_record);
							$test_result_id.attr("value",test_result.trid);
							$('#tab tbody').children("tr").eq(1).css("background","#B0C4DE");
						} 
					});
				}
			});
		}
	});
	
	//点击树下方的空白取消节点选择
	$unselect_div.live("click", function() {
		var treeObj = $.fn.zTree.getZTreeObj("tree");
		var nodes = treeObj.getSelectedNodes();
		var trs=$('#tab tbody').children("tr");
		var $big=$("#big");
		var editflag=$('#editflag').val();
 		var $audit_type = $("input[name='audit_type']:checked").val();
 		if(trs.length==1||trs.length==0){//表中无数据
	 		if (nodes.length > 0) {
				treeObj.cancelSelectedNode(nodes[0]);
				$('#tab tbody').empty();
				$big.css("display","none");
			}
 			return;
 		}
 		if(editflag==0){//未修改
 			if (nodes.length > 0) {
				treeObj.cancelSelectedNode(nodes[0]);
				$('#tab tbody').empty();
				$big.css("display","none");
			}
 		}else{//有修改
 			if($audit_type==0){
 				saveinvests();
 			}else{
 				savetests();
 			};
 			$("#editflag").attr("value",0);
 			if (nodes.length > 0) {
				treeObj.cancelSelectedNode(nodes[0]);
				$('#tab tbody').empty();
				$big.css("display","none");
			}
 		}
	});
	
		//三个弹出框的"取消"按钮，点击隐藏弹出窗口
	$item_cancel.live("click", function() {
		$("#item_pop").css("display", "none");
	});
	$invest_cancel.live("click", function() {
		$("#invest_pop").css("display", "none");
	});
	$test_cancel.live("click", function() {
		$("#test_pop").css("display", "none");
	});

	$savetemplet_cancel.live("click", function() {
		$("#savetemplet_pop").css("display", "none");
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
	
	//添加表项弹出窗口的"确定"按钮，完成1：必填提示  2：根据本级/下级返回父级id 3：
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
				url : "/ic/ic_templet_item/addTemplet_Item.do",
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
	
	//调查输入框的“确认”按钮，根据输入框隐藏的id值的有无进行调查条目的增加/修改
	$("#invest_confirm").live("click", function() {
		var treeObj = $.fn.zTree.getZTreeObj("tree");
		var nodes = treeObj.getSelectedNodes();
		var $invest_pop=$("#invest_pop");
		var invest_name=$("#invest_name").val();
		var $tab=$("#tab");
		var $invest_id=$("#invest_id");
		var audit_id=$("#audit_id").val();
		
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
	
		$.ajax({
			url : "/ic/ic_invest/addInvestAndResult.do?audit_id="+audit_id,
			data : ic_invest,
			type : "post",
			dataType : "json",
			error : function() {
				window.confirm("调查内容写入失败！");
			},
			success : function(data) {
				var ic_Invest_Result=jQuery.parseJSON(data);
				//alert(ic_Invest_Result.ic_invest.id);
				//alert(data);
				//追加显示一行内控调查内容
				 $tab.append("<tr  onclick='click_invest_result(this)' id='"+ic_Invest_Result.irid+"'>"+
						 "<td align='left' ><input onchange='changetemplet()' id='"+ic_Invest_Result.ic_invest.id+"' style='border:none;width:100%' value='"+ic_Invest_Result.ic_invest.invest_name+"'></input></td>"+
						 "<td align='center' id='' onclick='iiresultchange(this)'>"+ic_Invest_Result.invest_result+"</td>"+
						 "<td align='left' id=''><input style='border:none;width:100%' value='"+ic_Invest_Result.invest_remark+"'/></td>"+
						 "</tr>"); 
			}
		});
		
		
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
		var test_method_input=$("#test_method_input").val();
		var $tab=$("#tab");
		var audit_id=$("#audit_id").val();
		
		if(!test_target){
			alert("请填写测试目标！");
			return;
		}if(!test_weakness){
			alert("请填写弱点分析！");
			return;
		}if(!test_method_input){
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
			"test_method":test_method_input
		};
		
		//invest_pop的id为空就新建项目
		$.ajax({
			url : "/ic/ic_test/addTestAndResult.do?audit_id="+audit_id,
			data : ic_test,
			type : "post",
			dataType : "json",
			error : function() {
				window.confirm("调查内容写入失败！");
			},
			success : function(data) {
				var test_result=jQuery.parseJSON(data);
				//追加显示一行内控测试test内容
				$tab.append("<tr onclick='clicktestresult(this)' id='"+test_result.trid+"'>"+
							 "<td style='display:none'><input value='"+test_result.ic_test.test_method+"'></input></td>"+
							 "<td style='display:none'><input value='"+test_result.test_record+"'></input></td>"+
							 "<td style='display:none'><input id='' name='' value='"+test_result.ic_test.id+"'></input></td>"+
							 "<td align='left'><input onchange='changetemplet()' style='border:none;width:100%' value='"+test_result.ic_test.test_target+"'></input></td>"+
							 "<td align='left'><input onchange='changetemplet()' style='border:none;width:100%' value='"+test_result.ic_test.test_weakness+"'></input></td>"+
							 "<td align='center' onclick='itresultchange(this)' id=''>"+test_result.test_effect+"</td>"+
							 "<td align='center' onclick='itriskchange(this)' id=''>"+test_result.test_risk+"</td></tr>");
			}
		});
		
		//最后应清空id值和内容栏
		$("#test_id").attr("value","");
		$("#test_target").attr("value","");
		$("#test_weakness").attr("value","");
		$("#test_method_input").attr("value","");
		$("#test_pop").css("display","none");
	});
	
	//获得选中的节点和其下的所有子节点
	function getAllChildrenNodes(node,result){
		result.push(node.id);
		if(node.isParent){
			var childrenNodes=node.children;
			if(childrenNodes){
				for(var i=0;i<childrenNodes.length;i++){
					//result.push(childrenNodes[i].id);
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
				url : "/ic/ic_templet_item/deleteItemCascade.do",
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
					$('#big').css("display","none");
				}
			});
	});
	
	//另存模板按钮
	$("#savenewtemplet").live("click",function(){
		var $savetemplet_pop=$("#savetemplet_pop");
		var $templet_name_input=$("#templet_name_input");
		var $templet_name=$("#templet_name");
		
		if ($savetemplet_pop[0].style.display == "none") {
			$savetemplet_pop.css("display", "block");
			$templet_name_input.focus();
			$templet_name_input.attr("value","Copy of "+$templet_name.val());
		} else {
			$savetemplet_pop.css("display", "none");
		}
	});
	
	//另存模板弹出框的确认按钮
	$("#savetemplet_confirm").live("click",function(){
		var templet_name_input=$("#templet_name_input").val();
		var ic_templet_id=$("#templet_id").val();
		var $savetemplet_pop=$("#savetemplet_pop");
		
		$.ajax({
			url : "/ic/templet/copyIctempletToTemplet.do?templet_id="+ic_templet_id+"&templet_name="+templet_name_input,
			type : "post",
			dataType : "json",
			async:false,
			error : function() {
				window.confirm("另存模板错误！");
			},
			success : function(data) {
				$savetemplet_pop.css("display","none");
			}
		});
	});
	
</script>
</head>
<body style="">
	<div class="sidebar" style="float:left;width:130px;min-height:595px;border-right:1px solid #ccc;">
		<div id="tree_div" style="background-color:#f2f2f2;height:40px;padding:0 10px 0 10px;">
			<ul>
				<li style="height:30px;line-height:30px"><a href="#"
					style="height:40px;padding:13px 5px 0 5px;">
					<font size="3" color="#333">表项</font></a>
					<ul  id="tree" style="margin:10px 0 0 0" class="ztree"></ul></li>
			</ul>
		</div>
		<div id="unselect_div" style="height:auto;height:300px;min-height:300px;"></div>
	</div>

	<div class="add_button">
		<form action="#" method="post">
			<table class="search-tab">
				<tr>
					<th width="50"></th>
					<th id='audit_name' style='text-align:left;font-size:20px;color:#D2691E;font-weight:bold;'  width="100"></th>
					<th width="90"><input id="savethis" type="button" 
						style="width:85px" class="btn btn-primary btn4" name=""
						value="保存" /></th>
					<th width="90"><input id="savenewtemplet" type="button"
						style="width:85px" class="btn btn-primary btn4" name=""
						value="模板另存" /></th>
					<th width="30"></th>
					<th width="90"><input id="additem" type="button"
							style="width:85px" onclick="" class="btn btn-primary btn4"
							value="增加表项" /></th>
					<th width="90"><input id="deleteitem" type="button" style="width:85px"
						class="btn btn-primary btn4" name="" value="删除表项" /></th>
					<th width="90"><input id="addline" type="button"
						style="width:85px" class="btn btn-primary btn4" name=""
						value="增加表行" /></th>
					<th width="90"><input id="deleteline" type="button"
						style="width:85px" class="btn btn-primary btn4" name=""
						value="删除表行" /></th>
					<th width="350">
            			<a id='a1' href="${pageContext.request.contextPath}/ic_user/logout.do" ><u>注销</u></a>
            		</th>
				</tr>
			</table>
		</form>
	</div>

	<div class="result-title" style="line-height: 30px;overflow: hidden;">
		<div class="result-list" style="padding:10px 0 5px 2%;border-bottom:2px solid #ccc;">
			<label><input id="invest_option" name="audit_type" type="radio" checked="checked" value="0"/>
				<font size='4'>内控调查</font></label> 
			<label><input id="test_option" name="audit_type" type="radio" value="1" />
				<font size='4'>内控测试</font></label>
		</div>
		
		<div id="cover_dad" style="position:relative">
				<!-- 内控表项输入窗口 -->
				<div id="item_pop"
					style="z-index:999;position:fixed;top:40;display:none;background:#ffffff;
						margin:0 50% 0 25%;width:400px;height:170px;border:3px solid #ccc;padding:10 auto">
					<div id="type_head"></div>
					<form>
						<table align="center">
							<tr>
								<td><label><input name="level" type="radio"
										value="0" checked="checked" /><font size='4'>本级</font></label></td>
								<td><label><input name="level" type="radio"
										value="1" /><font size='4'>下级</font></label></td>
							</tr>
							<tr>
								<td><input type="hidden" id="parent_id"
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
				
				<!-- 另存模板名称输入框 -->
				<div id="savetemplet_pop"
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
								<td><font size="3">模板名称：</font></td>
								<td></td>
							</tr>
							<tr>
								<td colspan="2"><input size="30" name="templet_name_input"
									value="" id="templet_name_input" type="text" /></td>
							</tr>
							<tr>
								<td height="10px"></td>
								<td></td>
							</tr>
							<tr>
								<td><input id="savetemplet_confirm" type="button" style="width:85px" 
									class="btn btn-primary btn4" name="" value="确定" onclick="" /></td>
								<td><input id="savetemplet_cancel" type="button" style="width:85px"
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
								<td colspan="2"><textarea id="test_method_input" rows="10"
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
		
		<div id="main_div" style="min-height:600px;">
			<div id='tab_div'  style="height:380px;overflow-y:scroll;">
				<table id="tab" border="1" style="margin:10px 10% 0 20px;line-height:20px;width:90%;">
					<tbody>
					</tbody>
				</table>
			</div>
			<div id='big' style="height:250px;display:none;">
				<div style="float:left;width:50%;">
					<table style="width:100%;height:200px;background:#ccc;border:1">
						<thead><tr>
							<th align="center" >内控测试方法</th></tr></thead>
						<tbody>
						<tr style="display:none">
							<td><input  id="audit_id" name="audit_id" value='${audit_id}'></input></td>
							<td><input id="templet_id" name="templet_id" value='${templet_id}'></input></td>
							<td><input id="templet_name" name="templet_name" value=''></input></td>
							<td><input id="editflag" name="editflag" value=''></input></td>
							<td><input id="edittempletflag" name="edittempletflag" value=''></input></td>
							<td><input id="typestatus" name="typestatus" value=''></input></td></tr>
						<tr style="display:none">
							<td><input id="invest_result_id" name="" value=''></input></td>
							<td><input id="test_result_id" name="" value=''></input></td></tr>
						<tr>
							<td><textarea id="test_method" onchange='changetemplet()' style="width:100%;background:#B4CDCD;
							height:100%;overflow-y:auto" class="text"></textarea></td>
						</tr>
						</tbody>
					</table>
				</div>
				<div style="float:right;width:50%">
					<table style="width:100%;height:200px;background:#ccc;" >
						<thead><tr>
							<th align="center" >内控测试记录</th></tr></thead>
						<tbody>
							<tr>
								<td><textarea onchange='changethis()' id="test_record"  style="width:100%;
								height:100%;overflow-y:auto" class="text"></textarea></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
