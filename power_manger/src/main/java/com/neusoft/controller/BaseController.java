package com.neusoft.controller;


import com.neusoft.bean.Manger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
public class BaseController {
    @Autowired
    HttpSession session;
    @Autowired
    HttpServletRequest request;

   public Manger getloginmanager()
   {
       Manger manager=(Manger) session.getAttribute(Manger.CURRENT_MANAGER);

       return manager;
   }
}
