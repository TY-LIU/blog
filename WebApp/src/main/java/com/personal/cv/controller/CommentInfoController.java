package com.personal.cv.controller;

import com.lang.PageModel;
import com.personal.cv.entity.CommentInfo;
import com.personal.cv.service.impl.CommentInfoServiceImpl;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;


@Controller
@RequestMapping("/commentInfo")
public class CommentInfoController {

    private static Logger logger = Logger.getLogger(CommentInfoController.class);

    @Resource
    private CommentInfoServiceImpl commentInfoService;


    /**
     * [批量]删除(逻辑删)
     */
    @RequestMapping(value = "/deleteComment")
    @ResponseBody
    public String deleteComment(String ids) {
        logger.info("删除评论");
        int num = commentInfoService.delete(ids);
        return result(num);
    }

    /**
     * 查看评论详情
     *
     */
    @RequestMapping(value = "/seeComment")
    @ResponseBody
    public CommentInfo seeComment(int comment_id) {
        logger.info("查看评论详情");
        CommentInfo commentInfo = commentInfoService.get(comment_id);
        return commentInfo;
    }

    /**
     * 查看评论回复
     *
     */
    @RequestMapping(value = "/seeReply")
    @ResponseBody
    public List seeReply(int comment_id) {
        logger.info("查看评论回复");
        try {
            List<HashMap<String,Object>> list =commentInfoService.seeReply(comment_id);
            return list;
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }

    }

    /**
     * 分页查询
     *
     * @param pageSize 每次查询条数
     * @param pageNo   当前页
     * @param pattern  模糊查询
     */
    @RequestMapping(value = "/selectComment")
    @ResponseBody
    public PageModel<CommentInfo> selectArticle(String pattern, int pageNo, int pageSize, String Sort) {
        logger.info("分页查询评论");
        PageModel<CommentInfo> pageModel;
        try {
            pageModel = commentInfoService.selectByPage(pattern, pageNo, pageSize, Sort);
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
