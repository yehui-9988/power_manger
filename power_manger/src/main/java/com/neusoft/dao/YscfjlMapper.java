package com.neusoft.dao;

import com.neusoft.bean.Jcbgd;
import com.neusoft.bean.Yscfjl;

import java.util.List;

public interface YscfjlMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Yscfjl record);

    int insertSelective(Yscfjl record);

    Yscfjl selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Yscfjl record);

    int updateByPrimaryKey(Yscfjl record);
    List<Yscfjl> selectbyicaseid(int id);
}