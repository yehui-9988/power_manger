package com.neusoft.controller;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.neusoft.bean.Manger;
import com.neusoft.bean.SystemMenu;
import com.neusoft.dao.SystemMenuMapper;
import com.neusoft.until.ResultBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.*;

@Controller
@RequestMapping("admin/menu")
public class SystemMenucontroller extends BaseController{

    @Autowired
    private SystemMenuMapper mapper;
    @RequestMapping("tree")
    public String page()
    {
        return "admin/menu/tree";
    }

    @RequestMapping("manager")
    @ResponseBody
    public Object findbymangerid(HttpSession session)
    {
        ResultBean bean=null;
        try {

            Manger manger=getloginmanager();
            List<SystemMenu> list=mapper.selectByManagerId(manger.getManagerId());
            List<SystemMenu> temp=new ArrayList<>();
            for (SystemMenu s:list
            ) {
                for (SystemMenu s1:list
                ) {
                    if (s.getMenuId().intValue()==s1.getMenuPid().intValue())///判断s1是否是s的子目录
                    {
                        s.getList().add(s1);
                        temp.add(s1);
                    }
                }
            }
            list.removeAll(temp);
            bean=new ResultBean(10000);
            bean.setObject(list);


        }catch (Exception e)
        {
            e.printStackTrace();
            bean=new ResultBean(30000);
            bean.setMessage(e.getMessage());
        }
        return bean;
    }





    @RequestMapping("list")
    @ResponseBody
    public Object findall()
    {
        ResultBean bean=null;

        try {


            List<SystemMenu> list=mapper.selectall();
            List<SystemMenu> temp=new ArrayList<>();
            for (SystemMenu s:list
                 ) {
                for (SystemMenu s1:list
                     ) {
                      if (s.getMenuId().intValue()==s1.getMenuPid().intValue())///判断s1是否是s的子目录
                      {
                         s.getList().add(s1);
                         temp.add(s1);
                      }
                }
            }
            list.removeAll(temp);
            bean=new ResultBean(10000);
            bean.setObject(list);


        }catch (Exception e)
        {
            e.printStackTrace();
            bean=new ResultBean(30000);
            bean.setMessage(e.getMessage());
        }
        return bean;
    }
    @RequestMapping("saveorupadte")
    @ResponseBody
    public Object save(SystemMenu menu)
    {
        ResultBean bean=null;
        Integer rows=0;

        try {
            if (menu.getMenuId()!=null)
            {
                menu.setMenuLastmodify(new Date());
                rows=mapper.updateByPrimaryKeySelective(menu);

            }else {


                menu.setMenuCreatetime(new Date());
                menu.setMenuLastmodify(new Date());
                rows=mapper.insertSelective(menu);
            }
            if (rows>0)
            {
                bean=new ResultBean(10000);

            }
            else {
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
    @RequestMapping("deletemenu")
    @ResponseBody
    public Object delete(String menuid)
    {
        ResultBean bean=null;
        Integer rows=0;
        String str[]=menuid.split(",");


        try {


            if (str.length==0)
            {
                bean.setMessage("id为空");
                bean=new ResultBean(20000);

            }
            else {
                for (int i=0;i<str.length;i++)
                {
                   mapper.deleteByPrimaryKey(Integer.valueOf(str[i]));
                }
                rows=str.length;

            }
            if (rows>0)
            {
                bean=new ResultBean(10000);

            }
            else {
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






}
