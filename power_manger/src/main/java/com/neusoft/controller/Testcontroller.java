package com.neusoft.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller

public class Testcontroller{

    @RequestMapping("test")
    public String test()
    {
        return "admin/index";

    }
    @RequestMapping("init")
    public String initpage()
    {
        System.out.println("测试类");
        return "test";
    }

    @RequestMapping("admin/cwjb/jxsj")
    public String openCwjbJxsj(){
       return "hgmx/cwjb/jxsj";
  }

    @RequestMapping("admin/cwsf/jxsj")
    public String openCwsfJxsj(){
        return "hgmx/cwsf/jxsj";
    }

    @RequestMapping("admin/cwcx")
    public String openCwcx(){
        return "hgmx/echarts/sjtj";
    }

}
