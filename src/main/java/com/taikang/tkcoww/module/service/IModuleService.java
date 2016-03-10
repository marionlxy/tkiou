package com.taikang.tkcoww.module.service;

import com.taikang.tkcoww.module.model.ModuleBO;
import com.taikang.udp.framework.core.persistence.pagination.CurrentPage;
import com.taikang.udp.framework.core.service.IBaseService;

import java.util.Arrays;

/**
  * IModuleService
  */
 
 public interface IModuleService<T> extends IBaseService<T>{
 
 	final String SERVICE_ID = "moduleService";

	/**
	 * @author itw_lixy02
	 * queryNavMenuForPage
	 * IModuleService
	 * @param page
	 * @return
	 */
	CurrentPage queryNavMenuForPage(CurrentPage page);

	/**
	 * @author itw_lixy02
	 * querySubMenu
	 * IModuleService
	 * @param page
	 * @return
	 */
	CurrentPage querySubMenu(CurrentPage page);

	/**
	 * @author itw_lixy02
	 * updateSubObject
	 * IModuleService
	 * @param moduleBO
	 */
	void updateSubObject(ModuleBO moduleBO);
	
	/**
	 * 查询
	 *	
	 * @Title: queryModuleList
	 * @Description: TODO(这里用一句话描述这个方法的作用)
	 * @param page
	 * @return	 设定文件      
	 * @return:CurrentPage	返回类型
	 */
	CurrentPage queryModuleList(CurrentPage page);  	
 }
 
 
 