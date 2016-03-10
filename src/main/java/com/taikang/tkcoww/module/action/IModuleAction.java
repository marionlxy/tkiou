package com.taikang.tkcoww.module.action;

import com.taikang.udp.framework.common.datastructre.Dto;
import com.taikang.udp.framework.core.action.IBaseAction;
import com.taikang.udp.framework.core.persistence.pagination.CurrentPage;

import java.util.Arrays;


/**
  * IModuleAction
  */

public interface IModuleAction extends IBaseAction { 

	final String ACTION_ID = "moduleAction";

	/**
	 * @author itw_lixy02
	 * queryNavMenuForPage
	 * IModuleAction
	 * @param page
	 * @return
	 */
	CurrentPage queryNavMenuForPage(CurrentPage page);

	/**
	 * @author itw_lixy02
	 * findSubOneModule
	 * IModuleAction
	 * @param param
	 * @return
	 */
	Dto findSubOneModule(Dto param);

	/**
	 * @author itw_lixy02
	 * querySubMenu
	 * IModuleAction
	 * @param page
	 * @return
	 */
	CurrentPage querySubMenu(CurrentPage page);

	/**
	 * @author itw_lixy02
	 * updateSubObject
	 * IModuleAction
	 * @param dto
	 */
	void updateSubObject(Dto dto);
	/**
	 * 模糊查询
	 *	
	 * @Title: queryModuleList
	 * @Description: TODO(这里用一句话描述这个方法的作用)
	 * @param page
	 * @return	 设定文件      
	 * @return:CurrentPage	返回类型
	 */
	CurrentPage queryModuleList(CurrentPage page); 	
}
