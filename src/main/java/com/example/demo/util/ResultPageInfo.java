package com.example.demo.util;

import java.util.List;

public class ResultPageInfo extends Result<PageInfo<Object>>
{
	
	public ResultPageInfo(String code, String msg, PageInfo<Object> data) 
	{
		super(code, msg, data);
		// TODO Auto-generated constructor stub
	}
	
	public ResultPageInfo(String code, String msg) 
	{
		super(code, msg, null);
		// TODO Auto-generated constructor stub
	}
	
	public void setPageInfo(int currentPage, int pageSize, int totalCount, List data)
	{
		PageInfo<Object> pgi = new PageInfo<Object>(currentPage, pageSize);
		pgi.setTotalList(data);
		pgi.setTotalPageNum(totalCount);
		super.setData(pgi);
	}
	
	
}
