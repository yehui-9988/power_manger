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
        return "test";
    }

    @RequestMapping("admin/cwjb/jxsj")
    public String openCwjbJxsj(){
       return "hgmx/cwjb/jxsj";
  }
}
