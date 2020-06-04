package com.neusoft.controller;


import com.neusoft.bean.Pqxzzz;
import com.neusoft.dao.PqxzzzMapper;
import com.neusoft.until.ResultBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("admin/pqxzzz")
public class PqxzzzController {

    @Autowired
    PqxzzzMapper pqxzzzMapper;
    ResultBean bean;

    @RequestMapping("savepqxzzz")
    @ResponseBody
    public synchronized Object save( Pqxzzz pqxzzz )
    {
        int result=0;
        if (pqxzzz.getId()==null)
        {
            result= pqxzzzMapper.insertSelective(pqxzzz);
        }else {
            result= pqxzzzMapper.updateByPrimaryKey(pqxzzz);
        }

        if (result>0)
        {
            bean=new ResultBean();
            bean.setCode(10000);
        }
        return bean;
    }

    @RequestMapping("selectpqxzzz")
    @ResponseBody
    public  Object selectdata(int icaseid,Integer vctype)
    {
        Pqxzzz pqxzzz= pqxzzzMapper.selectByPrimaryKey(icaseid,vctype);
        bean=new ResultBean();
        bean.setObject(pqxzzz);
        return bean;
    }

    @RequestMapping("drawpic")
    @ResponseBody
    public  Object drawpic(int icaseid)
    {
        List<Pqxzzz> list= pqxzzzMapper.drawpic(icaseid);
      //  list.get(0).getExdp();

        bean=new ResultBean();
        bean.setObject(list);
        return bean;
    }



}
