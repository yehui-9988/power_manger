package com.neusoft.bean;

import cn.afterturn.easypoi.excel.annotation.Excel;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Manger implements Serializable {
    public static  final String CURRENT_MANAGER="manager";
    private Integer managerId;


    @Excel(name = "手机")
    private String managerPhone;
    @Excel(name = "性别")
    private String managerSex;
    @Excel(name = "身份证")
    private String managerIdcard;

    private Integer managerCreateuser;

    private Date managerCreatetime;

    private Date managerLastmodify;

    private String managerPassword;

    private Integer managerState;

    public String getRolestr() {
        if (roles!=null&&roles.size()>0)
        {
            this.rolestr="";
            for (Role r:roles
            ) {
                this.rolestr+=r.getRoleName()+",";
            }
            this.rolestr=this.rolestr.substring(0,this.rolestr.length()-1);
        }

        return rolestr;
    }

    public void setRolestr(String rolestr) {
        this.rolestr = rolestr;
    }

    private String rolestr;



    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public List<Role> getRoles() {
        return roles;
    }

    public void setRoles(List<Role> roles) {
        this.roles = roles;

    }

    private List<Role> roles=new ArrayList<>();

    private String managerRemark;
    @Excel(name = "姓名")
    private String managerName;
    @Excel(name = "头像",savePath = "/uploderfiles/excel",type = 2)
    private String managerImg;

    private static final long serialVersionUID = 1L;

    public Integer getManagerId() {
        return managerId;
    }

    public void setManagerId(Integer managerId) {
        this.managerId = managerId;
    }

    public String getManagerPhone() {
        return managerPhone;
    }

    public void setManagerPhone(String managerPhone) {
        this.managerPhone = managerPhone == null ? null : managerPhone.trim();
    }

    public String getManagerSex() {
        return managerSex;
    }

    public void setManagerSex(String managerSex) {
        this.managerSex = managerSex == null ? null : managerSex.trim();
    }

    public String getManagerIdcard() {
        return managerIdcard;
    }

    public void setManagerIdcard(String managerIdcard) {
        this.managerIdcard = managerIdcard == null ? null : managerIdcard.trim();
    }

    public Integer getManagerCreateuser() {
        return managerCreateuser;
    }

    public void setManagerCreateuser(Integer managerCreateuser) {
        this.managerCreateuser = managerCreateuser;
    }

    public Date getManagerCreatetime() {
        return managerCreatetime;
    }

    public void setManagerCreatetime(Date managerCreatetime) {
        this.managerCreatetime = managerCreatetime;
    }

    public Date getManagerLastmodify() {
        return managerLastmodify;
    }

    public void setManagerLastmodify(Date managerLastmodify) {
        this.managerLastmodify = managerLastmodify;
    }

    public String getManagerPassword() {
        return managerPassword;
    }

    public void setManagerPassword(String managerPassword) {
        this.managerPassword = managerPassword == null ? null : managerPassword.trim();
    }

    public Integer getManagerState() {
        return managerState;
    }

    public void setManagerState(Integer managerState) {
        this.managerState = managerState;
    }

    public String getManagerRemark() {
        return managerRemark;
    }

    public void setManagerRemark(String managerRemark) {
        this.managerRemark = managerRemark == null ? null : managerRemark.trim();
    }

    public String getManagerName() {
        return managerName;
    }

    public void setManagerName(String managerName) {
        this.managerName = managerName == null ? null : managerName.trim();
    }

    public String getManagerImg() {
        return managerImg;
    }

    public void setManagerImg(String managerImg) {
        this.managerImg = managerImg == null ? null : managerImg.trim();
    }
}