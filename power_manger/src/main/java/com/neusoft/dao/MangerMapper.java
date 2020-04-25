package com.neusoft.dao;

import com.neusoft.bean.Manger;

import java.util.List;
import java.util.Map;

public interface MangerMapper {
    int deleteByPrimaryKey(Integer managerId);

    int insert(Manger record);

    int insertSelective(Manger record);

    Manger selectByPrimaryKey(Integer managerId);

    int updateByPrimaryKeySelective(Manger record);

    int updateByPrimaryKey(Manger record);
    int deleteall (List<Integer> list);

    List<Manger> selectall(Map map);
    List<Manger> loginselect(Map map);
    Manger selectrole(Integer managerId);

}