package com.taikang.tkcoww.moduleDes.controller;

import java.sql.Timestamp;
import java.util.Map;
import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Controller;

import com.taikang.udp.framework.core.persistence.pagination.CurrentPage;
import com.taikang.udp.framework.common.datastructre.Dto;

import java.util.HashMap;

import com.taikang.udp.framework.common.datastructre.impl.BaseDto;

import javax.annotation.Resource;

import com.taikang.udp.framework.core.web.BaseController;
import com.taikang.tkcoww.module.action.IModuleAction;
import com.taikang.tkcoww.moduleDes.action.IModuleDesAction;
import com.taikang.tkcoww.moduleDes.model.ModuleDesBO;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.ui.Model;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Arrays;


/**
  * ModuleDesController
  */
@Controller("moduleDesController")
@RequestMapping(value="/moduleDes")
public class ModuleDesController  extends BaseController  {
		
	@Resource(name=IModuleDesAction.ACTION_ID)
	private IModuleDesAction moduleDesAction;
	@Resource(name=IModuleAction.ACTION_ID)
	private IModuleAction moduleAction;
		
	/**
	 * 打开主查询页面
	 * @return 页面地址
	 */
	@RequestMapping("")
	public String showModuleDesIndexPage() {
		return "moduleDes/moduleDesIndex"; 
	}
	
	/**
	 * 查询信息列表
	 * @return 分页列表数据
	 */
	@RequestMapping("/list")
	@ResponseBody
	public Map<String,Object> getModuleDesList(HttpServletRequest request,CurrentPage page){
		Map<String, Object> map = new HashMap<String, Object>();
		
		page.setParamObject(getParamAsDto(request));
		CurrentPage currentPage = moduleDesAction.queryForPage(page);
		
		map.put("rows", currentPage.getPageItems());
		map.put("total", currentPage.getTotalRows());
		
		return map;
	}

	/**
	 * 打开新增或修改页面
	 * @return
	 */
	@RequestMapping("edit")
	public String showModuleDesEditPage(String rowId,Model model) {
		
		if(rowId!=null && !rowId.equals(""))
		{
			model.addAttribute("rowId",rowId );
		}
		
		return "moduleDes/moduleDesEdit"; 
	}
	
	/**
	 * 新增 内容模板 上 级
	 * @return
	 */
	@RequestMapping("add_1")
	public String moduleDesAdd_1() {
		return "moduleDes/moduleDesAdd_1"; 
	}
	/**
	 * 新增 内容模板
	 * @return
	 */
	@RequestMapping("add")
	public String moduleDesAdd() {
		return "moduleDes/moduleDesAdd"; 
	}
	
	/**
	 * 获取一条记录详细信息，用来填充修改界面
	 * @return
	 */
	@RequestMapping("/getOne")
	@ResponseBody
	public Dto getModuleDesById(@RequestParam("rowId")String rowId)
	{
		Dto param = new BaseDto();
		param.put("rowId", rowId);
		return moduleDesAction.findOne(param);
	}
	
	/**
	 * 保存新增或修改的记录，将其持久化到数据库中
	 * @return
	 */
	@RequestMapping("/save")
	@ResponseBody
	private Map<String,String> saveModuleDesInfo(HttpServletRequest request)
	{
		Map<String,String> map=new HashMap<String,String>();
		
		Dto param = getParamAsDto(request);
		if(param.get("rowId") ==null ||"".equals(param.get("rowId")))
		{
			String modId = UUID.randomUUID().toString().replace("-", "");
			param.put("modId", modId);
			//创建时间
			param.put("createdTime", new Timestamp(System.currentTimeMillis()));
			
			//将 modId 插入到 zjow_module 表中
			
			moduleAction.insertObject(param);
			moduleDesAction.insertObject(param);
			
			map.put("modId", modId);
			map.put("sId", modId);
			
			map.put(MESSAGE_INFO, "新增成功！");
		}
		else
		{
			moduleDesAction.updateObject(param);
			map.put(MESSAGE_INFO, "更新成功！");
		}
		map.put(RTN_RESULT, "true");
		
		return map;
	}
	
	
	/**
	 * banner图替换   图片上传
	 * @return
	 */
	@RequestMapping("/uploadBySpringGrpModuleDes")
	public String uploadBySpringGrpModuleDes(HttpServletRequest request){
		
		Map<String, String> map = new HashMap<String, String>();
		String modId = request.getParameter("modId");
		try {
			String pictureUrl = moduleDesAction.uploadBySpringGrpModuleDes(request);
		} catch (Exception e) {
		}
		
		return "";
	}
	
	/**
	 * banner图替换   图片上传
	 * @return
	 */
	@RequestMapping("/showImgsAddPage")
	public String showImgsAddPage(){
		
		return "moduleDes/imgsAdd";
	}
	
	/**
	*删除一条或多条记录
	*/
	@RequestMapping(value="/del")
	@ResponseBody
	public Map<String, String> deleteModuleDes(@RequestParam("rowId") String rowId) {
		Map<String, String> map = new HashMap<String, String>();
		Dto param = new BaseDto();
		param.put("rowId", rowId);
		moduleDesAction.deleteObject(param);
		
		map.put(RTN_RESULT, "true");
		map.put(MESSAGE_INFO, "操作成功！");
		
		return map;
	}
}

