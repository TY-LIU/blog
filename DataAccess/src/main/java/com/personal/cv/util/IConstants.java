package com.personal.cv.util;

/**
 * Created by Administrator on 2017/1/9.
 */
public interface IConstants {
    long MAX_ERROR_TIME=86400000;//86400000=1000*60*60*24
    long MAX_EFFECTIVE_TIME=600000;//600000=1000*60*10
    long DEFAULT_MAX_EFFECTIVE_TIME=1800000;//1800000=1000*60*30
    String FORMAT_DATE="yyyy-MM-dd HH:mm:ss";
    String REGEXP_NAME ="^[A-Za-z_]\\w*$";
    String REGEXP_ALIPAYPWD ="^\\d{6}$";
    String REGEXP_FULL_NAME ="^[A-Za-z_]\\w{3,15}$";
    String REGEXP_EMAIL="^(\\w)+(\\.\\w+)*@(\\w)+((\\.\\w+)+)$";
    String REGEXP_PHONE="^1((3[0-9])|(4[57])|(5[012356789])|(7[01678])|(8[0-9]))\\d{8}$";
}
