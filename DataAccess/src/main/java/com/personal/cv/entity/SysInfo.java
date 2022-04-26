package com.personal.cv.entity;

/**
 * 系统信息
 */
public class SysInfo {
    private int sys_id;
    private int admin_num;//管理人数
    private String program_vs;//程序版本
    private String program_code;//程序编码
    private String server_info;//服务器信息
    private String java_version;//java版本
    private String java_om;//java运行方式
    private String dbInfo;//数据库信息
    private String oss_state;//OSS状态
    private String copyright;//版权
    private String accessKeyId;//ossKey
    private String accessKeySecret;//ossKeySercret
    private String imgBucketName;//oss 图片空间名
    private String endpoint;//oss路径名字
    private String imgSuffix;//图片缩略图后缀
    private String imgSuffixBig;//图片缩略图后缀(大图)
    private String imgSuffixPc;//PC查看的图片格式
    private String imgDomain;//图片服务域名

    public int getSys_id() {
        return sys_id;
    }

    public void setSys_id(int sys_id) {
        this.sys_id = sys_id;
    }

    public int getAdmin_num() {
        return admin_num;
    }

    public void setAdmin_num(int admin_num) {
        this.admin_num = admin_num;
    }

    public String getProgram_vs() {
        return program_vs;
    }

    public void setProgram_vs(String program_vs) {
        this.program_vs = program_vs;
    }

    public String getProgram_code() {
        return program_code;
    }

    public void setProgram_code(String program_code) {
        this.program_code = program_code;
    }

    public String getServer_info() {
        return server_info;
    }

    public void setServer_info(String server_info) {
        this.server_info = server_info;
    }

    public String getJava_version() {
        return java_version;
    }

    public void setJava_version(String java_version) {
        this.java_version = java_version;
    }

    public String getJava_om() {
        return java_om;
    }

    public void setJava_om(String java_om) {
        this.java_om = java_om;
    }

    public String getDbInfo() {
        return dbInfo;
    }

    public void setDbInfo(String dbInfo) {
        this.dbInfo = dbInfo;
    }

    public String getOss_state() {
        return oss_state;
    }

    public void setOss_state(String oss_state) {
        this.oss_state = oss_state;
    }

    public String getCopyright() {
        return copyright;
    }

    public void setCopyright(String copyright) {
        this.copyright = copyright;
    }

    public String getAccessKeyId() {
        return accessKeyId;
    }

    public void setAccessKeyId(String accessKeyId) {
        this.accessKeyId = accessKeyId;
    }

    public String getAccessKeySecret() {
        return accessKeySecret;
    }

    public void setAccessKeySecret(String accessKeySecret) {
        this.accessKeySecret = accessKeySecret;
    }

    public String getImgBucketName() {
        return imgBucketName;
    }

    public void setImgBucketName(String imgBucketName) {
        this.imgBucketName = imgBucketName;
    }

    public String getEndpoint() {
        return endpoint;
    }

    public void setEndpoint(String endpoint) {
        this.endpoint = endpoint;
    }

    public String getImgSuffix() {
        return imgSuffix;
    }

    public void setImgSuffix(String imgSuffix) {
        this.imgSuffix = imgSuffix;
    }

    public String getImgSuffixBig() {
        return imgSuffixBig;
    }

    public void setImgSuffixBig(String imgSuffixBig) {
        this.imgSuffixBig = imgSuffixBig;
    }

    public String getImgSuffixPc() {
        return imgSuffixPc;
    }

    public void setImgSuffixPc(String imgSuffixPc) {
        this.imgSuffixPc = imgSuffixPc;
    }

    public String getImgDomain() {
        return imgDomain;
    }

    public void setImgDomain(String imgDomain) {
        this.imgDomain = imgDomain;
    }
}
