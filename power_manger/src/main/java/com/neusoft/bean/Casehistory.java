package com.neusoft.bean;

import java.io.Serializable;

public class Casehistory implements Serializable {
    private Integer icasehistoryid;

    private String vctype;

    private Integer ismuserid;

    private String bdel;

    private String vcname;

    private String vcnation;

    private String vcsex;

    private String vcoccupation;

    private String vcaddress;

    private String vcmarry;

    private String vceducation;

    private String vcsmoke;

    private String vcmdrecord;

    private String dtregister;

    private String vcserialnum;

    private String bsubmit;

    private String vcidentity;

    private String vcphone;

    private static final long serialVersionUID = 1L;

    public Integer getIcasehistoryid() {
        return icasehistoryid;
    }

    public void setIcasehistoryid(Integer icasehistoryid) {
        this.icasehistoryid = icasehistoryid;
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

    public String getVcname() {
        return vcname;
    }

    public void setVcname(String vcname) {
        this.vcname = vcname == null ? null : vcname.trim();
    }

    public String getVcnation() {
        return vcnation;
    }

    public void setVcnation(String vcnation) {
        this.vcnation = vcnation == null ? null : vcnation.trim();
    }

    public String getVcsex() {
        return vcsex;
    }

    public void setVcsex(String vcsex) {
        this.vcsex = vcsex == null ? null : vcsex.trim();
    }

    public String getVcoccupation() {
        return vcoccupation;
    }

    public void setVcoccupation(String vcoccupation) {
        this.vcoccupation = vcoccupation == null ? null : vcoccupation.trim();
    }

    public String getVcaddress() {
        return vcaddress;
    }

    public void setVcaddress(String vcaddress) {
        this.vcaddress = vcaddress == null ? null : vcaddress.trim();
    }

    public String getVcmarry() {
        return vcmarry;
    }

    public void setVcmarry(String vcmarry) {
        this.vcmarry = vcmarry == null ? null : vcmarry.trim();
    }

    public String getVceducation() {
        return vceducation;
    }

    public void setVceducation(String vceducation) {
        this.vceducation = vceducation == null ? null : vceducation.trim();
    }

    public String getVcsmoke() {
        return vcsmoke;
    }

    public void setVcsmoke(String vcsmoke) {
        this.vcsmoke = vcsmoke == null ? null : vcsmoke.trim();
    }

    public String getVcmdrecord() {
        return vcmdrecord;
    }

    public void setVcmdrecord(String vcmdrecord) {
        this.vcmdrecord = vcmdrecord == null ? null : vcmdrecord.trim();
    }

    public String getDtregister() {
        return dtregister;
    }

    public void setDtregister(String dtregister) {
        this.dtregister = dtregister == null ? null : dtregister.trim();
    }

    public String getVcserialnum() {
        return vcserialnum;
    }

    public void setVcserialnum(String vcserialnum) {
        this.vcserialnum = vcserialnum == null ? null : vcserialnum.trim();
    }

    public String getBsubmit() {
        return bsubmit;
    }

    public void setBsubmit(String bsubmit) {
        this.bsubmit = bsubmit == null ? null : bsubmit.trim();
    }

    public String getVcidentity() {
        return vcidentity;
    }

    public void setVcidentity(String vcidentity) {
        this.vcidentity = vcidentity == null ? null : vcidentity.trim();
    }

    public String getVcphone() {
        return vcphone;
    }

    public void setVcphone(String vcphone) {
        this.vcphone = vcphone == null ? null : vcphone.trim();
    }
}