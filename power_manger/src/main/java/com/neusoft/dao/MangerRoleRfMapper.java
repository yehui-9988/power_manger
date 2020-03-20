package com.neusoft.dao;

import com.neusoft.bean.MangerRoleRf;

import java.util.List;

public interface MangerRoleRfMapper {
    int deleteByPrimaryKey(Integer rfId);

    int insert(MangerRoleRf record);

    int insertSelective(MangerRoleRf record);

    MangerRoleRf selectByPrimaryKey(Integer rfId);

    int updateByPrimaryKeySelective(MangerRoleRf record);

    int updateByPrimaryKey(MangerRoleRf record);

    int deletebyMangerid(Integer managerid);

    int insertall(List<MangerRoleRf> list);

}