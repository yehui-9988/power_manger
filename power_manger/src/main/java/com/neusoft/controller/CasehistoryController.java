package com.neusoft.controller;

import com.neusoft.bean.Casehistory;
import com.neusoft.bean.Pasthistory;
import com.neusoft.dao.CasehistoryMapper;
import com.neusoft.dao.PasthistoryMapper;
import com.neusoft.until.ResultBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import redis.clients.jedis.BinaryClient;

import java.util.List;

@Controller
@RequestMapping("admin/casehistory")
public class CasehistoryController {
    @Autowired
    private CasehistoryMapper mapper;
    @Autowired
    private PasthistoryMapper pamapper;


    @RequestMapping("selectall")
    @ResponseBody
    public Object selectAll()
    {
        ResultBean bean;
        List<Casehistory> list=mapper.selectall();
        bean=new ResultBean();
        bean.setObject(list);
        bean.setCode(10000);
        return bean;
    }
    @RequestMapping("selectbyid")
    @ResponseBody
    public Object selectbyid(int id)
    {
        ResultBean bean;
        Casehistory casehistory=mapper.selectByPrimaryKey(id);
        bean=new ResultBean();
        bean.setObject(casehistory);
        bean.setCode(10000);
        return bean;
    }

    @RequestMapping("selectbyicaseid")
    @ResponseBody
    public Object selectbyicaseid(int id)
    {
        ResultBean bean;
        List<Pasthistory> list=pamapper.selectByicaseid(id);
        bean=new ResultBean();
        bean.setObject(list);
        bean.setCode(10000);
        return bean;
    }



}
