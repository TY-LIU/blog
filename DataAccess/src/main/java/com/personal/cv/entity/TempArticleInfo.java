package com.personal.cv.entity;

import com.alibaba.fastjson.annotation.JSONField;
import com.personal.cv.util.IConstants;

import java.util.Date;

/**
 * 文章信息
 */
public class TempArticleInfo {
    private int temp_id;//临时ID
    private int article_id;//临时文章id
    private int count;//判断是否存在标识
    private String title;//文章标题
    private String content;//文章内容
    private String describe;//文章描述
    private String title_img;//标图图片路径
    private int column_id;//栏目外键
    private ColumnInfo columnInfo;
    private String label;//标签
    private int clicks;//点击量
    private int commentNum;
    @JSONField(format = IConstants.FORMAT_DATE)
    private Date put_time;//更新时间
    @JSONField(format = IConstants.FORMAT_DATE)
    private Date update_time;//最后更新时间
    private int put_state;//发布状态
    private int delete_state;

    public int getTemp_id() {
        return temp_id;
    }

    public void setTemp_id(int temp_id) {
        this.temp_id = temp_id;
    }

    public int getArticle_id() {
        return article_id;
    }

    public void setArticle_id(int article_id) {
        this.article_id = article_id;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getDescribe() {
        return describe;
    }

    public void setDescribe(String describe) {
        this.describe = describe;
    }

    public String getTitle_img() {
        return title_img;
    }

    public void setTitle_img(String title_img) {
        this.title_img = title_img;
    }

    public int getColumn_id() {
        return column_id;
    }

    public void setColumn_id(int column_id) {
        this.column_id = column_id;
    }

    public ColumnInfo getColumnInfo() {
        return columnInfo;
    }

    public void setColumnInfo(ColumnInfo columnInfo) {
        this.columnInfo = columnInfo;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public int getClicks() {
        return clicks;
    }

    public void setClicks(int clicks) {
        this.clicks = clicks;
    }

    public int getCommentNum() {
        return commentNum;
    }

    public void setCommentNum(int commentNum) {
        this.commentNum = commentNum;
    }

    public Date getPut_time() {
        return put_time;
    }

    public void setPut_time(Date put_time) {
        this.put_time = put_time;
    }

    public Date getUpdate_time() {
        return update_time;
    }

    public void setUpdate_time(Date update_time) {
        this.update_time = update_time;
    }

    public int getPut_state() {
        return put_state;
    }

    public void setPut_state(int put_state) {
        this.put_state = put_state;
    }

    public int getDelete_state() {
        return delete_state;
    }

    public void setDelete_state(int delete_state) {
        this.delete_state = delete_state;
    }
}
