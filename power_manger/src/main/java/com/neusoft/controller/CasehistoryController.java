package com.neusoft.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.neusoft.bean.Casehistory;
import com.neusoft.bean.Manger;
import com.neusoft.bean.Pasthistory;
import com.neusoft.dao.CasehistoryMapper;
import com.neusoft.dao.PasthistoryMapper;
import com.neusoft.until.ResultBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("admin/casehistory")
public class CasehistoryController {
    @Autowired
    private CasehistoryMapper mapper;
    @Autowired
    private PasthistoryMapper pamapper;



    ResultBean bean;

    @RequestMapping("selectall")
    @ResponseBody
    public Object selectAll(Integer index,Integer size) {
        index = index == null ? 1 : index;
        size = size == null ? 5 : size;
        try {
            PageHelper.startPage(index, size);
            List<Casehistory> list = mapper.selectall();
            PageInfo<Casehistory> info = new PageInfo<>(list);
            bean = new ResultBean();
            bean.setObject(info);
            bean.setCode(10000);

        }catch (Exception e)
        {
            e.printStackTrace();
        }
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
        List<Pasthistory> list=pamapper.selectByicaseid(id);
        bean=new ResultBean();
        bean.setObject(list);
        bean.setCode(10000);
        return bean;
    }
    @RequestMapping("savepasthistory")
    @ResponseBody
    public Object saverow(Pasthistory pasthistory){
       int result= pamapper.insertSelective(pasthistory);

        if (result>0)
        {
            bean=new ResultBean();
            bean.setCode(10000);


        }
        return bean;
    }




    @RequestMapping("savecasehistory")
    @ResponseBody
    public Object savecasehistory(Casehistory casehistory, HttpSession session)
    {
        int result=0;
       Manger manger=(Manger) session.getAttribute(Manger.CURRENT_MANAGER);
       casehistory.setIsmuserid(manger.getManagerId());
       if (null!=casehistory.getIcasehistoryid())
       {

            result= mapper.updateByPrimaryKeySelective(casehistory);

       }
       else {
            if (null==casehistory.getDtregister())
            {
                SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
                casehistory.setDtregister(sdf.format(new Date()));
            }
            result=mapper.insertSelective(casehistory);
       }


        if(result>0)
        {
            bean=new ResultBean();
            bean.setCode(10000);


        }

        return bean;
    }
    @RequestMapping("deletecasehistory")
    @ResponseBody
    public  Object deletecasehistory(int id)
    {
     int  result= mapper.deleteByPrimaryKey(id);
     if (result>0)
     {
         bean.setCode(10000);

     }
      return bean;
    }

    @RequestMapping("deletepasthistory")
    @ResponseBody
    public  Object deletepasthistory(int ipasthistoryid)
    {

       int result= pamapper.deleteByPrimaryKey(ipasthistoryid);

        if(result>0)
        {
            bean=new ResultBean();
            bean.setCode(10000);
            bean.setMessage("删除成功");

        }

        return bean;

    }

    @RequestMapping("selectmaxid")
    @ResponseBody
    public  Object selectmaxid()
    {

        List<Map<String,Integer>> list=mapper.selectmaxicaeid();
        Map<String,Integer> map=list.get(0);
        Integer maxid=map.get("maxid");

        bean=new ResultBean();
        bean.setCode(10000);
        bean.setMessage("获取当前最大id");
        bean.setObject(maxid);

        return bean;
    }


}
