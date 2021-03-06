package com.taikang.tkcoww.banner.service;

import com.taikang.udp.framework.core.persistence.pagination.CurrentPage;
import com.taikang.udp.framework.core.service.IBaseService;

import java.util.Arrays;

/**
  * IBannerService
  */
 
 public interface IBannerService<T> extends IBaseService<T>{
 
 	final String SERVICE_ID = "bannerService";  
	public CurrentPage getBannerList(CurrentPage page);
 }
 
 
 