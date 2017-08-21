<%@ page language="java" import="java.util.*" pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <meta http-equiv="Content_Type" content="text/html;charset=UTF-8"/>
    <title>内控管理</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main.css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/script/jquery.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/libs/modernizr.min.js"></script>
	<script>
		$(document).ready(function() {
			var $create_id=$("#create_id");
			$create_id.attr("value",getUrlParam('create_id'));
		});
		
		$("#a1").live("click",function(){
			var create_id=$('#create_id').val();
			$("#a1").attr('href','/ic/templet/queryAllTemplet.do?templet=false&create_id='+create_id+'');
		});
		
		$("#a2").live("click",function(){
			var create_id=$('#create_id').val();
			$("#a2").attr('href','/ic/ic_audit/queryAllAudit.do?create_id='+create_id+'');
		});
		
		function getUrlParam(name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
            var r = window.location.search.substr(1).match(reg);  //匹配目标参数
            if (r != null) return unescape(r[2]); return null; //返回参数值
        }
        
	</script>

</head>
<body style="overflow-x:hidden;overflow-y:hidden">

<div class="container clearfix">
    <div class="sidebar-wrap">
        <div class="sidebar-title">
            <h1>菜单</h1>
        </div>
        <div class="sidebar-content">
            <ul class="sidebar-list">
                <li>
                    <a href="#"><i class="icon-font">&#xe003;</i>系统功能</a>
                    <input type='hidden' id='create_id' value=''/>
                    <ul class="sub-menu">
                        <li><a id='a1' href="" target="iframe"><i class="icon-font">&#xe008;</i>新建项目</a></li>
                        <li><a id='a2' href="" target="iframe"><i class="icon-font">&#xe005;</i>项目实施</a></li>
                        <li><a href="${pageContext.request.contextPath}/templet/queryAllTemplet.do?templet=true" target="iframe"><i class="icon-font">&#xe006;</i>模板管理</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
    <!--/sidebar-->
    <div class="main-wrap">
       <div class="crumb-wrap">
            <div class="crumb-list">
            	<span class="crumb-step" style=" font-weight:bold;width:100px;  line-height:20px; text-align:center; float:right;padding:10px 20px 0 0;">
            		<a id='a1' href="${pageContext.request.contextPath}/ic_user/logout.do" ><u>注销</u></a>
            	</span></div>
       </div> 
       

        <div class="result-content">
            <form name="myform" id="myform" method="post">
                <div class="result-list" style="height:100%">
                   <iframe id="iframe" name="iframe" class="result-content" frameborder="0" 
                   width="100%" height="1000px" ></iframe>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>