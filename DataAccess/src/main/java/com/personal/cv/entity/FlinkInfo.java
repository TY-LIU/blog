package com.personal.cv.entity;

import com.alibaba.fastjson.annotation.JSONField;
import com.personal.cv.util.IConstants;

import java.util.Date;

/**
 *友情链接
 *
 * */
public class FlinkInfo {
    private int flink_id;
    private String flink_name;
    private String flink_icon;
    private String flink_url;
    private String describe;
    @JSONField(format = IConstants.FORMAT_DATE)
    private Date put_time;
    private int delete_state;

    public int getFlink_id() {
        return flink_id;
    }

    public void setFlink_id(int flink_id) {
        this.flink_id = flink_id;
    }

    public String getFlink_name() {
        return flink_name;
    }

    public void setFlink_name(String flink_name) {
        this.flink_name = flink_name;
    }

    public String getFlink_icon() {
        return flink_icon;
    }

    public void setFlink_icon(String flink_icon) {
        this.flink_icon = flink_icon;
    }

    public String getFlink_url() {
        return flink_url;
    }

    public void setFlink_url(String flink_url) {
        this.flink_url = flink_url;
    }

    public String getDescribe() {
        return describe;
    }

    public void setDescribe(String describe) {
        this.describe = describe;
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
