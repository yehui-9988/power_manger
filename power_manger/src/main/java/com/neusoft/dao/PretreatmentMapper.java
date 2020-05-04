package com.neusoft.dao;

import com.neusoft.bean.Pretreatment;

import java.util.List;

public interface PretreatmentMapper {
    int deleteByPrimaryKey(Integer preid);

    int insert(Pretreatment record);

    int insertSelective(Pretreatment record);

    Pretreatment selectByPrimaryKey(Integer preid);

    int updateByPrimaryKeySelective(Pretreatment record);

    int updateByPrimaryKey(Pretreatment record);
    List<Pretreatment> selectByicaseid(int icaseid);
}