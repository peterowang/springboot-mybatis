package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by BFD-593 on 2017/8/29.
 */
@Controller
public class HomeController {
    @Value("${spring.msg}")
    private String msg = "";
    @RequestMapping("/livestock.html")
    public String toIndex(){
        System.out.println(msg);
        return "livestock/livestock";
    }
    @RequestMapping("/")
    public String toHome(){
        return "index";
    }
}
