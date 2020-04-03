package com.neusoft.controller;


import com.neusoft.bean.Vitalsigns;
import com.neusoft.dao.VitalsignsMapper;
import com.neusoft.until.ResultBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("admin/smtz")
public class SmtzController {
    @Autowired
    private VitalsignsMapper vmapper;
    ResultBean bean;


    @RequestMapping("select")
    @ResponseBody
    public Object selectbyid(int id){

        Vitalsigns vitalsigns=vmapper.selectByicaseid(id);
        if (vitalsigns!=null)
        {
            bean=new ResultBean();
            bean.setCode(10000);
            bean.setObject(vitalsigns);

        }
        return bean;

    }
    @RequestMapping("save")
    @ResponseBody
    public Object selectbyid(Vitalsigns vitalsigns){

        int result;
        if (vitalsigns.getIvitalsignsid()==null)
        {
            result=vmapper.insertSelective(vitalsigns);
        }
        else {
            result=vmapper.updateByPrimaryKey(vitalsigns);
        }


        if (result!=0)
        {
            bean=new ResultBean();
            bean.setCode(10000);


        }
        return bean;

    }


}
