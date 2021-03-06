package com.personal.cv.controller;

import com.alibaba.fastjson.support.spring.FastJsonJsonView;
import com.personal.cv.entity.EnjoyInfo;
import com.personal.cv.entity.MessageInfo;
import com.personal.cv.entity.Users;
import com.personal.cv.service.impl.EnjoyInfoServiceImpl;
import com.personal.cv.service.impl.LikeService;
import com.personal.cv.service.impl.MessageInfoServiceImpl;
import com.personal.cv.util.QueryHelper;
import com.personal.cv.util.RedisKeyUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Timer;
import java.util.TimerTask;

@Controller
@RequestMapping("/enjoyInfo")
public class EnjoyController {
    public int num = 5;
    Timer t = new Timer();
    @Resource
    LikeService likeService;
    @Resource
    MessageInfoServiceImpl messageInfoService;
    @Resource
    EnjoyInfoServiceImpl enjoyInfoService;

    @RequestMapping(value = "like")
    @ResponseBody
    public String like(HttpServletRequest request, MessageInfo messageInfo, EnjoyInfo enjoyInfo, int entityId, String EntityType, String zanType) {
        int entityType;
        long likeCount = 0;
        String ip = QueryHelper.ip(request);
        Users users;
        HttpSession session = request.getSession();
        try {
            users = (Users) session.getAttribute("users");
        } catch (Exception e) {
            e.fillInStackTrace();
            users = null;
        }
        if (EntityType.equals("message")) {
            entityType = 1;
        } else if (EntityType.equals("comment")) {
            entityType = 2;
        } else {
            return "error";
        }
        String likeKey = RedisKeyUtil.getLikeKey(entityId, entityType);
        enjoyInfo.setEnjoyKey(likeKey);
        enjoyInfo.setIp(ip);
        messageInfo.setMessage_id(entityId);
        //????????????????????????????????????
        boolean flag = likeService.exist(ip, entityType, entityId);
        if (flag) {//???????????????
            if (zanType.equals("zan")) {
                return "exist";
            } else if (zanType.equals("cancel") && users != null) {
                likeCount = likeService.disLike(ip, entityType, entityId);
                messageInfo.setEnjoy(likeCount);
                num = 5;
                timer(messageInfo, enjoyInfo, zanType);
            } else if (zanType.equals("cancel") && users == null) {
                return "loginOut";
            } else {
                return "error";
            }
        } else {//??????????????????,???????????????
            int count = enjoyInfoService.selectKey(enjoyInfo);
            if (count > 0) {//?????????????????????????????????
                if (zanType.equals("zan")) {
                    likeService.like(ip, entityType, entityId);
                    return "exist";
                } else if (zanType.equals("cancel") && users != null) {
                    //?????????????????????Key
                    messageInfo.setEnjoy(likeCount);
                    num = 5;
                    timer(messageInfo, enjoyInfo, zanType);
                } else if (zanType.equals("cancel") && users == null) {
                    return "loginOut";
                } else {
                    return "error";
                }
            } else {//??????????????????????????????????????????????????????
                if (zanType.equals("zan")) {
                    likeCount = likeService.like(ip, entityType, entityId);
                    //????????????????????????????????????num???????????????????????????????????????????????????????????????
                    messageInfo.setEnjoy(likeCount);
                    num = 5;
                    timer(messageInfo, enjoyInfo, zanType);
                } else if (zanType.equals("cancel") && users != null) {
                    return "error";
                } else if (zanType.equals("cancel") && users == null) {
                    return "loginOut";
                } else {
                    return "error";
                }
            }
        }
        request.getSession().setAttribute("messageIds",likeService.messageIds(ip));
        return String.valueOf(likeCount);
    }

    //?????????????????????
    public void timer(MessageInfo messageInfo, EnjoyInfo enjoyInfo, String zanType) {
        t.cancel();
        t = null;
        t = new Timer();
        t.schedule(new TimerTask() {
            @Override
            public void run() {
                if (num == 0) {
                    if (zanType.equals("zan")) {
                        messageInfoService.updateEnjoy(messageInfo);
                        enjoyInfoService.save(enjoyInfo);
                    } else if (zanType.equals("cancel")) {
                        messageInfoService.updateEnjoy(messageInfo);
                        enjoyInfoService.delete(enjoyInfo);
                    }
                    t.cancel();
                }
                num--;
            }
        }, 0, 1000);
    }

}
