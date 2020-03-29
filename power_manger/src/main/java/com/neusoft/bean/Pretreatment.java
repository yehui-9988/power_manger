package com.neusoft.bean;

import java.io.Serializable;

public class Pretreatment implements Serializable {
    private Integer preid;

    private Integer icaseid;

    private String vctype;

    private String ismuserid;

    private String bdel;

    private String vcdrugname;

    private String vczjl;

    private String vcdw;

    private String vcgycj;

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

    public String getIsmuserid() {
        return ismuserid;
    }

    public void setIsmuserid(String ismuserid) {
        this.ismuserid = ismuserid == null ? null : ismuserid.trim();
    }

    public String getBdel() {
        return bdel;
    }

    public void setBdel(String bdel) {
        this.bdel = bdel == null ? null : bdel.trim();
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

    public String getVcdw() {
        return vcdw;
    }

    public void setVcdw(String vcdw) {
        this.vcdw = vcdw == null ? null : vcdw.trim();
    }

    public String getVcgycj() {
        return vcgycj;
    }

    public void setVcgycj(String vcgycj) {
        this.vcgycj = vcgycj == null ? null : vcgycj.trim();
    }
}