package com.neusoft.controller;


import com.neusoft.bean.Manger;
import com.neusoft.dao.MangerMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


import java.util.HashMap;
import java.util.List;

@Controller
@RequestMapping("redis")
public class RedisController {

    @Autowired
    RedisTemplate template;
    @Autowired
    MangerMapper mapper;

    @RequestMapping("manager")
    public String initRedis()
    {
        List<Manger> list=mapper.selectall(new HashMap());
        ValueOperations valueOperations=template.opsForValue();

        for (Manger m:list)
        {
            valueOperations.set(m.getManagerPhone(),m );


        }
        return"/login/index";




    }
}
