package com.example.demo.util;

import java.util.List;

/**
 * Created by jiangnan on 16/8/23.
 */
public class PageInfo<T> {
    private List<T> totalList;	   		//集合
    private Integer totalPageNum=0;		   //总行数
    private Integer pageSize=15;       //每页数目 默认15
    private Integer currentPage=0;  	   //当前页
    private Integer pageNo = 0;

    public PageInfo(){}
    public PageInfo(Integer currentPage,Integer pageSize){
        if(currentPage==null){
            currentPage=1;
        }
        this.pageNo=(currentPage-1)*pageSize;
        this.pageSize=pageSize;
        this.currentPage=currentPage;
    }

    public Integer getTotalPage() {
        if (pageSize==null||pageSize == 0) {
            pageSize = 15;
        }
        if (this.totalPageNum % this.pageSize == 0) {
            return (this.totalPageNum / this.pageSize);
        }
        return (this.totalPageNum / this.pageSize + 1);
    }

    public List<T> getTotalList() {
        return totalList;
    }

    public void setTotalList(List<T> lists) {
        this.totalList = lists;
    }

    public Integer getTotalPageNum() {
        if (totalPageNum==null) {
            totalPageNum = 0;
        }
        return totalPageNum;
    }

    public void setTotalPageNum(Integer totalCount) {
        this.totalPageNum = totalCount;
    }

    public Integer getPageSize() {
        if (pageSize==null||pageSize == 0) {
            pageSize = 15;
        }
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

    public void setCurrentPage(Integer currentPage) {
        this.currentPage = currentPage;
    }

    public Integer getCurrentPage() {
        if (currentPage==null||currentPage <= 0) {
            this.currentPage = 1;
        }
        return this.currentPage;
    }
    public Integer getPageNo() {
        return pageNo;
    }
    public void setPageNo(Integer pageNo) {
        this.pageNo = pageNo;
    }
}
