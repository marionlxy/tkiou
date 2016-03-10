<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="UTF-8"%>
<%@page import="java.net.URLDecoder"%>
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
	<div style="padding: 10px 60px 20px 60px">
		<form id="dataFormAdd">
			<%--<div class="fitem">
	    	<label>投诉编号:</label>
	        <input name="complain_num" class="easyui-textbox" disabled>
		</div> --%>
			<input type="hidden" name="menuId" id="menuId" value='${menuId}'>
			<input type="hidden" name="modId" id="modId" value='${modId}'>
			<input type="hidden" name="parentId" id="parentId" value='${parentId}'>
			<input type="hidden" name="menuName" id="menuName"
				value='${menuName }'>
			<input type="hidden" name="reqmenuid" id="reqmenuid"
				value='${reqmenuid }'>
			<input type="hidden" name="modIsleaf" id="modIsleaf"
				value='${modIsleaf }'>
			<input type="hidden" name="modLevel" id="modLevel"
				value='${modLevel }'>
			<input type="hidden" name="modName" id="modName"
				value='${modName }'>
			<%-- <input type="hidden" name="msg" id="msg"
				value='${msg }'>	 --%>
<!-- 			<div class="fitem"> -->
<!-- 				<input name="menuType"  type="radio" id="radio1"  style="width: 2%" value="sub"> -->
<!-- 				<lable>下级栏目</lable> -->
<!-- 			</div> -->
<!-- 			<div class="fitem"> -->
<!-- 				<input name="menuType"  type="radio" id="radio2"  style="width: 2%"  value="leaf"> -->
<!-- 				<lable>叶子栏目</lable> -->
<!-- 			</div> -->
			<div class="fitem">
				 <input name="menuType" type="radio" value="sub"  onclick="hideThe()"><lable>下级栏目</lable>
				 <input name="menuType" type="radio" value="leaf" id="leaf" onclick="showThe()"><lable>叶子栏目</lable>
			</div>
			
			<div class="fitem" id="aaa" style="margin-left: 100px;color: orange;font-size: large;font-weight: bold;" >
				 <lable>栏目模板</lable>
			</div>
			<div class="fitem" id="moduleContent">
				 <input id="moduleContent1" name="moduleType" type="radio" value="module"  ><lable>内容模板</lable>
			</div>
			<div class="fitem" id="moduleListWithImg">
				 <input id="moduleListWithImg1" name="moduleType" type="radio" value="module"  ><lable>带图列表模板</lable>
			</div>
			<div class="fitem" id="moduleListWithLogo">
				 <input id="moduleListWithLogo1" name="moduleType" type="radio" value="module"  ><lable>logo列表模板</lable>
			</div>
			<div class="fitem" id="moduleListWithoutImg">
				 <input id="moduleListWithoutImg1" name="moduleType" type="radio" value="module"  ><lable>不带图列表模板</lable>
			</div>
			<div class="fitem">
				<input name="menuType" type="radio" value="col" onclick="hideThe()" ><lable>栏目介绍</lable>
			</div>
		</form>
		<div id="dlg-buttons" align="center">
			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" id="save" onclick="saveOrUpdate()"style="width: 90px">确定</a>
		    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="returnParent(1)" style="width: 90px">取消</a>
		</div>
	</div>


	<script type="text/javascript">
	
		$('#aaa').hide();
		$('#moduleContent').hide();
		$('#moduleListWithImg').hide();
		$('#moduleListWithLogo').hide();
		$('#moduleListWithoutImg').hide();
		
		function showThe(){
			$('#aaa').show();
			$('#moduleContent').show();
			$('#moduleListWithImg').show();
			$('#moduleListWithLogo').show();
			$('#moduleListWithoutImg').show();
		}
		function hideThe(){
			$('#aaa').hide();
			$('#moduleContent').hide();
			$('#moduleListWithImg').hide();
			$('#moduleListWithLogo').hide();
			$('#moduleListWithoutImg').hide();
			$('#moduleContent1').removeAttr('checked');
			$('#moduleListWithImg1').removeAttr('checked');
			$('#moduleListWithLogo1').removeAttr('checked');
			$('#moduleListWithoutImg1').removeAttr('checked');
		}
		
	</script>
	
	<script type="text/javascript">
		jQuery(function() {

			jQuery.ajaxSetup({
				cache : false
			});
			
			// 	$('#site').combobox({
			//         url:'${rootPath}/getDictCombox?dictType=kemu1',    
			//         valueField:'dictId',    
			//         textField:'dictName',
			//         panelWidth: 100,
			//         panelHeight:'auto'
			//  }); 
		});
		var msg=$('#msg').val();
		if(msg!=null){
			$.messager.alert('提示',msg);
		}
		//保存记录
		function saveOrUpdate() {
			var r = $('#dataFormAdd').form('validate');
			var modId=null;modIsleaf=null;modLevel=null;modName=null;menuName=null;
			modId=$("#modId").val();modIsleaf='${modIsleaf}';modLevel='${modLevel}';
			modName='${modName}';menuName='${menuName}';
			var menuId='${menuId}';
			var parentId='${parentId}';	
			
			var val = $('input:radio[name="menuType"]:checked').val();
	        if(val == null) {
	        	$.messager.alert('提示',"请选中一条！",'error');
	            return false;
	        }
			if (!r) {
				return false;
			} else {
				if(modIsleaf=='1'){
					$.messager.alert('提示',"已是叶子栏目,无法新增！",'error');
				}else if(modLevel=='4'){
					$.messager.alert('提示',"已是叶子栏目,无法新增！",'error');
				}else if((modLevel=='1'&&val=='col')){
					$.messager.alert('提示',"请在第二，第三级增加栏目介绍！",'error');
				}else if((modLevel=='4'&&val=='col')){
					$.messager.alert('提示',"请在第二，第三级增加栏目介绍！",'error');
				}else if((modLevel=='3'&&val=='sub。')){
						$.messager.alert('提示',"没有下级栏目！",'error');	
				}else if(val=='sub'){
					url = '/module/addSubCol?modId=' + modId
					/* + '&menuName=' + encodeURI(menuName) */
					+ "&menuType=" + val
					+ "&modName=" + encodeURI(modName)
					+ "&modIsleaf=" + modIsleaf
					+ "&menuId=" + menuId
					+ "&parentId=" + parentId
					+ "&modLevel=" + modLevel;
					window.parent.wrapper.addTab("新增" +modName,
					url, '');
				}else{
					url = '/module/addLeafCol?modId=' + modId
					/* + '&menuName=' + encodeURI(menuName) */
					+ "&menuType=" + val
					+ "&modName=" + encodeURI(modName)
					+ "&modIsleaf=" + modIsleaf
					+ "&menuId=" + menuId
					+ "&parentId=" + parentId
					+ "&modLevel=" + modLevel;
					window.parent.wrapper.addTab("新增" +modName,url, '');
				}
				
				
				};
			}
	</script>
</body>
</html>
