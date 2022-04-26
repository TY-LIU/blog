package com.personal.cv.util;

import java.util.Random;

/**
 * 创建验证码
 *
 * */
public class CreateCode {
    public static String code="";
    public static int num=15;

    public static String CreateCode() {
        StringBuilder sb=new StringBuilder();
        Random random = new Random();
        //生成6个在[0,9)范围内的整数
        int[] arr = random.ints(6, 0, 9).toArray();
        for (int i = 0; i < arr.length; i++) {
            sb.append(arr[i]);
        }
        code=sb.toString();
        return code;
    }

    public static String CreateLetter(String name) {
        StringBuilder sb=new StringBuilder();
        Random random = new Random();
        //生成6个在[0,9)范围内的整数
        int[] arr = random.ints(4, 0, 9).toArray();
        for (int i = 0; i < arr.length; i++) {
            sb.append(arr[i]);
        }
        name+=sb.toString();
        return name;
    }

    public static void main(String[] args) {

        /*System.out.println("发送验证码："+CreateCode());*/
        //System.out.println("验证码："+CreateCode.code);
        System.out.println(CreateCode.CreateLetter("友情出演"));
    }
}
