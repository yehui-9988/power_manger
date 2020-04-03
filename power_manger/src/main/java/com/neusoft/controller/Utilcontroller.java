package com.neusoft.controller;

import com.neusoft.bean.Manger;
import com.neusoft.dao.MangerMapper;
import com.neusoft.until.ResultBean;
import com.neusoft.until.VerifyCodeUtils;
import org.apache.ibatis.executor.ResultExtractor;
import org.omg.PortableServer.POAPackage.ObjectAlreadyActive;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("util")
public class Utilcontroller  extends BaseController{

    @Autowired
    private MangerMapper mapper;
    @Autowired
    private RedisTemplate redisTemplate;


    @RequestMapping("login")
    public String todologin()
    {
        return "/login/index";
    }
    @ResponseBody
    @RequestMapping("login/do")
    public Object login (String password, String username, String code,HttpSession session)
    {
        ResultBean bean=null;
        try {
            String mycode=(String) session.getAttribute("code");

            if (!code.equalsIgnoreCase(mycode))
            {
                bean=new ResultBean();
                bean.setMessage("验证码错误");
            }
            else {
                ///删除验证码
                session.removeAttribute("code");
//                Map map = new HashMap();
//                map.put("username", username);
//                map.put("password", password);
                //获取maanger 对象
                Manger manger=(Manger)redisTemplate.opsForValue().get(username);
                //从redis获取密码比较是否正确；
                if (manger!=null&&manger.getManagerPassword().equals(password))
                {
                    bean = new ResultBean(10000);
                    session.setAttribute(Manger.CURRENT_MANAGER, manger);

                }else {
                    bean.setMessage("账号或者密码错误");

                }


//                List<Manger> list = mapper.loginselect(map);
//                if (map != null && map.size() > 0) {
//                    bean = new ResultBean(10000);
//                    session.setAttribute(Manger.CURRENT_MANAGER, list.get(0));
//                } else {
//                    bean.setMessage("账号或者密码错误");
//                }
         }

        }catch (Exception e)
        {
            e.printStackTrace();
            bean=new ResultBean(30000);
        }
        return bean;
    }



    @RequestMapping("code")
    public void showcodeimg(HttpSession session, HttpServletResponse response)
    {

        String code= VerifyCodeUtils.generateVerifyCode(4);
        session.setAttribute("code", code);
     try {

         VerifyCodeUtils.outputImage(100, 44, response.getOutputStream(),code);
         response.getOutputStream().flush();
         response.getOutputStream().close();

     }catch (Exception e)
     {
         e.printStackTrace();
     }

    }
    @RequestMapping("login/exit")
    public Object loginexit()
    {
        session.removeAttribute(Manger.CURRENT_MANAGER);
        ResultBean resultBean=new ResultBean(10001);
        resultBean.setMessage("成功退出");
        return resultBean;
    }


}
