package com.personal.cv.entity;

import com.alibaba.fastjson.annotation.JSONField;
import com.personal.cv.util.IConstants;

import java.util.Date;

/**
 * 登录信息表
 * */
public class LoginInfo {
    private int login_id;//主键
    private int user_id;//用户外键
    private Users users;
    private String login_ip;
    @JSONField(format = IConstants.FORMAT_DATE)
    private Date login_time;
    private String login_area;//登录地区
    private String login_browser;//登录浏览器
    private String login_os;//登录操作系统
    private int state;
    private int delete_state;

    public int getLogin_id() {
        return login_id;
    }

    public void setLogin_id(int login_id) {
        this.login_id = login_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public Users getUsers() {
        return users;
    }

    public void setUsers(Users users) {
        this.users = users;
    }

    public String getLogin_ip() {
        return login_ip;
    }

    public void setLogin_ip(String login_ip) {
        this.login_ip = login_ip;
    }

    public Date getLogin_time() {
        return login_time;
    }

    public void setLogin_time(Date login_time) {
        this.login_time = login_time;
    }

    public String getLogin_area() {
        return login_area;
    }

    public void setLogin_area(String login_area) {
        this.login_area = login_area;
    }

    public String getLogin_browser() {
        return login_browser;
    }

    public void setLogin_browser(String login_browser) {
        this.login_browser = login_browser;
    }

    public String getLogin_os() {
        return login_os;
    }

    public void setLogin_os(String login_os) {
        this.login_os = login_os;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

    public int getDelete_state() {
        return delete_state;
    }

    public void setDelete_state(int delete_state) {
        this.delete_state = delete_state;
    }
}
