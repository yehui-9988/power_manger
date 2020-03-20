package com.neusoft.until;

import javax.enterprise.inject.Default;

public class ResultBean {

    private Integer code;
    private String message;
    private Object object;

    public ResultBean()
    {

    }

    public ResultBean(Integer c)
    {
        this.code=c;
        switch (code)
        {
            case 10000:
                message="操作成功";
                break;
            case  20000:
                message="操作失败";
                break;
            case  30000:
                message="操作异常";
                break;
        }
    }
    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Object getObject() {
        return object;
    }

    public void setObject(Object object) {
        this.object = object;
    }
}
