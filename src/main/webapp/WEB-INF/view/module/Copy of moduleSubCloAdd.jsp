<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<%@ include file="/include.jsp"%>
<script type="text/javascript" src="<%=basePath%>/static/js/fileuploder/ajaxFixFileUpload.js"></script>
<script src="<%=basePath%>/static/ckeditor/ckeditor.js"></script>
<script src="<%=basePath%>/static/ckeditor/samples/js/sample.js"></script>
<script src="<%=basePath%>/static/js/imageValidate.js"></script>
<title></title>
</head>
<body>
	<div style="padding: 10px 60px 20px 60px">

		<form id="dataFormSubCloAdd" method="post" 
			enctype="multipart/form-data">
			<%--<div class="fitem">
	    	<label>投诉编号:</label>
	        <input name="complain_num" class="easyui-textbox" disabled>
		</div> --%>
		
			<input type="hidden" name="modParentId" value='${modParentId }'>
			<input type="hidden" name="modIsleaf" value='${modIsleaf }'>
			<input type="hidden" name="menuType" value='${menuType }'>
			<input type="hidden" name="modParentName" value='${modParentName }'>
			<input type="hidden" name="modLevel" value='${modLevel }'>
			<input type="hidden" name="menuId" id="menuId" value='${menuId}'>
			<input type="hidden" name="menuName" id="menuName" value='${menuName}'>
			<input type="hidden" name="parentId" id="parentId" value='${parentId}'>
			<div class="fitem">
				<label>模块名称:</label> <input name="modName" class="easyui-textbox">
			</div>
			<div class="fitem">
				<label>模块别名:</label> <input name="modByname" class="easyui-textbox">
			</div>
			<div class="fitem">
				<label>模块排序号:</label> <input name="modSquence" class="easyui-textbox">
			</div>
			<div class="fitem">
				<label>链接名称(站内):</label> <input name="modUrl" class="easyui-textbox">例如：aaa/bbb/ccc,留空即可自动生成拼音路径
			</div>
			<div class="fitem">
				<label>SEO标题:</label> <input name="modSeo" class="easyui-textbox">
			</div>
			<div class="fitem">
				<label>SEO描述:</label> <input name="seoDes" class="easyui-textbox">
			</div>
			<div class="fitem">
				<label>描述:</label>
				<!-- <input name="complainMsg"  validType="length[0,30]" required="required"> -->
				<textarea name="modDes" class="easyui-textbox"
					style="width: 316px; border: 1px solid #99bbe8; height: 200px"
					rows="4" cols="33"></textarea>
			</div>

			<div class="fitem">
				<label>banner图片:</label> <input name="modBanner" id='modBanner'
						type='file' 
					data-options="required:true,prompt:'Choose a image...'"
					style="width: 25%" />
			</div>

			<div class="fitem">
				<label>小图片:</label> <input name="modImg" id='modImg' type='file' class="easyui-validatebox"
					validType="img_upload" data-options="prompt:'Choose a image...'"
					style="width: 25%" />
			</div>
			<!-- <div class="fitem">
				<label>描述:</label>
				<textarea style="height: 40px; width: 200px;" name="modDes"
					id="modDes" data-options="required:true">
		            </textarea>
			</div> -->
			<div class="adjoined-bottom">
				<div class="grid-container">
					<div class="grid-width-100">
						<textarea id="editor" name="editor" style="height: 40px;width: 200px"
							 data-options="required:true">
		            	</textarea>
					</div>
				</div>
			</div>	
		</form>
		<div id="dlg-buttons" align="left">
			<a href="javascript:void(0)" class="easyui-linkbutton"
				iconCls="icon-ok" id="save" onclick="saveOrUpdate()"
				style="width: 90px">确定</a> <a href="javascript:void(0)"
				class="easyui-linkbutton" iconCls="icon-cancel"
				onclick="returnParent(1)" style="width: 90px">取消</a>

		</div>
	</div>

	<script type="text/javascript">
		initSample();
		jQuery(function() {
			jQuery.ajaxSetup({
				cache : false
			});
		});
		
		
		function saveOrUpdate() {
			var r = $('#dataFormSubCloAdd').form('validate');
			if (!r) {
				return false;
			} else {
				$.ajaxFileUpload({
		            url: "${rootPath}/module/addFormSub", 
		            type: 'post',
		            data:$("#dataFormSubCloAdd").serializeArray(),
		            secureuri: false, //一般设置为false
		            complete:null,
		            fileElementId: ["modBanner","modImg"], // 上传文件的id、name属性名
		            dataType: 'text', //返回值类型，一般设置为json、application/json
		            success: function(data, textStatus){
		            	var daObj = eval('(' + data + ')');
		            	if (daObj.result == 'true' || daObj.result == true) {
							// 			 	$.messager.show({title:'提示',msg:data.msg,showType:'show'});
							$.messager.alert("提示",daObj.msg);
						} else {
							// $.messager.alert('提示',data.msg,'error');
							$.messager.alert("提示");
						}
		            }
		        });
			} 
	}
		 //保存记录
		function saveOrUpdate2() {
			var r = $('#dataFormSubCloAdd').form('validate');
			if (!r) {
				return false;
			} else {
				$('#dataFormSubCloAdd').form(
						'submit',
						{
							url : '${rootPath}/module/addFormSub',
							onSubmit : function() {
								$("#dataFormSubCloAdd").serializeArray();
							}
							 ,
							success : function(data) {
								alert(data);
								$('#save').linkbutton('disable');
								console.log(data);
							}
						});
			} 
	}
							 /*ajaxobj = eval("(" + data + ")");
							if (ajaxobj.result == 'true'
							|| ajaxobj.result == true) {
						$.messager.alert('提示', ajaxobj.msg);
					

					} else {
						//$.messager.alert('提示',data.msg,'error');
						$.messager
								.alert("提示", ajaxobj.msg, 'error');
					}*/
						
				/* 
				
				error:function(ajaxobj)  
				{  
				        if(ajaxobj.responseText!='')  
				        alert(ajaxobj.responseText);  
				}  
				$('#save').linkbutton('disable');
				$.post("${rootPath}/module/addFormSub", $("#dataFormSubCloAdd")
						.serializeArray(), function(data) {
					if (data.result == 'true' || data.result == true) {
						// 			 	$.messager.show({title:'提示',msg:data.msg,showType:'show'});
						$.messager.alert("提示");
					} else {
						// $.messager.alert('提示',data.msg,'error');
						$.messager.alert("提示");
					}
				 */
		
	</script>
</body>
</html>
