package com.neusoft.bean;

import java.io.Serializable;

public class Pasthistory implements Serializable {
    private Integer ipasthistoryid;

    private Integer icaseid;

    private String vctype;

    private Integer ismuserid;

    private String bdel;

    private String vcdiseasename;

    private String dtfind;

    private static final long serialVersionUID = 1L;

    public Integer getIpasthistoryid() {
        return ipasthistoryid;
    }

    public void setIpasthistoryid(Integer ipasthistoryid) {
        this.ipasthistoryid = ipasthistoryid;
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

    public Integer getIsmuserid() {
        return ismuserid;
    }

    public void setIsmuserid(Integer ismuserid) {
        this.ismuserid = ismuserid;
    }

    public String getBdel() {
        return bdel;
    }

    public void setBdel(String bdel) {
        this.bdel = bdel == null ? null : bdel.trim();
    }

    public String getVcdiseasename() {
        return vcdiseasename;
    }

    public void setVcdiseasename(String vcdiseasename) {
        this.vcdiseasename = vcdiseasename == null ? null : vcdiseasename.trim();
    }

    public String getDtfind() {
        return dtfind;
    }

    public void setDtfind(String dtfind) {
        this.dtfind = dtfind == null ? null : dtfind.trim();
    }
}