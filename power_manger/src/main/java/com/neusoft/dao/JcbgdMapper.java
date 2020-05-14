package com.neusoft.dao;

import com.neusoft.bean.Jcbgd;

import java.util.List;

public interface JcbgdMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Jcbgd record);

    int insertSelective(Jcbgd record);

    Jcbgd selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Jcbgd record);

    int updateByPrimaryKey(Jcbgd record);
    List<Jcbgd> selectbyicaseid(int id);
}