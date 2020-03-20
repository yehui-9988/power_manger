package com.neusoft.until;


import com.neusoft.bean.SystemMenu;
import org.apache.log4j.Logger;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.*;
import org.springframework.stereotype.Component;

@Component
@Aspect
public class AopDemo {
    Logger logger=Logger.getLogger(AopDemo.class);

    @Pointcut("execution(public * com.neusoft.controller.*.*(..))")
    public void poincut()
    {

    }

    @Before("poincut()")
    public void before(JoinPoint joinPoint)
    {
        String className =joinPoint.getTarget().getClass().getName();
        String methodName=joinPoint.getSignature().getName();
        System.out.println("方法调用前");
        System.out.println("类名--"+className+"方法名字："+methodName);
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
