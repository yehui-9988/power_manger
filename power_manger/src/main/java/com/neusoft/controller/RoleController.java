package com.neusoft.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.neusoft.bean.Manger;
import com.neusoft.bean.Role;
import com.neusoft.bean.RoleMenuRf;
import com.neusoft.dao.RoleMapper;
import com.neusoft.dao.RoleMenuRfMapper;
import com.neusoft.until.ResultBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.*;


@Controller
@RequestMapping("admin/role")
public class RoleController {
   @Autowired
   private RoleMapper mapper;
   @Autowired
   private RoleMenuRfMapper rfMapper;
    @RequestMapping("html")
    public String page()
    {

        return "admin/role/list";
    }

    @RequestMapping("list")
    @ResponseBody
    public Object findall()
    {
        ResultBean bean;
        try {

            List<Role> list=mapper.selectall();
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
    @RequestMapping("delete")
    @ResponseBody
    public Object deletebyid(Integer id)
    {
        ResultBean bean=null;
        Integer rows=0;

        try {


            rows=  mapper.deleteByPrimaryKey(id);
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

    @RequestMapping("save")
    @ResponseBody
    public Object save(Role role)
    {
        ResultBean bean=null;
        Integer rows=0;

        try {
            if (role.getRoleId()!=null)
            {
                role.setRoleLastmodify(new Date());
                rows=mapper.updateByPrimaryKeySelective(role);

            }else {


                role.setRoleCreatetime(new Date());
                role.setRoleLastmodify(new Date());
                rows=mapper.insertSelective(role);
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
    @RequestMapping("power")
    @ResponseBody
    public Object power(String  menuIds,Integer roleid)
    {
        ResultBean bean=null;
        try {

        Integer rows=0;
        rfMapper.deletebyroleid(roleid);
        if(menuIds!=null&&menuIds.length()>0) {


            String ids[] = menuIds.split("[,]");
            List<RoleMenuRf> list = new ArrayList<>();

            for (String s : ids
            ) {
                RoleMenuRf rf = new RoleMenuRf();
                rf.setRmrfMenuid(Integer.valueOf(s));
                rf.setRmrfRoleid(roleid);
                rf.setRmrfCreatetime(new Date());
                rf.setRmrfLastmodify(new Date());
                list.add(rf);
            }
            rows=rfMapper.insertAll(list);
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

    @RequestMapping("powerlist")
    @ResponseBody
    public Object powerlist( Integer roleid)
    {
        ResultBean bean;
        try {

            List<RoleMenuRf> list=rfMapper.selectbyroleid(roleid);
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

}
