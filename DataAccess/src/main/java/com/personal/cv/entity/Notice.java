package com.personal.cv.entity;

import com.alibaba.fastjson.annotation.JSONField;
import com.personal.cv.util.IConstants;

import java.util.Date;

/**
 * 公告表
 * */
public class Notice {
    private int notice_id;
    private String notice_content;
    private String notice_title;
    @JSONField(format = IConstants.FORMAT_DATE)
    private Date put_time;
    private int delete_state;

    public int getNotice_id() {
        return notice_id;
    }

    public void setNotice_id(int notice_id) {
        this.notice_id = notice_id;
    }

    public String getNotice_content() {
        return notice_content;
    }

    public void setNotice_content(String notice_content) {
        this.notice_content = notice_content;
    }

    public String getNotice_title() {
        return notice_title;
    }

    public void setNotice_title(String notice_title) {
        this.notice_title = notice_title;
    }

    public Date getPut_time() {
        return put_time;
    }

    public void setPut_time(Date put_time) {
        this.put_time = put_time;
    }

    public int getDelete_state() {
        return delete_state;
    }

    public void setDelete_state(int delete_state) {
        this.delete_state = delete_state;
    }
}
