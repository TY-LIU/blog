package com.personal.cv.entity;

import com.alibaba.fastjson.annotation.JSONField;
import com.personal.cv.util.IConstants;

import java.util.Date;

/**
 * 用户表
 * users
 */
public class Users {
    private int user_id;//主键
    private String nickname;//昵称
    private String portrait;//头像路径
    private String autograph;//签名
    @JSONField(format = IConstants.FORMAT_DATE)
    private Date register_time;//注册时间
    private int delete_state;//删除标记
    private int enable;//启动状态

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getPortrait() {
        return portrait;
    }

    public void setPortrait(String portrait) {
        this.portrait = portrait;
    }

    public String getAutograph() {
        return autograph;
    }

    public void setAutograph(String autograph) {
        this.autograph = autograph;
    }

    public Date getRegister_time() {
        return register_time;
    }

    public void setRegister_time(Date register_time) {
        this.register_time = register_time;
    }

    public int getDelete_state() {
        return delete_state;
    }

    public void setDelete_state(int delete_state) {
        this.delete_state = delete_state;
    }

    public int getEnable() {
        return enable;
    }

    public void setEnable(int enable) {
        this.enable = enable;
    }
}
