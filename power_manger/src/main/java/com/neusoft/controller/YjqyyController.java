package com.neusoft.controller;


import com.neusoft.bean.Pretreatment;
import com.neusoft.dao.PretreatmentMapper;
import com.neusoft.until.ResultBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("admin/pretreatment")
public class YjqyyController {

    @Autowired
    PretreatmentMapper pretreatmentMapper;

    ResultBean bean;


    //保存研究前用药的数据
     @RequestMapping("save")
    @ResponseBody
    public Object savepretreament(Pretreatment pretreatment){
        int result= pretreatmentMapper.insertSelective(pretreatment);

        if (result>0)
        {
            bean=new ResultBean();
            bean.setCode(10000);


        }
        return bean;
    }
//查询数据
    @RequestMapping("select")
    @ResponseBody
    public Object selectpretreament(Integer  id){
        List<Pretreatment> pretreatment= pretreatmentMapper.selectByicaseid(id);
        bean=new ResultBean();
        bean.setCode(10000);
        bean.setObject(pretreatment);
        return bean;
    }


    //查询数据
    @RequestMapping("delete")
    @ResponseBody
    public Object deletepretreament(Integer  preid){
        int  reuslt= pretreatmentMapper.deleteByPrimaryKey(preid);
        if (reuslt>0)
        {
            bean=new ResultBean();
            bean.setCode(10000);
            bean.setMessage("删除成功");

        }

        return bean;
    }




}
