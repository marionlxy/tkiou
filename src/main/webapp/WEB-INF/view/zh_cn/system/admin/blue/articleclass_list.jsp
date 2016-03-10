<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/resources/jsp/taglibs.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<link href="${webPath}/resources/style/system/manage/${config.websitecss}/template.css"  rel="stylesheet" type="text/css"/>
<script src="${webPath}/resources/js/jquery-1.6.2.js"></script>
<script src="${webPath}/resources/js/jquery.validate.min.js"></script>
<script src="${webPath}/resources/js/jquery.shop.common.js"></script>
<script src="${webPath}/resources/js/jquery.poshytip.min.js"></script>
<script>
function addorsubtract(obj,id){
 var cls=jQuery(obj).attr("cls");
 var level=jQuery(obj).attr("level");
  if(cls=="jian"){
  jQuery.ajax({type:'POST',
		       url:'${webPath}/admin/articleclass_data.htm',
		        data:{"pid":id},
				success:function(data){
	                jQuery("#"+id).after(data);
					jQuery(obj).attr("src","${webPath}/resources/style/system/manage/blue/images/add.jpg");
					jQuery(obj).attr("cls","add");
              }
  });
  }else{
       if(level=="0_"+id){
	    jQuery("tr[level=child_"+id+"]").remove();
	   }else
	   jQuery("tr[parent="+id+"]").remove();
	   jQuery(obj).attr("src","${webPath}/resources/style/system/manage/blue/images/jian.jpg");
	   jQuery(obj).attr("cls","jian");
  }
}
function ajax_update(id,fieldName,obj){
   var val=jQuery(obj).val();
    jQuery.ajax({type:'POST',
	              url:'${webPath}/admin/articleclass_ajax.htm',
				  data:{"id":id,"fieldName":fieldName,"value":val},
				beforeSend:function(){
				  
				},
			   success:function(data){
	             if(val==""){
				   jQuery(obj).attr("src","${webPath}/resources/style/system/manage/blue/images/"+data+".png");
				 }else{
				   jQuery(obj).val(val);
				 }      
              }
	    });
}

</script>
</head>
<body>
<div class="cont">
  <h1 class="seth1">文章分类</h1>
  <div class="settab"><span class="tab-one"></span> <span class="tabs"> <a href="${webPath}/admin/articleclass_list.htm"  class="this">管理</a> | <a href="${webPath}/admin/articleclass_add.htm">新增</a></span> <span class="tab-two"></span></div>
   <div class="classtable">
  <FORM name="ListForm" id="ListForm"  action="${webPath}/admin/articleclass_list.htm" method=post>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="class_table" style="font-size:12px">
      <tr style="background: #2A7AD2;height:30px; color:#FFF">
        <td width="71">&nbsp;</td>
        <td width="118">排序</td>
        <td width="706" align="left">分类名称</td>
        <td width="180" align="left">操作</td>
      </tr>
      
      <c:forEach var="obj" items="${objs}">
	      <tr id="${obj.id}">
		    <td align="center">                              
		       <input name="ids" id="ids" type="checkbox" value="${obj.id}"/>
		    </td>
	        <td colspan="2" align="center">
	         <ul class="addclass">
	          <li class="ac1">
	            <input name="addorsubtract_${obj.id}" id="addorsubtract_${obj.id}" type="hidden" value="true" />
	            <img src="${webPath}/resources/style/system/manage/blue/images/jian.jpg" cls="jian" level="0_${obj.id}" width="14" height="14" id="jian_${obj.id}" onclick="addorsubtract(this,${obj.id});" style="cursor:pointer;"/> 
	          </li>
	          <li class="ac2">
	            <span class="num">
	             <input type="text" name="${obj.sequence}" id="${obj.sequence}"  value="${obj.sequence}"  onblur="ajax_update('${obj.id}','sequence',this)" title="可编辑"/>
	            </span>
	          </li>
	          <li class="ac3">
	            <span class="classies">
	             <input type="text" name="${obj.id}" id="${obj.id}" value="${obj.classname}" onblur="ajax_update('${obj.id}','classname',this)"  title="可编辑"/>
	            </span> 
	            <span class="newclass"><a href="${webPath}/admin/articleclass_add.htm?pid=${obj.id}">新增下级</a></span></li>
	         </ul>
	        </td>
	        <td align="left" class="ac8">
	           <a href="${webPath}/admin/articleclass_edit.htm?id=${obj.id}&currentPage=${currentPage}">编辑</a>
	            |<a href="javascript:void(0);" onclick="if(confirm('删除分类会同时删除该分类的所有下级，是否继续?'))window.location.href='${webPath}/admin/articleclass_del.htm?mulitId=${obj.id}&currentPage=${currentPage}'">删除</a>
	        </td>
	      </tr>
      </c:forEach> 
      
      <tr style="background:#F2F2F2; height:30px;">
		<td align="center"><input type="checkbox" name="all" id="all" value="" onclick="selectAll(this)"/></td>
        <td colspan="2" align="center" class="sall"><span class="classall">全部</span><span class="shop_btn_del" id="alldel">
          <input name="input" type="button" value="删除" style="cursor:pointer;" onclick="cmd('${webPath}/admin/articleclass_del.htm')"/>
          </span></td>
        <td>&nbsp;</td>
      </tr>   
    </table>
	  <input type="hidden" name="currentPage" id="currentPage" value="${currentPage}"/>
	  <input name="mulitId" type="hidden" id="mulitId" />
	  <div class="fenye"> ${gotoPageFormHTML}</div>	 
   </FORM>
  </div>  
</div>
</body>
</html>