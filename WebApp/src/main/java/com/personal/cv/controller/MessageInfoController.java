package com.personal.cv.controller;

import com.lang.PageModel;
import com.personal.cv.entity.MessageInfo;
import com.personal.cv.entity.Page;
import com.personal.cv.entity.Users;
import com.personal.cv.service.impl.LikeService;
import com.personal.cv.service.impl.MessageInfoServiceImpl;
import com.personal.cv.service.impl.UserServiceImpl;
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
@RequestMapping("/messageInfo")
public class MessageInfoController {

    private static Logger logger = Logger.getLogger(MessageInfoController.class);

    @Resource
    private MessageInfoServiceImpl messageInfoService;
    @Resource
    private LikeService likeService;
    @Resource
    private UserServiceImpl userService;

    /**
     * 添加留言
     */
    @RequestMapping(value = "/addMessage")
    @ResponseBody
    public MessageInfo addMessage(HttpServletRequest request, MessageInfo messageInfo, int user_id, String content,String url,String title) {
        logger.info("添加留言");
        QueryHelper.userAgent = UserAgent.parseUserAgentString(request.getHeader("User-Agent"));
        messageInfo.setMessage_content(content);
        messageInfo.setUser_id(user_id);
        messageInfo.setMessage_time(new Date());
        messageInfo.setMessage_ip(QueryHelper.ip(request));
        messageInfo.setMessage_browser(QueryHelper.browser(request));
        messageInfo.setMessage_os(QueryHelper.os(request));
        messageInfo.setMessage_adds(QueryHelper.area());
        messageInfo.setMessage_url(url);
        messageInfo.setUrlTitle(title);
        try {
            messageInfoService.addMessage(messageInfo);
            messageInfo = messageInfoService.getMessage(messageInfo.getMessage_id());
        } catch (Exception e) {
            e.fillInStackTrace();
            return null;
        }
        return messageInfo;
    }


    /**
     * 后台[批量]删除(逻辑删)
     */
    @RequestMapping(value = "/deleteMessage")
    @ResponseBody
    public String deleteMessage(String ids) {
        logger.info("删除留言");
        int num = messageInfoService.delete(ids);
        return result(num);
    }

    /**
     * 前台删除(逻辑删)
     */
    @RequestMapping(value = "/delMessage")
    @ResponseBody
    public String delMessage(HttpServletRequest request, int userId, int messageId) {
        logger.info("前台删除留言");
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
            num = messageInfoService.delMessage(userId, messageId);
        }
        return result(num);
    }

    /**
     * 查看留言详情
     */
    @RequestMapping(value = "/seeMessage")
    @ResponseBody
    public List seeMessage(int message_id) {
        logger.info("查看留言详情");
        List<HashMap<String, Object>> list = messageInfoService.seeMessage(message_id);
        return list;
    }

    /**
     * 查看留言回复
     */
    @RequestMapping(value = "/seeReply")
    @ResponseBody
    public List seeReply(int message_id) {
        logger.info("查看留言回复");
        try {
            List<HashMap<String, Object>> list = messageInfoService.seeReply(message_id);
            return list;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }

    }

    /**
     * 首页展示数据
     *
     * @param pageSize 每次查询条数
     * @param pageNo   当前页
     */
    @RequestMapping(value = "/selectByIndex")
    @ResponseBody
    public Page selectByIndex(HttpServletRequest request, int pageNo, int pageSize, String sort, String authorState) {
        PageModel pageModel;
        authorState = authorState == "" || authorState == null ? "false" : authorState;
        try {
            if (sort.equals("time")) {
                sort = "message_time";
            } else if (sort.equals("time-desc")) {
                sort = "message_time desc";
            } else if (sort.equals("enjoy")) {
                sort = "enjoy desc";
            } else if (sort.equals("author") && authorState.equals("true")) {
                sort = "enjoy desc";
                authorState = "true";
            } else {
                sort = "";
            }
            pageModel = messageInfoService.selectByIndex(pageNo, pageSize, sort, authorState);
        } catch (Exception e) {
            pageModel = null;
            System.out.println(e.getMessage());
        }
        Page page = new Page(pageModel, likeService.messageIds(QueryHelper.ip(request)));
        return page;
    }

    /**
     * 分页查询用户的留言
     *
     * @param pageSize 每次查询条数
     * @param pageNo   当前页
     * @param userId   用户ID
     */
    @RequestMapping(value = "/selectByUser")
    @ResponseBody
    public Page selectByUser(int pageNo, int pageSize,int userId) {
        logger.info("分页查询用户留言");
        PageModel pageModel;
        try {
            pageModel = messageInfoService.selectByUser(pageNo, pageSize,userId);
        } catch (Exception e) {
            pageModel = null;
            System.out.println(e.getMessage());
        }
        Page page = new Page(pageModel,userService.getByUser(userId));
        return page;
    }

    /**
     * 分页查询
     *
     * @param pageSize 每次查询条数
     * @param pageNo   当前页
     * @param pattern  模糊查询
     */
    @RequestMapping(value = "/selectMessage")
    @ResponseBody
    public PageModel selectMessage(String pattern, int pageNo, int pageSize) {
        logger.info("分页查询评论");
        PageModel pageModel;
        try {
            pageModel = messageInfoService.selectByPage(pattern, pageNo, pageSize);
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


}
