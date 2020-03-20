package com.neusoft.bean;

import java.io.Serializable;
import java.util.Date;

public class Role implements Serializable {
    private Integer roleId;

    private String roleName;

    private Integer roleCreateuser;

    private Date roleCreatetime;

    private Date roleLastmodify;

    private static final long serialVersionUID = 1L;

    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName == null ? null : roleName.trim();
    }

    public Integer getRoleCreateuser() {
        return roleCreateuser;
    }

    public void setRoleCreateuser(Integer roleCreateuser) {
        this.roleCreateuser = roleCreateuser;
    }

    public Date getRoleCreatetime() {
        return roleCreatetime;
    }

    public void setRoleCreatetime(Date roleCreatetime) {
        this.roleCreatetime = roleCreatetime;
    }

    public Date getRoleLastmodify() {
        return roleLastmodify;
    }

    public void setRoleLastmodify(Date roleLastmodify) {
        this.roleLastmodify = roleLastmodify;
    }
}