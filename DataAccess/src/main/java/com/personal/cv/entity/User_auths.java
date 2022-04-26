package com.personal.cv.entity;

/**
 * 用户授权表
 */
public class User_auths {
    private int auths_id;//主键
    private int user_id;//用户表外键
    private Users users;
    private String qq_id;
    private String qq_number;
    private String access_token;
    private String identifier;//唯一标识符
    private String credential;//密码凭证
    private int role;

    public int getAuths_id() {
        return auths_id;
    }

    public void setAuths_id(int auths_id) {
        this.auths_id = auths_id;
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

    public String getQq_id() {
        return qq_id;
    }

    public void setQq_id(String qq_id) {
        this.qq_id = qq_id;
    }

    public String getQq_number() {
        return qq_number;
    }

    public void setQq_number(String qq_number) {
        this.qq_number = qq_number;
    }

    public String getAccess_token() {
        return access_token;
    }

    public void setAccess_token(String access_token) {
        this.access_token = access_token;
    }

    public String getIdentifier() {
        return identifier;
    }

    public void setIdentifier(String identifier) {
        this.identifier = identifier;
    }

    public String getCredential() {
        return credential;
    }

    public void setCredential(String credential) {
        this.credential = credential;
    }

    public int getRole() {
        return role;
    }

    public void setRole(int role) {
        this.role = role;
    }
}

