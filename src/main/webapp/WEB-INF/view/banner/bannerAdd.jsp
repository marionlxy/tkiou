<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7">
	<meta http-equiv="expires" content="0">
	<%@ include file="/include.jsp"%>
    <title></title>
</head>
<body>
	<form id="dataForm" enctype="multipart/form-data" method="post">
	        <input type="hidden" name="banImgId">
			<div class="fitem">
		    	<label>类别:</label>
		        <input name="banType" class="easyui-textbox" data-options="required:true" >
			</div>
			<div class="fitem">
		    	<label>标题:</label>
		        <input name="banImgName" class="easyui-textbox" data-options="required:true">
			</div>
			<div class="fitem">
		    	<label>排序号:</label>
		        <input name="banImgNum" class="easyui-textbox" data-options="required:true">
			</div>
		    <div class="fitem">
		     	<label>描述:</label>
		        <textarea name="banImgDes" rows="5" calss="easyui-validatebox"  data-options="required:true" style="width:346px;border:1px solid #ffa8a8;border-radius:5px;"></textarea>
			</div>
			  <div class="fitem">
		     	<label>链接地址:</label>
		        <input name="banImgOutside" class="easyui-textbox" data-options="required:true">
			</div>
			  <div class="fitem">
		     	<label>图片:</label>
		        <input name="modBanner"  class="easyui-filebox">
			</div>
			
			</form>
    <div id="dlg-buttons" align="center">
       <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" id="save" onclick="saveOrUpdate()" style="width:90px">提交</a>
       <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="goBack(0)" style="width:90px">取消</a>
   </div>
    
<script type="text/javascript">

var banImgId;
jQuery(function(){
	jQuery.ajaxSetup({
		cache : false
	});
	$(".textbox-invalid").css("width","350px");
	$(".textbox-invalid").find("input").css("width","342px");
	//$(".fitem").find("textarea").css("width","342px");
	banImgId ='${banImgId}';
	
	if (banImgId != null && banImgId != "" && banImgId!=0){
		var url='${rootPath}/banner/getOne?banImgId=' + banImgId;
		$('#dataForm').form('load', url);
	}
});


//保存记录
function saveOrUpdate(){
	var r = $('#dataForm').form('validate');
	if(!r) {
		return false;
	}else
	{
		$('#dataForm').form(
				'submit',
				{
					url:'${rootPath}/banner/save',
					onSubmit : function() {
						$("#dataForm").serializeArray();
					},
					success : function(a) {
						//alert(data);
						
						console.log(a);
						ajaxobj = eval("(" + a + ")");
						//console.log(ajaxobj)
						if (ajaxobj.result == 'true'|| ajaxobj.result == true) {
							//$.messager.alert('提示', ajaxobj.msg);
							$('#save').linkbutton('disable');
						} else {
							//$.messager.alert("提示", ajaxobj.msg, 'error');
						}
					}
				});
	}
}
 
//返回父页面  
function goBack(flag){
	var url = '/banner/list';
	window.parent.wrapper.tabCloseOne();
	window.parent.searchInfo();
}
</script>

</body>
</html>
