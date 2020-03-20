package com.neusoft.bean;

import java.io.Serializable;
import java.util.Date;

public class RoleMenuRf implements Serializable {
    private Integer rmrfId;

    private Integer rmrfRoleid;

    private Integer rmrfMenuid;

    private Integer rmrfCreateuser;

    private Date rmrfCreatetime;

    private Date rmrfLastmodify;

    private static final long serialVersionUID = 1L;

    public Integer getRmrfId() {
        return rmrfId;
    }

    public void setRmrfId(Integer rmrfId) {
        this.rmrfId = rmrfId;
    }

    public Integer getRmrfRoleid() {
        return rmrfRoleid;
    }

    public void setRmrfRoleid(Integer rmrfRoleid) {
        this.rmrfRoleid = rmrfRoleid;
    }

    public Integer getRmrfMenuid() {
        return rmrfMenuid;
    }

    public void setRmrfMenuid(Integer rmrfMenuid) {
        this.rmrfMenuid = rmrfMenuid;
    }

    public Integer getRmrfCreateuser() {
        return rmrfCreateuser;
    }

    public void setRmrfCreateuser(Integer rmrfCreateuser) {
        this.rmrfCreateuser = rmrfCreateuser;
    }

    public Date getRmrfCreatetime() {
        return rmrfCreatetime;
    }

    public void setRmrfCreatetime(Date rmrfCreatetime) {
        this.rmrfCreatetime = rmrfCreatetime;
    }

    public Date getRmrfLastmodify() {
        return rmrfLastmodify;
    }

    public void setRmrfLastmodify(Date rmrfLastmodify) {
        this.rmrfLastmodify = rmrfLastmodify;
    }
}