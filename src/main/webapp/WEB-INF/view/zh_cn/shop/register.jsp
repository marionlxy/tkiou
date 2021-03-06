<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resources/jsp/taglibs.jsp"%>
<html>
<title>用户注册 </title>
<link href="${webPath}/resources/style/system/front/default/css/public.css" type="text/css" rel="stylesheet" />
<link href="${webPath}/resources/style/system/front/default/css/goods.css" type="text/css" rel="stylesheet" />
<link href="${webPath}/resources/style/system/front/default/css/index.css" type="text/css" rel="stylesheet" />
<script src="${webPath}/resources/js/jquery-1.6.2.js"></script>
<script src="${webPath}/resources/js/jquery.validate.min.js"></script>
<script>
jQuery(document).ready(function(){
 //
 jQuery.validator.addMethod("verify",function(value,element){
	    var re =  /^([0-9a-zA-Z]|[\u4E00-\u9FA5])+$/;
        if(re.test(jQuery("#userName").val())){			
			return true;
		  } 
		  else {
		    return false;
			  }		  
});
 jQuery("#theForm").validate({				 
     errorPlacement:function(error, element) {
	   element.parent().parent("td").next("td").html("");
       error.appendTo(element.parent().parent("td").next("td"));  
      },
	  rules:{
	    userName:{
		  required:true,
		  verify:true,
          remote:{
		    url: "${webPath}/verify_username.htm",     //后台处理程序
            type: "post",               //数据发送方式
            dataType: "json",           //接受数据格式   
            data: {                     //要传递的数据
                  "userName": function(){return jQuery("#userName").val();}
		     }
			}
		},
        password:{
		  required:true,
		  minlength:6,
		  maxlength:20  
		},
		repassword:{
		  required:true,
		  equalTo:"#password" 
		},
		email:{
		  required:true,
		  email:true,
		  remote:{
		    url: "${webPath}/verify_email.htm",     //后台处理程序
            type: "post",               //数据发送方式
            dataType: "json",           //接受数据格式   
            data: {                     //要传递的数据
                  "email": function(){return jQuery("#email").val();}
		     }
		  }
		},
		agree:{
		  required:true
		}
		<c:if test="${config.securitycoderegister == 1}">
			,code:{
			  required:true,
			  remote:{
			    url: "${webPath}/verify_code.htm",     //后台处理程序
	            type: "post",               //数据发送方式
	            dataType: "json",           //接受数据格式   
	            data: {                     //要传递的数据
	                  "code": function(){return jQuery("#code").val();}
			     }
			  }
			}
		</c:if>
	  },
	  messages:{
	    userName:{
		  required:"用户名不能为空",
		  verify:"不可使用特殊字符",
		  remote:"用户名已存在"
		},
        password:{
		  required:"密码不能为空",
		  minlength:"密码不能小于{0}个字符",
		  maxlength:"密码不能大于{0}个字符" 
		},
		repassword:{
		  required:"重复密码不能为空",
		  equalTo:"两次输入密码不一致"
		},
		email:{
		  required:"email不能为空",
		  email:"email格式不正确",
		  remote:"该email已经存在"
		},
		agree:{
		  required:"请接受用户协议"
		}
		<c:if test="${config.securitycoderegister == 1}">
		,code:{
			  required:"验证码不能为空",
			  remote:"验证码不正确"
			}
		</c:if>
	  }
	});
 //
});
</script>
</head>
<body>
  <jsp:include page="./top.jsp"/>
<div class="main">
  <jsp:include page="./head.jsp"/>
  <jsp:include page="./nav.jsp"/>
  <div class="index">
    <div class="index2">
      <div class="login_user">
        <div class="login_user_left">
          <div class="login_user_in">
            <h1>用户注册<span>REGISTER</span></h1>
            <h2>填写用户注册信息</h2>
            <div class="login_user_bottom">
              <form action="${webPath}/register_finish.htm" method="post" name="theForm" id="theForm">
                <table width="500" border="0" cellspacing="0" cellpadding="0" class="user_zc_table">
                  <tr>
                    <td width="95" class="login_nameu">用户名：</td>
                    <td width="200"><span class="login_user_input input_size">
                      <input name="userName" type="text" id="userName" />
                      </span></td>
                    <td class="login_nameu2">登录用户名</td>
                  </tr>
                  <tr>
                    <td class="login_nameu">密码：</td>
                    <td><span class="login_user_input input_size">
                      <input name="password" type="password" id="password"/>
                      </span></td>
                    <td class="login_nameu2">登录密码,6位以上字母数组组合，不区分大小写</td>
                  </tr>
                  <tr>
                    <td class="login_nameu">确认密码：</td>
                    <td><span class="login_user_input input_size">
                      <input name="repassword" type="password" id="repassword" />
                      </span></td>
                    <td class="login_nameu2">再次输入您的密码</td>
                  </tr>
                  <tr>
                    <td class="login_nameu">电子邮件：</td>
                    <td><span class="login_user_input input_size">
                      <input name="email" type="text" id="email" />
                      </span></td>
                    <td class="login_nameu2">录入后不可修改</td>
                  </tr>
                  
                  <c:if test="${config.securitycoderegister == 1}">
                  	<tr>
	                 <td class="login_nameu">验证码：</td>
	                 <td>
	                    <span class="login_user_input input_size2">
	                      <input name="code" type="text" id="code" style="text-transform:uppercase;"/>
	                    </span>
	                    <span class="yzm" <c:if test="${config.securitycodetype=='voice'}">style="display:none;"</c:if>>
	                     	<img style="cursor:pointer;" src="${webPath}/verify.htm" id="code_img" onclick="refreshCode();" width="59" height="27" />
	                    </span>
					</td>
                    <td class="login_nameu2">点击图片更新验证码</td>
                   </tr>
                   <script>
					  function refreshCode(){
						jQuery("#code_img").attr("src","${webPath}/verify.htm?d"+new Date().getTime());
					  }
				   </script>
                  </c:if>
                  
                 <tr>
                    <td>&nbsp;</td>
                    <td class="login_nameu2"><span>
                    <input name="agree" type="checkbox" id="agree" value="true"  />
                      <label for="agree">  &nbsp;我已阅读并同意&nbsp;</label>                      
                      <a href="${webPath}/doc_agree.htm" target="_blank" class="s_red">用户服务协议</a></span></td>
                    <td></td>
                 </tr>
                 <tr>
                    <td>&nbsp;</td>
                    <td><span class="login_user_btn_free">
                      <input name="save" type="submit" id="save" style="cursor:pointer;" value=""/>
                      </span></td>
                    <td>&nbsp;</td>
                 </tr>
                </table>
              </form>
            </div>
          </div>
        </div>
        <div class="login_user_right">
          <h1 class="login_user_h">Taikang提示</h1>
          <h2 class="login_user_h2">所有会员享受</h2>
          <ul class="login_user_ul">
           	<li><span class="login_user_span"><img src="${imageWebServer}/resources/style/system/front/default/images/user3.jpg" width="25" height="25" /></span><span class="login_user_span2">免费开设店铺销售商品</span></li>
            <li><span class="login_user_span"><img src="${imageWebServer}/resources/style/system/front/default/images/user1.jpg" width="25" height="25" /></span><span class="login_user_span2">提交完善您的个人资料</span></li>
            <li><span class="login_user_span"><img src="${imageWebServer}/resources/style/system/front/default/images/user4.jpg" width="25" height="25" /></span><span class="login_user_span2">在线购买商城任意商品</span></li>
          </ul>
          <h1 class="login_user_h">如果已经拥有账户</h1>
          <div class="login_sys"> <span class="login_user_free"><a href="${webPath}/user/login.htm"><img src="${imageWebServer}/resources/style/system/front/default/images/loginde.jpg" width="98" height="32" border="0" /> </a></span>
          </div>
           <c:if test="${config.sinaLogin == 1 || config.qqLogin == 1}">
           		<h1 class="login_user_h2">使用其他账户登录：</h1>
	       		<div class="login_sys2">
	       		    <c:if test="${config.qqLogin == 1}">
	       		    	<span class="login_qq">
		       				<a href="${webPath}/qq_login_api.htm">
		       				   <img src="${imageWebServer}/resources/style/system/front/default/images/userqq.jpg" width="101" height="24" />
		       				</a>
		       			</span>
	       		    </c:if>
	       		    <c:if test="${config.sinaLogin == 1}">
	       		    	<span class="login_wb">
	       					<a href="${webPath}/sina_login_api.htm">
	       						<img src="${imageWebServer}/resources/style/system/front/default/images/wb.jpg" width="101" height="24" />
	       					</a>
	       				</span>
	       		    </c:if>
	       		</div>
          </c:if>
	       
        </div>
      </div>
    </div>
  </div>
  <jsp:include page="./footer.jsp"/>
</div>
</body>
</html>
