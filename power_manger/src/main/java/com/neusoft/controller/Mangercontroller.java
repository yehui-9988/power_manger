package com.neusoft.controller;


import cn.afterturn.easypoi.cache.manager.IFileLoader;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException;
import com.neusoft.bean.Manger;
import com.neusoft.bean.MangerRoleRf;
import com.neusoft.bean.RoleMenuRf;
import com.neusoft.dao.MangerMapper;
import com.neusoft.dao.MangerRoleRfMapper;
import com.neusoft.until.Content;
import com.neusoft.until.ResultBean;
import com.neusoft.until.poi.PoiUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("admin/manager")
public class Mangercontroller {

    @Autowired
    private MangerMapper mapper;
    @Autowired
    private MangerRoleRfMapper rfMapper;
    @Autowired
    private RedisTemplate redisTemplate;

    @RequestMapping("html")
    public String page()
    {

     return "admin/manager/list";
    }

    /**
     *
     * @param index 当前页码
     * @param size   当前页条数
     * @param param   模糊查询参数
     * @param phone    根据手机号码查询
     * @return
     */
    @RequestMapping("list")
    @ResponseBody
     public Object findall( Integer index,Integer size,String order,String prop,String param,String phone)
     {
             ResultBean bean=null;
             Map map=new HashMap();
             map.put("param",param );
             map.put("phone",phone );
             map.put("orderx",order );
             map.put("prop", Content.to_col(prop));
             index=index==null?1:index;
             size=size==null?5:size;
         try {

             PageHelper.startPage(index,size);
             List<Manger> list=  mapper.selectall(map);
             PageInfo<Manger> info=new PageInfo<>(list);
             bean=new ResultBean(10000);
             bean.setObject(info);

         }catch (RuntimeException e)
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

            Manger manger=mapper.selectByPrimaryKey(id);
            redisTemplate.delete(manger.getManagerPhone()); //删除缓存
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

    @RequestMapping("deleteall")
    @ResponseBody
    public Object deleteall( @RequestParam("ids") String ids)
    {
        ResultBean bean=null;
        Integer rows=0;
        String str[]=ids.split(",");
        List<Integer>list=new ArrayList<>();
        for (String id: str
             ) {

              list.add(Integer.valueOf(id));
              Manger manger= mapper.selectByPrimaryKey(Integer.valueOf(id));
              redisTemplate.delete(manger.getManagerPhone());//删除缓存
        }
//        String[] idsx=ids.split("[,]");

        try {


            rows=  mapper.deleteall(list);
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
///上传头像
    @RequestMapping("upload")
    @ResponseBody
    public Object upload(
            @RequestParam(value = "file",required = true)MultipartFile file, HttpServletRequest Request
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
                 int month=calendar.get(Calendar.MONDAY);
                 int date=calendar.get(Calendar.DATE);
                 String dirName="/"+year+"/"+month+"/"+date;
                 File file1 =new File(filepath,dirName);
                 if (!file1.exists())
                 {
                     boolean flag=file1.mkdirs();
                 }
                 String organame=file.getOriginalFilename();
                 String fileName= UUID.randomUUID().toString()+organame.substring(organame.lastIndexOf("."));
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
///批量导入
    @RequestMapping("uploadall")
    @ResponseBody
    public Object uploadall(
            @RequestParam(value = "file",required = true)MultipartFile file, HttpServletRequest Request
    )
    {
        ResultBean bean=null;
        int rows=0;
        try {
            if (file!=null)
            {

                List<Manger> list=PoiUtil.importExcel(file, 0, 1, Manger.class);
                for (Manger m:list
                     ) {
                      m.setManagerPassword("000000");
                      m.setManagerCreatetime(new Date());
                      mapper.insertSelective(m);
                      Manger m2=mapper.selectrole(m.getManagerId());
                      redisTemplate.opsForValue().set(m2.getManagerPhone(),m2);

                      rows++;
                }
                if (rows==list.size())
                {
                    bean=new ResultBean(10000);
                }




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


    ///添加修改功能

    @RequestMapping("save")
    @ResponseBody
    public Object save(Manger manger)
    {
        ResultBean bean=null;
        Integer rows=0;

        try {
            if (manger.getManagerId()!=null)
            {
                manger.setManagerLastmodify(new Date());
                rows=mapper.updateByPrimaryKeySelective(manger);

            }else {
                manger.setManagerPassword("000000");
                manger.setManagerCreatetime(new Date());
                manger.setManagerLastmodify(new Date());
                rows=mapper.insertSelective(manger);
            }
            if (rows>0)
            {
                HashMap<String,String> map=new HashMap<>();
                map.put("phone",manger.getManagerPhone());
                List<Manger> list1=mapper.selectall(map);
                redisTemplate.opsForValue().set(list1.get(0).getManagerPhone(),list1.get(0));
                bean=new ResultBean(10000);
            }
            else {
                bean=new ResultBean(20000);
            }
        }catch(RuntimeException e)
        {
            e.printStackTrace();
            bean=new ResultBean(30001);
            bean.setMessage(e.getMessage());
        }
        return bean;
    }
    ///修改密码
    @RequestMapping("modifypassword")
    @ResponseBody
    public  Object modifypassword(String id,String pwd ,String newpwd)
    {
        ResultBean bean=null;
        int rows=0;
        Manger manger=mapper.selectByPrimaryKey(Integer.parseInt(id));
        if (manger.getManagerPassword().equals(pwd))
        {
            manger.setManagerPassword(newpwd);
            rows=mapper.updateByPrimaryKeySelective(manger);

            Manger m=mapper.selectrole(manger.getManagerId());
            redisTemplate.opsForValue().set(m.getManagerPhone(),m);

            if (rows>0)
            {
                bean=new ResultBean(10000);
            }
            else {
                bean=new ResultBean(20000);
            }

        }else {
            //20001 原密码错误
            bean=new ResultBean(20001);
            bean.setMessage("原密码错误");
        }



        return bean;
    }


    @RequestMapping("savepower")
    @ResponseBody
    public Object savepower(
            String  roleids,
            Integer manageid
    )
    {
        ResultBean bean=null;
        Integer rows=0;

        try {


            String ids[] = roleids.split("[,]");
            List<MangerRoleRf> list = new ArrayList<>();

            for (String s : ids
            ) {
               MangerRoleRf rf=new MangerRoleRf();
               rf.setRfCreatetime(new Date());
               rf.setRfLastmodify(new Date());
               rf.setRfMangerid(manageid);
               rf.setRfRoleid(Integer.valueOf(s));
               list.add(rf);
            }
            rows=rfMapper.deletebyMangerid(manageid);
            if (list.size()>0)
            {
                rows=rfMapper.insertall(list);
            }

        if (rows>0)
        {
            Manger manger= mapper.selectByPrimaryKey(manageid);
            HashMap<String,String> map=new HashMap<>();
            map.put("phone",manger.getManagerPhone());
            List<Manger> list1=mapper.selectall(map);
            redisTemplate.opsForValue().set(list1.get(0).getManagerPhone(),list1.get(0));

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
