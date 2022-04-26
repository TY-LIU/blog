package com.personal.cv.controller;

import com.lang.PageModel;
import com.personal.cv.entity.Notice;
import com.personal.cv.service.impl.NoticeServiceImpl;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.Date;

@Controller
@RequestMapping("/notice")
public class NoticeController {
    private static Logger logger = Logger.getLogger(MessageInfoController.class);

    @Resource
    private NoticeServiceImpl noticeService;

    @RequestMapping(value = "/save")
    @ResponseBody
    public String saveNotice(Notice notice, String notice_content) {
        Date date = new Date();
        notice.setNotice_content(notice_content);
        notice.setPut_time(date);
        int num = noticeService.save(notice);
        return result(num);
    }

    @RequestMapping(value = "/deleteNotice")
    @ResponseBody
    public String deleteNotice(String ids) {
        int num = noticeService.delete(ids);
          return result(num);
    }

    @RequestMapping(value = "/updateNotice")
    @ResponseBody
    public String updateNotice(Notice notice, int notice_id, String notice_content) {
        notice.setNotice_id(notice_id);
        notice.setNotice_content(notice_content);
        int num = noticeService.update(notice);
        return result(num);
    }

    @RequestMapping(value = "/selectNotice")
    @ResponseBody
    public PageModel selectMessage(String pattern, int pageNo, int pageSize, String Sort) {
        logger.info("分页查询评论");
        PageModel pageModel;
        try {
            pageModel = noticeService.selectByPage(pattern, pageNo, pageSize, Sort);
        } catch (Exception e) {
            pageModel = null;
            System.out.println(e.getMessage());
        }
        return pageModel;
    }

    @RequestMapping(value = "/detailNotice")
    @ResponseBody
    public Notice detailNotice(int notice_id) {
        Notice notice = noticeService.get(notice_id);
        return notice;
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
