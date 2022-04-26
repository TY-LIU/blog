package com.personal.cv.entity;

import com.alibaba.fastjson.annotation.JSONField;
import com.personal.cv.util.IConstants;

import java.util.Date;

/**
 * 回复表
 * */
public class M_replyInfo {
    private int reply_id;
    private int message_id;//评论外键
    private MessageInfo messageInfo;
    private String reply_content;//回复内容
    private int user_id;//评论用户外键
    private Users users;
    private int to_uid;//目标用户ID
    private Users to_users;
    private int enjoy;
    @JSONField(format = IConstants.FORMAT_DATE)
    private Date reply_time;//回复时间(Date)
    private String s_reply_time;//回复时间(String)
    private String reply_ip;
    private String reply_os;
    private String reply_adds;
    private String reply_browser;
    private int delete_state;

    public int getReply_id() {
        return reply_id;
    }

    public void setReply_id(int reply_id) {
        this.reply_id = reply_id;
    }

    public int getMessage_id() {
        return message_id;
    }

    public void setMessage_id(int message_id) {
        this.message_id = message_id;
    }

    public MessageInfo getMessageInfo() {
        return messageInfo;
    }

    public void setMessageInfo(MessageInfo messageInfo) {
        this.messageInfo = messageInfo;
    }

    public String getReply_content() {
        return reply_content;
    }

    public void setReply_content(String reply_content) {
        this.reply_content = reply_content;
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

    public int getTo_uid() {
        return to_uid;
    }

    public void setTo_uid(int to_uid) {
        this.to_uid = to_uid;
    }

    public Users getTo_users() {
        return to_users;
    }

    public void setTo_users(Users to_users) {
        this.to_users = to_users;
    }

    public int getEnjoy() {
        return enjoy;
    }

    public void setEnjoy(int enjoy) {
        this.enjoy = enjoy;
    }

    public Date getReply_time() {
        return reply_time;
    }

    public void setReply_time(Date reply_time) {
        this.reply_time = reply_time;
    }

    public String getS_reply_time() {
        return s_reply_time;
    }

    public void setS_reply_time(String s_reply_time) {
        this.s_reply_time = s_reply_time;
    }

    public String getReply_ip() {
        return reply_ip;
    }

    public void setReply_ip(String reply_ip) {
        this.reply_ip = reply_ip;
    }

    public String getReply_adds() {
        return reply_adds;
    }

    public void setReply_adds(String reply_adds) {
        this.reply_adds = reply_adds;
    }

    public String getReply_os() {
        return reply_os;
    }

    public void setReply_os(String reply_os) {
        this.reply_os = reply_os;
    }

    public String getReply_browser() {
        return reply_browser;
    }

    public void setReply_browser(String reply_browser) {
        this.reply_browser = reply_browser;
    }

    public int getDelete_state() {
        return delete_state;
    }

    public void setDelete_state(int delete_state) {
        this.delete_state = delete_state;
    }
}
