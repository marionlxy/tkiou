<%@ include file="/resources/jsp/taglibs.jsp"%>
<script>
jQuery(document).ready(function(){
			//滚动条滚动事件
	jQuery(window).scroll(function(){
	var top = jQuery(document).scrollTop();
	if(top==0){
		jQuery(".back_box").hide();
		}else{
		jQuery(".back_box").show();	
			}
	});						
});
</script>
<div class="footer">
  <ul>
    <li>
    	<c:forEach var="nav" items="${navs}" varStatus="idxStatus">
    		<c:set var="url" value="nav.url"></c:set>
    		<c:choose>
	  			<c:when test="${fn:indexOf(url, 'http://') != -1}">
	  				<a href="${url}" id="${nav.id}" <c:if test="${nav.newWin==1}"> target="_blank"</c:if>>${nav.title}</a>
	  			</c:when>
	  			<c:otherwise>
	  				<a href="<c:url value="${url}"/>" id="${nav.id}" <c:if test="${nav.newWin==1}"> target="_blank"</c:if>>${nav.title}</a>
	  			</c:otherwise>
	  		</c:choose>
	  		<c:if test="${!idxStatus.last}">|</c:if>
    	</c:forEach>
    </li>
    <li class="hui2">Copyright 2016-2020 Taikang Inc. All Rights Reserved</li>
    <li class="hui2">Powered by Taikang V1.0</li>
   <%--  <li>${config.codeStat}</li> --%>
  </ul>
</div>


<!--返回最顶部-->
<div class="back_box"  style=" display:none;width:50px; height:50px;position:fixed; bottom:180px; right:25px; _position:absolute;/*兼容IE6的代码*/
_bottom:auto;/*兼容IE6的代码*/
_top:expression(eval(document.documentElement.scrollTop+document.documentElement.clientHeight-this.offsetHeight-(parseInt(this.currentStyle.marginTop,10)||0)-(parseInt(this.currentStyle.marginBottom,10)||0))); ">
    <div class="back_index">
    	<a href="<c:url value="/index.htm"/>" target="_blank"  title="返回主页"></a>
    </div>
    <div class="back_top"><a id="toTop" href="#" bosszone="hometop" style="display: block;" onclick="window.scrollTo(0,0);return false" title="返回顶部" target="_self" ></a>
    </div>
</div>