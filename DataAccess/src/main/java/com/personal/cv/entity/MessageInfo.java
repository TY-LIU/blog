package com.personal.cv.entity;

import com.alibaba.fastjson.annotation.JSONField;
import com.personal.cv.util.IConstants;

import java.util.Date;

/**
 * 留言表
 */
public class MessageInfo {
    private int message_id;
    private int user_id;
    private Users users;
    private String message_content;//留言内容
    private long enjoy;
    private int reply_num;
    @JSONField(format = IConstants.FORMAT_DATE)
    private Date message_time;
    private String s_message_time;//留言时间(String)
    private String message_ip;
    private String message_adds;//ip归属地
    private String message_os;//操作系统
    private String message_browser;//浏览器信息
    private String message_url;
    private String urlTitle;
    private int delete_state;//删除标记

    public int getMessage_id() {
        return message_id;
    }

    public void setMessage_id(int message_id) {
        this.message_id = message_id;
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

    public String getMessage_content() {
        return message_content;
    }

    public void setMessage_content(String message_content) {
        this.message_content = message_content;
    }

    public long getEnjoy() {
        return enjoy;
    }

    public void setEnjoy(long enjoy) {
        this.enjoy = enjoy;
    }

    public int getReply_num() {
        return reply_num;
    }

    public void setReply_num(int reply_num) {
        this.reply_num = reply_num;
    }

    public Date getMessage_time() {
        return message_time;
    }

    public void setMessage_time(Date message_time) {
        this.message_time = message_time;
    }

    public String getS_message_time() {
        return s_message_time;
    }

    public void setS_message_time(String s_message_time) {
        this.s_message_time = s_message_time;
    }

    public String getMessage_ip() {
        return message_ip;
    }

    public void setMessage_ip(String message_ip) {
        this.message_ip = message_ip;
    }

    public String getMessage_adds() {
        return message_adds;
    }

    public void setMessage_adds(String message_adds) {
        this.message_adds = message_adds;
    }

    public String getMessage_os() {
        return message_os;
    }

    public void setMessage_os(String message_os) {
        this.message_os = message_os;
    }

    public String getMessage_browser() {
        return message_browser;
    }

    public void setMessage_browser(String message_browser) {
        this.message_browser = message_browser;
    }

    public String getMessage_url() {
        return message_url;
    }

    public void setMessage_url(String message_url) {
        this.message_url = message_url;
    }

    public String getUrlTitle() {
        return urlTitle;
    }

    public void setUrlTitle(String urlTitle) {
        this.urlTitle = urlTitle;
    }

    public int getDelete_state() {
        return delete_state;
    }

    public void setDelete_state(int delete_state) {
        this.delete_state = delete_state;
    }
}
