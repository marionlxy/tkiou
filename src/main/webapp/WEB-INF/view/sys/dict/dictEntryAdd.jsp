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
<div>
	<form id="dataForm">
			<div class="fitem">
		    	<label>字典类型:</label>
		        <input name="dictTypeId" class="easyui-textbox" value='${dictTypeId}' readonly="true">
			</div>
			<div class="fitem">
		    	<label>字典代码:</label>
		        <input name="dictId" class="easyui-textbox"  data-options="required:true">
			</div>
			<div class="fitem">
		    	<label>字典描述:</label>
		        <input name="dictName" class="easyui-textbox" data-options="required:true">
			</div>
			<div class="fitem">
		    	<label>状态:</label>
				 <select class="easyui-combobox" name="status" panelHeight="60px" style="width:80px" required="required">	
				            <option value=""></option>			        
							<option value="1">有效</option>
							<option value="0">无效</option>
				</select>
			</div>
			<div class="fitem">
		    	<label>排序(整数):</label>
		        <input name="sortNo" class="easyui-numberbox" >
			</div>
		   <div class="fitem">
		    	<label>父类型:</label>
		        <input name="parentId" class="easyui-textbox" >
			</div>
			<div class="fitem">
		    	<label>级联关系描述:</label>
		        <input name="seqNo" class="easyui-textbox" >
			</div>
    <div id="dlg-buttons" align="center">
       <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" id="save" onclick="saveOrUpdate()" style="width:90px">提交</a>
       <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="goBack(0)" style="width:90px">取消</a>
   </div>
</div>
    
<script type="text/javascript">

//保存记录
function saveOrUpdate()
{
	var r = $('#dataForm').form('validate');
	if(!r) {
		return false;
	}
	else
	{		
		$.post("${rootPath}/sys/dictEntry/saveDictEntryAdd",$("#dataForm").serializeArray(),
		function(data)
		{			
			if(data.result == 'true' || data.result == true)
			{
				com.message("success", "数据字典添加成功！");
				goBack(1);
			}
			else
			{
				com.message("error", "数据字典添加失败 ！");
			}
		});
	}
}
 
</script>

</body>
</html>
