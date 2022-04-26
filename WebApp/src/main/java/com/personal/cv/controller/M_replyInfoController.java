package com.personal.cv.controller;

import com.lang.PageModel;
import com.personal.cv.entity.M_replyInfo;
import com.personal.cv.entity.Users;
import com.personal.cv.service.impl.M_replyInfoServiceImpl;
import com.personal.cv.util.QueryHelper;
import eu.bitwalker.useragentutils.UserAgent;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.List;


@Controller
@RequestMapping("/m_replyInfo")
public class M_replyInfoController {

    private static Logger logger = Logger.getLogger(ReplyInfoController.class);

    @Resource
    private M_replyInfoServiceImpl m_replyInfoService;

    /**
     * 添加回复
     */
    @RequestMapping(value = "/addReply")
    @ResponseBody
    public M_replyInfo addReply(HttpServletRequest request, M_replyInfo m_replyInfo, int message_id, int to_uid, int user_id, String reply_content) {
        logger.info("添加回复");
        QueryHelper.userAgent= UserAgent.parseUserAgentString(request.getHeader("User-Agent"));
        m_replyInfo.setMessage_id(message_id);
        m_replyInfo.setReply_content(reply_content);
        m_replyInfo.setUser_id(user_id);
        m_replyInfo.setTo_uid(to_uid);
        m_replyInfo.setReply_time(new Date());
        m_replyInfo.setReply_ip(QueryHelper.ip(request));
        m_replyInfo.setReply_browser(QueryHelper.browser(request));
        m_replyInfo.setReply_os(QueryHelper.os(request));
        m_replyInfo.setReply_adds(QueryHelper.area());
        try {
            m_replyInfoService.save(m_replyInfo);
            m_replyInfo = m_replyInfoService.getReply(m_replyInfo.getReply_id());
        } catch (Exception e) {
            e.fillInStackTrace();
            return null;
        }
        return m_replyInfo;
    }

    /**
     * [批量]删除(逻辑删)
     */
    @RequestMapping(value = "/deleteReply")
    @ResponseBody
    public String deleteReply(String ids) {
        logger.info("删除评论");
        int num = m_replyInfoService.delete(ids);
        return result(num);
    }

    /**
     * 前台删除(逻辑删)
     */
    @RequestMapping(value = "/delReply")
    @ResponseBody
    public String delReply(HttpServletRequest request, int userId, int replyId) {
        logger.info("前台删除留言回复");
        HttpSession session = request.getSession();
        int num = 0;
        Users users;
        try {
            users = (Users) session.getAttribute("users");
        } catch (Exception e) {
            e.fillInStackTrace();
            return "loginOut";
        }
        if(users.getUser_id()==userId){
            num = m_replyInfoService.delReply(userId, replyId);
        }
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
            List<HashMap<String,Object>> list =m_replyInfoService.detailReply(reply_id);
            return list;
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }

    }

    /**
     * 分页查询(前端)
     *
     * @param pageSize 每次查询条数
     * @param pageNo   当前页
     */
    @RequestMapping(value = "/selectReply")
    @ResponseBody
    public PageModel selectReply(int pageNo, int pageSize,int message_id) {
        logger.info("分页查询评论");
        PageModel pageModel;
        try {
            pageModel = m_replyInfoService.selectReply(pageNo, pageSize,message_id);
        } catch (Exception e) {
            pageModel = null;
            System.out.println(e.getMessage());
        }
        return pageModel;
    }

    public String result(int num) {
        if (num > 0)
            return "true";
        else if (num <= 0)
            return "false";
        else
            return "error";
    }

    /**
     * 分页查询用户的被别人的回复
     *
     * @param pageSize 每次查询条数
     * @param pageNo   当前页
     * @param userId   用户ID
     */
    @RequestMapping(value = "/selectByUser")
    @ResponseBody
    public PageModel selectByUser(int pageNo, int pageSize, int userId) {
        logger.info("分页查询用户被回复数据");
        PageModel pageModel;
        try {
            pageModel = m_replyInfoService.selectByUser(pageNo, pageSize,userId);
        } catch (Exception e) {
            pageModel = null;
            System.out.println(e.getMessage());
        }
        return pageModel;
    }


}
