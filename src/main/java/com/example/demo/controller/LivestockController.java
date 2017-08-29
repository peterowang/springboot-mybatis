package com.example.demo.controller;

import com.example.demo.domain.LivestockModel;
import com.example.demo.service.LivestockService;
import com.example.demo.util.Page;
import com.example.demo.util.PageInfo;
import com.example.demo.util.ResultPageInfoJsonUtils;
import org.springframework.beans.factory.annotation.Autowired;
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
    public String listInfo(Page page){
        Integer count = livestockService.count();
        List<LivestockModel> livestockModels = livestockService.listInfo(page.getStart(), page.getPageSize());
        return ResultPageInfoJsonUtils.getSuccessJson("000000", page.getPageNo(), page.getPageSize(), count, livestockModels);
    }
}
