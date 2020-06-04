package com.neusoft.dao;

import com.neusoft.bean.Role;
import com.neusoft.bean.RoleMenuRf;
import java.util.List;

public interface RoleMenuRfMapper {
    int deleteByPrimaryKey(Integer rmrfId);

    int insert(RoleMenuRf record);

    int insertSelective(RoleMenuRf record);

    RoleMenuRf selectByPrimaryKey(Integer rmrfId);

    int updateByPrimaryKeySelective(RoleMenuRf record);

     int updateByPrimaryKey(RoleMenuRf record);
     int deletebyroleid (Integer roleid);
     int insertAll(List<RoleMenuRf> list);
     List  selectbyroleid(Integer roleid);
}