<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resources/jsp/taglibs.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>404错误 - ${config.title}</title>
<link href="<%=basePath%>/resources/style/system/front/default/css/public.css" type="text/css" rel="stylesheet"/>
<link href="<%=basePath%>/resources/style/system/front/default/css/index.css" type="text/css" rel="stylesheet"/>
<link href="<%=basePath%>/resources/style/system/front/default/css/error.css" type="text/css" rel="stylesheet"/>
<script src="<%=basePath%>/resources/js/jquery-1.6.2.js"></script>
</head>
<body>
<jsp:include page="./top.jsp"/>
<div class="main">
  <jsp:include page="./head.jsp"/>
  <jsp:include page="./nav.jsp"/>
  <div class="index">
    <div class="index2">
      <div class="errorpage">
        <div class="errortop"></div>
        <div class="errordex">
          <div class="pagertop">
            <h1>出错404咯！</h1>
            <p><span>抱歉，您输入的网页无法前往，您可以通过以下方式获得支持：</span></p>
            <p><span>1、登录<a href="" target="_blank">泰康官方网站</a>，提交您的问题所在;</span></p>
            <p><span>2、登录<a href="" target="_blank">泰康官方论坛</a>，提交您的问题所在;</span></p>
          </div>
          <div class="errp">
            <div class="errpbox">
              <div class="errorimg"><img src="<c:url value="/resources/style/system/front/default/images/error/error404.jpg"/>" width="150" height="220" /></div>
              <div class="errorback"><a href="<c:url value="/index.htm"/>">返回首页</a></div>
            </div>
          </div>
        </div>
        <div class="errorbtom"></div>
      </div>
    </div>
  </div>
  <script>
	  var count=3;
	  window.setInterval(go,1000);
	  function go(){
	    count--;
	    if(count==0) window.location.href="<c:url value="/index.htm"/>";
	  }
  </script>
  <jsp:include page="./footer.jsp"/>
</div>
</body>
</html>