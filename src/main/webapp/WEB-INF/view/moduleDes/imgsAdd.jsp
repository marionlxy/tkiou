<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">
	<%@ include file="/include.jsp"%>
    <title></title>
</head>
<body>
<div class="easyui-panel">
	<form id="dataForm1"  name="dataForm1"
			action="${rootPath}/banner/uploadBySpringGrpBanner"
			method="post" enctype="multipart/form-data">
			
			<!-- <input  name="banImgId" id="hidSId" type="hidden"> -->
			<input  name="banImgId" id="banImgId" type="hidden" value="">
			<input  name="banId" id="banId" type="hidden">
			
			<div class="fitem">
		    	<label>排序权重:</label>
		        <input name="banImgNum" id="banImgNum" class="easyui-textbox" data-options="required:true">
			</div>
			<div class="fitem">
		    	<label>图片:</label>
		        <input name="banImgUrl" type="file" id="">
			</div>
		
			</form>
    <div id="dlg-buttons" align="center">
       <!-- 页面按钮有无权限控制 -->
          <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" id="save" onclick="saveOrUpdate()" style="width:90px">提交</a>
       <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="goBackFromAdd()" style="width:90px">取消</a>
   </div>
</div>
    
    
<script type="text/javascript">


	var rowId;
	jQuery(function(){ 
		rowId ='${rowId}';
		
		if (rowId != null && rowId != "" && rowId!=0){
			var url='${rootPath}/banner/getOne?rowId=' + rowId;
			$('#dataForm1').form('load', url);
		}
	});


	/**
	 * 保存记录新增用户<br/>
	 */
	function saveOrUpdate() {
		var r = $('#dataForm1').form('validate');
		if (!r) {
			return false;
		} else {
			$('#save').linkbutton('disable');
			$.post("${rootPath}/banner/saveBannerImg", $("#dataForm1").serializeArray(), 
				function(data) {
				if (data.result == 'true' || data.result == true) {
					
// 					alert("data+++=:  "+data.sId);
					$("#banImgId").val(data.sId);
// 					alert("banImgId:  "+$("#banImgId").val());
					document.dataForm1.submit();
					
					$.messager.alert("success", data.msg);
					goBack(1);
				} else {
					$.messager.alert("error", data.msg);
				}
			});
		}
	}

	function goBackFromAdd() {
		$("#divDialog").window('close');
	}
</script>

</body>
</html>
