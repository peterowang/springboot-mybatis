package com.example.demo.util;

import com.alibaba.fastjson.JSONObject;

import java.util.List;

/**
 * Created by BFD-593 on 2017/8/29.
 */
public class ResultPageInfoJsonUtils
{
    public static ResultPageInfo getSuccessJson(String code, int pageNo, int pageSize, int totalCount, List lst)
    {
        ResultPageInfo ret = new ResultPageInfo("000000", "success");
        ret.setPageInfo(pageNo, pageSize, totalCount, lst);
        return ret;
    }

    public static ResultPageInfo getSuccessJson(String code, List lst)
    {
        ResultPageInfo ret = new ResultPageInfo("000000", "success");
        ret.setPageInfo(0, 0, 0, lst);
        return ret;
    }

    public static ResultObj getFailedJson(String code, Object value)
    {
        ResultObj ret = new ResultObj(code, "failed", value);
        return ret;
    }

}
