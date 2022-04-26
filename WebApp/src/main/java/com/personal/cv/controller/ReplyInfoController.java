package com.personal.cv.controller;

import com.personal.cv.entity.ReplyInfo;
import com.personal.cv.service.impl.ReplyInfoServiceImpl;
import com.personal.cv.util.QueryHelper;
import eu.bitwalker.useragentutils.UserAgent;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.HashMap;
import java.util.List;


@Controller
@RequestMapping("/replyInfo")
public class ReplyInfoController {

    private static Logger logger = Logger.getLogger(ReplyInfoController.class);

    @Resource
    private ReplyInfoServiceImpl replyInfoService;

    /**
     * 添加回复
     */
    @RequestMapping(value = "/addReply")
    @ResponseBody
    public String addReply(HttpServletRequest request, ReplyInfo replyInfo, int comment_id, int to_uid, int user_id, String reply_content) {
        logger.info("添加回复");
        QueryHelper.userAgent= UserAgent.parseUserAgentString(request.getHeader("User-Agent"));
        replyInfo.setComment_id(comment_id);
        replyInfo.setReply_content(reply_content);
        replyInfo.setUser_id(user_id);
        replyInfo.setTo_uid(to_uid);
        replyInfo.setReply_time(new Date());
        replyInfo.setReply_ip(QueryHelper.ip(request));
        replyInfo.setReply_browser(QueryHelper.browser(request));
        replyInfo.setReply_os(QueryHelper.os(request));
        replyInfo.setReply_adds(QueryHelper.area());
        int num = replyInfoService.save(replyInfo);
        return result(num);
    }

    /**
     * [批量]删除(逻辑删)
     */
    @RequestMapping(value = "/deleteReply")
    @ResponseBody
    public String deleteReply(String ids) {
        logger.info("删除评论");
        int num = replyInfoService.delete(ids);
        return result(num);
    }

    /**
     * 查看回复详情
     *
     */
    @RequestMapping(value = "/seeReply")
    @ResponseBody
    public List seeReply(int reply_id) {
        logger.info("查看回复详情");
        try {
            List<HashMap<String,Object>> list =replyInfoService.detailReply(reply_id);
            return list;
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }

    }

    public String result(int num) {
        if (num > 0)
            return "true";
        else if (num <= 0)
            return "false";
        else
            return "error";
    }


}
