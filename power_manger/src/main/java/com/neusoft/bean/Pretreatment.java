package com.neusoft.bean;

import java.io.Serializable;

public class Pretreatment implements Serializable {
    private Integer preid;

    private Integer icaseid;

    private String vctype;

    private String vcdrugname;

    private String vczjl;

    private String vcgycj;

    private String begintime;

    private String endtime;

    private String vccontent;

    private static final long serialVersionUID = 1L;

    public Integer getPreid() {
        return preid;
    }

    public void setPreid(Integer preid) {
        this.preid = preid;
    }

    public Integer getIcaseid() {
        return icaseid;
    }

    public void setIcaseid(Integer icaseid) {
        this.icaseid = icaseid;
    }

    public String getVctype() {
        return vctype;
    }

    public void setVctype(String vctype) {
        this.vctype = vctype == null ? null : vctype.trim();
    }

    public String getVcdrugname() {
        return vcdrugname;
    }

    public void setVcdrugname(String vcdrugname) {
        this.vcdrugname = vcdrugname == null ? null : vcdrugname.trim();
    }

    public String getVczjl() {
        return vczjl;
    }

    public void setVczjl(String vczjl) {
        this.vczjl = vczjl == null ? null : vczjl.trim();
    }

    public String getVcgycj() {
        return vcgycj;
    }

    public void setVcgycj(String vcgycj) {
        this.vcgycj = vcgycj == null ? null : vcgycj.trim();
    }

    public String getBegintime() {
        return begintime;
    }

    public void setBegintime(String begintime) {
        this.begintime = begintime == null ? null : begintime.trim();
    }

    public String getEndtime() {
        return endtime;
    }

    public void setEndtime(String endtime) {
        this.endtime = endtime == null ? null : endtime.trim();
    }

    public String getVccontent() {
        return vccontent;
    }

    public void setVccontent(String vccontent) {
        this.vccontent = vccontent == null ? null : vccontent.trim();
    }
}