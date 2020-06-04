package com.neusoft.dao;

import com.neusoft.bean.Pqxzzz;

import java.util.List;

public interface PqxzzzMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Pqxzzz record);

    int insertSelective(Pqxzzz record);

    Pqxzzz selectByPrimaryKey(Integer id,Integer vctype);

    int updateByPrimaryKeySelective(Pqxzzz record);

    int updateByPrimaryKey(Pqxzzz record);
    List<Pqxzzz> drawpic(int icaseid);
}