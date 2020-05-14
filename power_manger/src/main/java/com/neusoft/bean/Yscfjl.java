package com.neusoft.bean;

import java.io.Serializable;

public class Yscfjl implements Serializable {
    private Integer id;

    private Integer icaseid;

    private String url;

    private String bodel;

    private String bgdname;

    private static final long serialVersionUID = 1L;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getIcaseid() {
        return icaseid;
    }

    public void setIcaseid(Integer icaseid) {
        this.icaseid = icaseid;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url == null ? null : url.trim();
    }

    public String getBodel() {
        return bodel;
    }

    public void setBodel(String bodel) {
        this.bodel = bodel == null ? null : bodel.trim();
    }

    public String getBgdname() {
        return bgdname;
    }

    public void setBgdname(String bgdname) {
        this.bgdname = bgdname == null ? null : bgdname.trim();
    }
}