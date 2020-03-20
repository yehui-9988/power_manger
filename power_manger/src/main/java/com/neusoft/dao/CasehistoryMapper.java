package com.neusoft.dao;

import com.neusoft.bean.Casehistory;

import java.util.List;

public interface CasehistoryMapper {
    int deleteByPrimaryKey(Integer icasehistoryid);

    int insert(Casehistory record);

    int insertSelective(Casehistory record);

    Casehistory selectByPrimaryKey(Integer icasehistoryid);

    int updateByPrimaryKeySelective(Casehistory record);

    int updateByPrimaryKey(Casehistory record);

     List<Casehistory> selectall();
}