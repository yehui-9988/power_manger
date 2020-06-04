package com.neusoft.controller;


import com.neusoft.bean.Jcbgd;
import com.neusoft.bean.Pretreatment;
import com.neusoft.bean.Yscfjl;
import com.neusoft.dao.JcbgdMapper;
import com.neusoft.dao.PretreatmentMapper;
import com.neusoft.dao.YscfjlMapper;
import com.neusoft.until.ResultBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.Calendar;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("admin/pretreatment")
public class YjqyyController {

    @Autowired
    PretreatmentMapper pretreatmentMapper;
    @Autowired
    JcbgdMapper jcbgdMapper;

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
    //检查报告单上传
    @RequestMapping("upload")
    @ResponseBody
    public Object upload(
            @RequestParam(value = "file",required = true) MultipartFile file, HttpServletRequest Request
    )
    {
        ResultBean bean=null;

        try {
            if (file!=null)
            {
                String filepath=Request.getSession().getServletContext().getRealPath("/uploderfiles");
//                 SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMdd");
//                 String dirName=sdf.format(new Date());
                Calendar calendar=Calendar.getInstance();
                int year=calendar.get(Calendar.YEAR);
                int month=calendar.get(Calendar.MONDAY)+1;
                int date=calendar.get(Calendar.DATE);
                String dirName="/"+year+"/"+month+"/"+date;
                File file1 =new File(filepath,dirName);
                if (!file1.exists())
                {
                    boolean flag=file1.mkdirs();
                }
                String organame=file.getOriginalFilename();
                String fileName= UUID.randomUUID().toString()+"test"+organame.substring(organame.lastIndexOf("."));
                //存储在数据库的地址
                String dbpath="/uploderfiles"+dirName+"/"+fileName;
                File tagertFile=new File(file1,fileName);//创建了一个图片的文件 文件命名时uuid
                file.transferTo(tagertFile);//copy  进行
                bean=new ResultBean(10000);
                bean.setObject(dbpath);

            }else {
                bean=new ResultBean(20000);
            }

        }catch (Exception e)
        {
            e.printStackTrace();
            bean=new ResultBean(30000);
            bean.setMessage(e.getMessage());
        }
        return bean;
    }
    //检查报告单长传至服务器
    @RequestMapping("uploadtoservice")
    @ResponseBody
    public Object uploadtoservice(Jcbgd jcbgd)
    {
     int result=jcbgdMapper.insertSelective(jcbgd);
     if (result>0)
     {
         bean.setMessage("检查报告单");
         bean.setCode(10000);
     }else {
         bean.setCode(20000);
     }

     return bean;
    }
//查询个人报告单长传至服务器
    @RequestMapping("selectjcbgd")
    @ResponseBody
    public Object uploadtoservice(int icaseid)
    {
        List<Jcbgd> list=jcbgdMapper.selectbyicaseid(icaseid);
        bean.setObject(list);
        bean.setCode(10000);
        return bean;
    }
///删除个人检查报告单

    @RequestMapping("deletejcbgd")
    @ResponseBody
    public Object deletejcbgd(int id)
    {
        int result=jcbgdMapper.deleteByPrimaryKey(id);
        if (result>0)
        {
            bean.setCode(10000);
        }

        return bean;
    }

    @Autowired
    YscfjlMapper yscfjlMapper;

    ///医生处方记录增删改查

    @RequestMapping("uploadyscfjl")
    @ResponseBody
    public synchronized Object uploadyscfjl(Yscfjl yscfjl)
    {
        int result=yscfjlMapper.insertSelective(yscfjl);
        if (result>0)
        {
            bean.setMessage("检查报告单");
            bean.setCode(10000);
        }else {
            bean.setCode(20000);
        }

        return bean;
    }

    @RequestMapping("selectyscfjl")
    @ResponseBody
    public Object selectyscfjl(int icaseid)
    {
        List<Yscfjl> list=yscfjlMapper.selectbyicaseid(icaseid);
        bean.setObject(list);
        bean.setCode(10000);
        return bean;
    }


    @RequestMapping("deleteyscfjl")
    @ResponseBody
    public Object deleteyscfjl(int id)
    {
        int result=yscfjlMapper.deleteByPrimaryKey(id);
        if (result>0)
        {
            bean.setCode(10000);
        }

        return bean;
    }


}
