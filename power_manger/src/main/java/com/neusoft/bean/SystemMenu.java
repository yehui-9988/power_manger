package com.neusoft.bean;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class SystemMenu implements Serializable {
    private Integer menuId;

    private String menuTitle;

    private String menuLink;

    private String menuIco;

    private Integer menuLevel;

    private Integer menuPid;

    private String menuAlt;

    private Integer menuCreateuser;

    private Date menuCreatetime;

    private Date menuLastmodify;
    private  Integer menu_order;

    public Integer getMenu_order() {
        return menu_order;
    }

    public void setMenu_order(Integer menu_order) {
        this.menu_order = menu_order;
    }

    private List<SystemMenu> list=new ArrayList<>();

    public List<SystemMenu> getList() {
        return list;
    }

    public void setList(List<SystemMenu> list) {
        this.list = list;
    }

    private static final long serialVersionUID = 1L;

    public Integer getMenuId() {
        return menuId;
    }

    public void setMenuId(Integer menuId) {
        this.menuId = menuId;
    }

    public String getMenuTitle() {
        return menuTitle;
    }

    public void setMenuTitle(String menuTitle) {
        this.menuTitle = menuTitle == null ? null : menuTitle.trim();
    }

    public String getMenuLink() {
        return menuLink;
    }

    public void setMenuLink(String menuLink) {
        this.menuLink = menuLink == null ? null : menuLink.trim();
    }

    public String getMenuIco() {
        return menuIco;
    }

    public void setMenuIco(String menuIco) {
        this.menuIco = menuIco == null ? null : menuIco.trim();
    }

    public Integer getMenuLevel() {
        return menuLevel;
    }

    public void setMenuLevel(Integer menuLevel) {
        this.menuLevel = menuLevel;
    }

    public Integer getMenuPid() {
        return menuPid;
    }

    public void setMenuPid(Integer menuPid) {
        this.menuPid = menuPid;
    }

    public String getMenuAlt() {
        return menuAlt;
    }

    public void setMenuAlt(String menuAlt) {
        this.menuAlt = menuAlt == null ? null : menuAlt.trim();
    }

    public Integer getMenuCreateuser() {
        return menuCreateuser;
    }

    public void setMenuCreateuser(Integer menuCreateuser) {
        this.menuCreateuser = menuCreateuser;
    }

    public Date getMenuCreatetime() {
        return menuCreatetime;
    }

    public void setMenuCreatetime(Date menuCreatetime) {
        this.menuCreatetime = menuCreatetime;
    }

    public Date getMenuLastmodify() {
        return menuLastmodify;
    }

    public void setMenuLastmodify(Date menuLastmodify) {
        this.menuLastmodify = menuLastmodify;
    }
}