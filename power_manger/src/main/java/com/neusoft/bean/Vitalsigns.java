package com.neusoft.bean;

import java.io.Serializable;

public class Vitalsigns implements Serializable {
    private Integer ivitalsignsid;

    private String icaseid;

    private String vctype;

    private Integer ismuserid;

    private String bdel;

    private String vchigh;

    private String vcweight;

    private String vcssy;

    private String vcszy;

    private static final long serialVersionUID = 1L;

    public Integer getIvitalsignsid() {
        return ivitalsignsid;
    }

    public void setIvitalsignsid(Integer ivitalsignsid) {
        this.ivitalsignsid = ivitalsignsid;
    }

    public String getIcaseid() {
        return icaseid;
    }

    public void setIcaseid(String icaseid) {
        this.icaseid = icaseid == null ? null : icaseid.trim();
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

    public String getVchigh() {
        return vchigh;
    }

    public void setVchigh(String vchigh) {
        this.vchigh = vchigh == null ? null : vchigh.trim();
    }

    public String getVcweight() {
        return vcweight;
    }

    public void setVcweight(String vcweight) {
        this.vcweight = vcweight == null ? null : vcweight.trim();
    }

    public String getVcssy() {
        return vcssy;
    }

    public void setVcssy(String vcssy) {
        this.vcssy = vcssy == null ? null : vcssy.trim();
    }

    public String getVcszy() {
        return vcszy;
    }

    public void setVcszy(String vcszy) {
        this.vcszy = vcszy == null ? null : vcszy.trim();
    }
}