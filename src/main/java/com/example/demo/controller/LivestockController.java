package com.example.demo.controller;

import com.example.demo.domain.LivestockModel;
import com.example.demo.service.LivestockService;
import com.example.demo.util.Page;
import com.example.demo.util.PageInfo;
import com.example.demo.util.ResultPageInfo;
import com.example.demo.util.ResultPageInfoJsonUtils;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Required;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * Created by BFD-593 on 2017/8/29.
 */
@Controller
public class LivestockController {
    @Autowired
    LivestockService livestockService;
    @RequestMapping(value="/livestock",produces = {"application/json;charset=utf-8"},method = RequestMethod.GET)
    @ResponseBody
    public ResultPageInfo listInfo(Page page){
        Integer count = livestockService.count();
        List<LivestockModel> livestockModels = livestockService.listInfo(page.getStart(), page.getPageSize());
        for(LivestockModel l : livestockModels){
            System.out.println(l.toString());
        }
        return ResultPageInfoJsonUtils.getSuccessJson("000000", page.getPageNo(), page.getPageSize(), count, livestockModels);
    }
    @RequestMapping(value="/livestockFilter",produces = {"application/json;charset=utf-8"},method = RequestMethod.GET)
    @ResponseBody
    public ResultPageInfo listFilter(@RequestParam(value="enterpriseId",required = false) Long enterpriseId,
                                     @RequestParam(value="number",required = false) String number,
                                     @RequestParam(value="state",required = false) String state,
                                     @RequestParam(value="beginTime", required=false)String beginTime,
                                     @RequestParam(value="endTime",required = false)String endTime){
        List<LivestockModel> filter = livestockService.findFilter(enterpriseId,number,state,beginTime,endTime);
        return ResultPageInfoJsonUtils.getSuccessJson("000000", filter);
    }
}
