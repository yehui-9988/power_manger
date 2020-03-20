package com.neusoft.controller;


import com.neusoft.bean.Manger;
import com.neusoft.dao.MangerMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.HashOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.SetOperations;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

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
//        HashOperations hashOperations= template.opsForHash();
//
//        HashMap map=new HashMap();
//        map.put("1", "张三");
//        map.put("2", "张三22");
//        map.put("3", "张三33");
//        hashOperations.putAll("testhash",map );
//        hashOperations.put("testhash", "4", "张三44");
//
////        hashOperations.put("testmap", , );
//        Object object=hashOperations.get("testhash", "1");
//        SetOperations setOperations=template.opsForSet();
//        setOperations.add("users","李四","张三","王五");
//        Set<String> set=new TreeSet<>();
//        set.add("你好");
//        setOperations.add("testset",set);
//        template.opsForValue();




    }
}
