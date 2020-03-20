package com.neusoft.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
public class Testcontroller{
    @RequestMapping("test")
    public String test()
    {

        System.out.println("test");
        return "admin/index";

    }
    @RequestMapping("init")
    public String initpage()
    {
        return "test";
    }

    @RequestMapping("hgmx/cwjb/jxsj")
    public String openCwjbJxsj(){
        return "hgmx/cwjb/jxsj";
    }
}
