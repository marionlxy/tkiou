<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<%@ include file="/include.jsp"%>
<link href="<%=basePath%>/static/css/login.css" rel="stylesheet"
	type="text/css" />

<title>欢迎登陆</title>
</head>
<script type="text/javascript">
if(window!=top){
    top.location = "${rootPath}/login";
}

$(function(){         
    $('#kaptchaImage').click(function () {
     //生成验证码  
     $(this).hide().attr('src', './ValidateCodeServlet/Validate.png?' + Math.floor(Math.random()*100) ).fadeIn();  
     event.cancelBubble=true;  
    });  
});

function changeCode() {  
    $('#kaptchaImage').hide().attr('src', './ValidateCodeServlet/Validate.png?' + Math.floor(Math.random()*100) ).fadeIn();  
    event.cancelBubble=true;  
}
</script>

<body>
	<div class="second_body">
		<div class="logo">
			<img src="<%=basePath%>/static/images/login/logo.png" />
		</div>
		<div class="title-zh">后台管理系统</div>
		<div class="title-en"></div>

		<div class="message">
			<label id="loginError" class="error"></label>
		</div>
		<div>
			<table border="0" style="width: 300px;">
				<tr>
					<td style="padding-bottom: 5px; width: 55px;">用户名：</td>
					<td colspan="2"><input class="login easyui-textbox"
						name="usernamepro" value="" id="usernamepro"
						data-options="prompt:'登陆用户名',iconCls:'icon-man',iconWidth:35,required:true">
					</td>
				</tr>
				<tr>
					<td class="lable"
						style="letter-spacing: 0.5em; vertical-align: middle">密码：</td>
					<td colspan="2"><input class="login easyui-textbox"
						name="passwordpro" value="" id="passwordpro" type="password"
						data-options="prompt:'登陆密码',iconCls:'icon-lock',iconWidth:25,required:true"></td>
				</tr>
				<tr>
						<td style="padding-bottom: 5px; width: 55px;">验证码:</td>
						<td colspan="2"><input name="validateCode" id="validatecodepro"
							maxlength="4" class="login easyui-textbox"
							data-options="prompt:'验证码',iconCls:'icon-vector_key',iconWidth:25,required:true" />
							<img src="./ValidateCodeServlet/Validate.png" id="kaptchaImage"
							style="margin-bottom: -3px" /> <a href="#" onclick="changeCode()">看不清?换一张</a>
						</td>
					</tr>
				<tr>
					<td></td>
						<td colspan="2">
						<form id="loginForm" method="post" action="${rootPath}/j_spring_security_check">
							<input type="hidden" name="rememberMe" id="rememberMe"/>
							<input type="hidden" name="j_username" id="username"/>
							<input type="hidden" name="j_password" id="password"/>
							<input type="hidden" name="validateCode" id="validatecode"/>
						</form>
					</td>
				</tr>
				<tr>
					<td colspan="3" style="text-align: center"><input type="submit"
						value="登录" class="login_button" id="login" onclick="loginAction()" />
						<input type="button" value="重置" class="reset_botton"
						onclick="resetClick()" /></td>
				</tr>
			</table>
		</div>
	</div>
	<script type="text/javascript">
$(function(){
	$('#username').textbox('textbox').focus();	
});

document.onkeydown = function(e){
    var event = e || window.event;  
    var code = event.keyCode || event.which || event.charCode;
    if (code == 13) {
    	loginAction();
    }
}

this.resetClick = function () {
	 $('#loginForm').form('clear');
};


function loginAction() {
	var r = $('#loginForm').form('validate');
	if (!r) {
		return false;
	} else {
		if ($("#remember").is(":checked")) {
			$("#rememberMe").val("true");
		} else {
			$("#rememberMe").val("false");
		}
		var username = encode64($("#usernamepro").val()); //对数据加密
		var password = encode64($("#passwordpro").val());
		var validateCode = encode64($("#validatecodepro").val());
		
		$("#username").val(username);
		$("#password").val(password);
		$("#validatecode").val(validateCode);
		
		$("#loginForm").submit();
	}
}
</script>
</html>