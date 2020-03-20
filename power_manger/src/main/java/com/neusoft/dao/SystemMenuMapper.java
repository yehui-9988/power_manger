package com.neusoft.dao;

import com.neusoft.bean.SystemMenu;

import java.util.List;

public interface SystemMenuMapper {
    int deleteByPrimaryKey(Integer menuId);

    int insert(SystemMenu record);

    int insertSelective(SystemMenu record);

    SystemMenu selectByPrimaryKey(Integer menuId);

    int updateByPrimaryKeySelective(SystemMenu record);

    int updateByPrimaryKey(SystemMenu record);
    List<SystemMenu> selectall();
    List<SystemMenu> selectByManagerId(Integer managerid);
}