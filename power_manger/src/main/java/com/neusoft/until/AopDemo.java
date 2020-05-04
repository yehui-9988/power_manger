package com.neusoft.until;


import com.neusoft.bean.Manger;
import com.neusoft.bean.Role;
import com.neusoft.bean.SystemMenu;
import com.neusoft.controller.Mangercontroller;
import com.neusoft.controller.RoleController;
import com.neusoft.controller.SystemMenucontroller;
import com.neusoft.controller.Utilcontroller;
import com.neusoft.dao.MangerMapper;
import org.apache.log4j.Logger;
import org.apache.poi.ss.formula.functions.T;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.management.RuntimeErrorException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;

@Component
@Aspect
public class AopDemo {
    Logger logger=Logger.getLogger(AopDemo.class);

    @Autowired
    HttpSession session;
    @Autowired
    MangerMapper mangerMapper;

    @Autowired
    RedisTemplate template;




    Utilcontroller utilcontroller=new Utilcontroller();


    @Pointcut("execution(public * com.neusoft.controller.*.*(..))")
    public void poincut()
    {


    }

  @Before("poincut()")
    public void before(JoinPoint joinPoint) throws Exception
    {
        Manger manager=(Manger) session.getAttribute(Manger.CURRENT_MANAGER);
        HttpServletRequest request =((ServletRequestAttributes) RequestContextHolder.getRequestAttributes())
                .getRequest();
       if (null !=manager) {
           String  classone = joinPoint.getTarget().getClass().getName();
           if (null==manager.getRolestr()||manager.getRolestr().equals(""))
           {

               session.removeAttribute(Manger.CURRENT_MANAGER);
               try {
                   throw  new RuntimeException("没有角色，请联系管理员");

               }catch (Exception e)
               {
                 utilcontroller.todologin();

               }finally {



               }
                 //  session.removeAttribute(Manger.CURRENT_MANAGER);

           }

           String url = request.getRequestURI();
           String url2 = url.substring(url.lastIndexOf("/") + 1,
                   url.lastIndexOf("?") == -1 ? url.length() : url.lastIndexOf("?"));
           switch (manager.getRolestr()) {
               case "超级管理员":
                   break;
               case "普通管理员":
                   if (classone.equals(SystemMenucontroller.class.getName())) {

                       if(joinPoint.getSignature().getName().equals("findbymangerid"))
                       {
                           return ;

                       }else {
                           throw new RuntimeException("没有权限");
                       }
                   }
                   break;
               default:
                   if (classone.equals(Mangercontroller.class.getName())|classone.equals(SystemMenucontroller.class.getName()) )
                   {
                       //||classone.equals(SystemMenucontroller.class.getName()) ||classone.equals(RoleController.class.getName())
                       if(joinPoint.getSignature().getName().equals("findbymangerid"))
                       {
                           return ;

                       }else {
                           throw new RuntimeException(manager.getRolestr()+"没有此菜单的权限");
                       }

                   }

                   break;

           }
       }
       else
       {
           utilcontroller.todologin();
       }

       // if (classone instanceof Manger || classone instanceof SystemMenu)

    }
    @After("poincut()")
    public void After(JoinPoint joinPoint)
    {
        HttpServletRequest request =((ServletRequestAttributes) RequestContextHolder.getRequestAttributes())
                .getRequest();
        String url = request.getRequestURI();
        System.out.println(url);

  /*      List<Manger> list=mangerMapper.selectall(new HashMap());
        ValueOperations valueOperations=template.opsForValue();

        for (Manger m:list)
        {
            valueOperations.set(m.getManagerPhone(),m );

        }*/

    }

    @AfterReturning(pointcut = "poincut()",returning = "obj")
    public void returning(JoinPoint point,Object obj)
    {
        System.out.println("返回值");
        System.out.println("方法名"+point.getSignature().getName()+"\n类型:"+point.getTarget().getClass().getName());
        System.out.println("类型"+obj.getClass().getName());
    }
    @Around("poincut()")
    public Object around(ProceedingJoinPoint point)throws Throwable
    {

            System.out.println("方法名"+point.getSignature().getName()+"\n类型:"+point.getTarget().getClass().getName());
            long starttime=System.currentTimeMillis();
            Object obj=point.proceed();
            long endtime=System.currentTimeMillis();
             System.out.println("耗时："+(endtime-starttime));
             return obj;
    }


}
