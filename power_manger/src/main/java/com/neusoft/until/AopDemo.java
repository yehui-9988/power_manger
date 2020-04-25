package com.neusoft.until;


import com.neusoft.bean.Manger;
import com.neusoft.bean.Role;
import com.neusoft.bean.SystemMenu;
import com.neusoft.controller.Mangercontroller;
import com.neusoft.controller.RoleController;
import com.neusoft.controller.SystemMenucontroller;
import com.neusoft.dao.MangerMapper;
import org.apache.log4j.Logger;
import org.apache.poi.ss.formula.functions.T;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.management.RuntimeErrorException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Component
@Aspect
public class AopDemo {
    Logger logger=Logger.getLogger(AopDemo.class);

    @Autowired
    HttpSession session;
    @Autowired
    MangerMapper mangerMapper;

    @Pointcut("execution(public * com.neusoft.controller.*.*(..))")
    public void poincut()
    {


    }

    @Before("poincut()")
    public void before(JoinPoint joinPoint) throws Exception
    {
        Manger manager=(Manger) session.getAttribute(Manger.CURRENT_MANAGER);
       /* List<Role> list= manager.getRoles();
        for (Role r:list
             ) {
           r.getRoleName();
        }*/
       if (null !=manager) {
           String  classone = joinPoint.getTarget().getClass().getName();
           if (null==manager.getRolestr())
           {
               session.removeAttribute(Manger.CURRENT_MANAGER);
               throw  new RuntimeException("没有角色，请联系管理员");
           }
           HttpServletRequest request =((ServletRequestAttributes) RequestContextHolder.getRequestAttributes())
                   .getRequest();

           String url = request.getRequestURI();
           String url2 = url.substring(url.lastIndexOf("/") + 1,
                   url.lastIndexOf("?") == -1 ? url.length() : url.lastIndexOf("?"));
           switch (manager.getRolestr()) {
               case "超级管理员":

                   break;
               case "系统管理员":

                   if (classone.equals("SystemMenu")) {
                       throw new RuntimeException("没有权限");
                   }
                   break;
               default:
                   if (classone.equals(Mangercontroller.class.getName())||classone.equals(SystemMenucontroller.class.getName()) )
                   {
                       //||classone.equals(SystemMenucontroller.class.getName()) ||classone.equals(RoleController.class.getName())
                       throw new RuntimeException("没有权限");
                   }
                   System.out.println("吊");
                   break;

           }
       }
       else
       {
           System.out.println("方法执行前");
       }
       // if (classone instanceof Manger || classone instanceof SystemMenu)




    }
    @After("poincut()")
    public void After(JoinPoint joinPoint)
    {
        String className =joinPoint.getTarget().getClass().getName();
        String methodName=joinPoint.getSignature().getName();
        System.out.println("方法调用后");
        System.out.println("类名后--"+className+"方法名字："+methodName);

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
