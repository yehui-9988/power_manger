package com.neusoft.dao;

import com.neusoft.bean.Vitalsigns;

import java.util.List;

public interface VitalsignsMapper {
    int deleteByPrimaryKey(Integer ivitalsignsid);

    int insert(Vitalsigns record);

    int insertSelective(Vitalsigns record);

    Vitalsigns selectByPrimaryKey(Integer ivitalsignsid);

    int updateByPrimaryKeySelective(Vitalsigns record);

    int updateByPrimaryKey(Vitalsigns record);
    Vitalsigns selectByicaseid(int id);
}