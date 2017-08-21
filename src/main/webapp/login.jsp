<%@ page language="java" import="java.util.*" pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <meta http-equiv="Content_Type" content="text/html;charset=UTF-8"/>
    <title>内控管理登录</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/script/jquery.js"></script>
</head>
<body class="login">
<div class="login_m">
	<div class="login_boder">
		<div class="login_padding">
			<form id='inforinput' action="${pageContext.request.contextPath}/ic_user/login.do" method="post">
				<h2>用户名</h2>
				<label>
					<input type="text" name="username" class="txt_input"  placeholder="用户名" value=""/>
				</label>
				<h2>密码</h2>
				<label>
					<input type="password" name="password" class="txt_input"  placeholder="密码" value=""/>
				</label>
				<div class="rem_sub">
				<p class="forgot"></p>
					<label>
						<input type="submit" class="sub_button" name="button" id="button" value="登录" style="opacity: 0.7;"/>
					</label>
				</div>
			</form>
		</div>
	</div><!--login_boder end-->
</div><!--login_m end-->

<br />
<br />
</body>
</html>