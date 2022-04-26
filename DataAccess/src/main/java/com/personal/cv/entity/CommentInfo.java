package com.personal.cv.entity;

import com.alibaba.fastjson.annotation.JSONField;
import com.personal.cv.util.IConstants;

import java.util.Date;

/**
 * 评论表
 * */
public class CommentInfo {
    private int comment_id;
    private int user_id;//评论用户外键
    private Users users;
    private int article_id;//评论的文章外键
    private ArticleInfo articleInfo;
    private String comment_content;//评论内容
    private int reply_num;//评论回复量
    @JSONField(format = IConstants.FORMAT_DATE)
    private Date comment_time;
    private String comment_ip;
    private String comment_adds;
    private String comment_os;
    private String comment_browser;
    private String comment_url;
    private String urlTitle;
    private int delete_state;

    public int getComment_id() {
        return comment_id;
    }

    public void setComment_id(int comment_id) {
        this.comment_id = comment_id;
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

    public int getArticle_id() {
        return article_id;
    }

    public void setArticle_id(int article_id) {
        this.article_id = article_id;
    }

    public ArticleInfo getArticleInfo() {
        return articleInfo;
    }

    public void setArticleInfo(ArticleInfo articleInfo) {
        this.articleInfo = articleInfo;
    }

    public String getComment_content() {
        return comment_content;
    }

    public void setComment_content(String comment_content) {
        this.comment_content = comment_content;
    }

    public int getReply_num() {
        return reply_num;
    }

    public void setReply_num(int reply_num) {
        this.reply_num = reply_num;
    }

    public Date getComment_time() {
        return comment_time;
    }

    public void setComment_time(Date comment_time) {
        this.comment_time = comment_time;
    }

    public String getComment_ip() {
        return comment_ip;
    }

    public void setComment_ip(String comment_ip) {
        this.comment_ip = comment_ip;
    }

    public String getComment_adds() {
        return comment_adds;
    }

    public void setComment_adds(String comment_adds) {
        this.comment_adds = comment_adds;
    }

    public String getComment_os() {
        return comment_os;
    }

    public void setComment_os(String comment_os) {
        this.comment_os = comment_os;
    }

    public String getComment_browser() {
        return comment_browser;
    }

    public void setComment_browser(String comment_browser) {
        this.comment_browser = comment_browser;
    }

    public String getComment_url() {
        return comment_url;
    }

    public void setComment_url(String comment_url) {
        this.comment_url = comment_url;
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
