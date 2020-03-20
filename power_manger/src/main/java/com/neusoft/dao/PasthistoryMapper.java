package com.neusoft.dao;

import com.neusoft.bean.Pasthistory;

import java.util.List;

public interface PasthistoryMapper {
    int deleteByPrimaryKey(Integer ipasthistoryid);

    int insert(Pasthistory record);

    int insertSelective(Pasthistory record);

    Pasthistory selectByPrimaryKey(Integer ipasthistoryid);

    int updateByPrimaryKeySelective(Pasthistory record);

    int updateByPrimaryKey(Pasthistory record);
    List<Pasthistory> selectByicaseid (Integer icaseid);
}