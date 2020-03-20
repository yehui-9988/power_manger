package com.neusoft.bean;

import java.io.Serializable;
import java.util.Date;

public class MangerRoleRf implements Serializable {
    private Integer rfId;

    private Integer rfMangerid;

    private Integer rfRoleid;

    private Integer rfCreateuser;

    private Date rfCreatetime;

    private Date rfLastmodify;

    private static final long serialVersionUID = 1L;

    public Integer getRfId() {
        return rfId;
    }

    public void setRfId(Integer rfId) {
        this.rfId = rfId;
    }

    public Integer getRfMangerid() {
        return rfMangerid;
    }

    public void setRfMangerid(Integer rfMangerid) {
        this.rfMangerid = rfMangerid;
    }

    public Integer getRfRoleid() {
        return rfRoleid;
    }

    public void setRfRoleid(Integer rfRoleid) {
        this.rfRoleid = rfRoleid;
    }

    public Integer getRfCreateuser() {
        return rfCreateuser;
    }

    public void setRfCreateuser(Integer rfCreateuser) {
        this.rfCreateuser = rfCreateuser;
    }

    public Date getRfCreatetime() {
        return rfCreatetime;
    }

    public void setRfCreatetime(Date rfCreatetime) {
        this.rfCreatetime = rfCreatetime;
    }

    public Date getRfLastmodify() {
        return rfLastmodify;
    }

    public void setRfLastmodify(Date rfLastmodify) {
        this.rfLastmodify = rfLastmodify;
    }
}