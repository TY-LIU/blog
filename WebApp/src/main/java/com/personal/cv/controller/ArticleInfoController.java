package com.personal.cv.controller;

import com.lang.PageModel;
import com.personal.cv.entity.ArticleInfo;
import com.personal.cv.entity.ColumnInfo;
import com.personal.cv.entity.TempArticleInfo;
import com.personal.cv.service.impl.ArticleInfoServiceImpl;
import com.personal.cv.service.impl.ColumnInfoServiceImpl;
import com.personal.cv.service.impl.TempArticleInfoServiceImpl;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;


@Controller
@RequestMapping("/articleInfo")
public class ArticleInfoController {

    private static Logger logger = Logger.getLogger(ArticleInfoController.class);

    @Resource
    private ArticleInfoServiceImpl articleInfoService;
    @Resource
    private TempArticleInfoServiceImpl tempArticleInfoService;
    @Resource
    private ColumnInfoServiceImpl columnInfoService;


    /**
     * 添加文章
     * addArticle
     * */
    @RequestMapping(value = "/saveArticle")
    @ResponseBody
    public String saveArticle(ArticleInfo articleInfo, String title, String content, String describe, String title_img, String column_id, String label) {
        logger.info("添加文章");
        Date time = new Date();
        articleInfo.setTitle(title);
        articleInfo.setContent(content);
        articleInfo.setDescribe(describe);
        articleInfo.setTitle_img(title_img);
        articleInfo.setColumn_id(Integer.valueOf(column_id));
        articleInfo.setLabel(label);
        articleInfo.setPut_time(time);
        articleInfo.setUpdate_time(time);
        int num = articleInfoService.save(articleInfo);
        return result(num);
    }

    /**
     * [批量]删除(逻辑删)
     *
     * */
    @RequestMapping(value = "/deleteArticle")
    @ResponseBody
    public String deleteArticle(String ids) {
        logger.info("删除文章");
        int num = articleInfoService.delete(ids);
        return result(num);
    }

    /**
     * 跳转界面(添加文章)
     *
     * */
    @RequestMapping(value = "/addArticle")
    public String addArticle(Model model) {
        logger.info("跳转添加文章界面，传入栏目信息");
        try {
            List<ColumnInfo> list = columnInfoService.selectAll();
            model.addAttribute("columnInfo", list);
            return "WEB-INF/page/add-article";
        } catch (Exception e){
            e.printStackTrace();
            return "WEB-INF/page/article";
        }

    }

    /**
     * 分页查询
     *
     * @param pageSize 每次查询条数
     * @param pageNo   当前页
     * @param pattern  模糊查询
     */
    @RequestMapping(value = "/selectArticle")
    @ResponseBody
    public PageModel<ArticleInfo> selectArticle(String pattern, int pageNo, int pageSize, String Sort) {
        logger.info("分页查询文章");
        PageModel<ArticleInfo> pageModel;
        try {
            pageModel = articleInfoService.selectByPage(pattern, pageNo, pageSize,Sort);
        } catch (Exception e) {
            pageModel = null;
            System.out.println(e.getMessage());
        }
        return pageModel;
    }

    @RequestMapping(value = "/existData")
    @ResponseBody
    public boolean existData(int article_id) {
        logger.info("检测是否存在当前临时文章信息");
        boolean flag = false;
        try {
            int num = tempArticleInfoService.existData(article_id);
            if (num > 0)
                flag = true;
        } catch (Exception e) {
            e.printStackTrace();
            flag = false;
        }
        return flag;
    }

    @RequestMapping(value = "/update-article")
    public String jumpPage(@RequestParam("article_id") int article_id, Model model) {
        logger.info("点击修改跳转界面");
        if (article_id > 0) {
            ArticleInfo articleInfo = articleInfoService.get(article_id);
            List<ColumnInfo> list = columnInfoService.selectAll();
            model.addAttribute("articleInfo", articleInfo);
            model.addAttribute("columnInfo", list);
            return "WEB-INF/page/update-article";
        } else {
            return "WEB-INF/page/article";
        }

    }


    @RequestMapping(value = "/loadTempArticle")
    public String loadTempArticle(@RequestParam("article_id") int article_id, Model model) {
        logger.info("加载当前临时文章");
        if (article_id > 0) {
            TempArticleInfo tempArticleInfo = tempArticleInfoService.get(article_id);
            List<ColumnInfo> list = columnInfoService.selectAll();
            model.addAttribute("articleInfo", tempArticleInfo);
            model.addAttribute("columnInfo", list);
            return "WEB-INF/page/update-article";
        } else {
            return "WEB-INF/page/article";
        }

    }

    @RequestMapping(value = "/updateArticle")
    @ResponseBody
    public String updateArticle(ArticleInfo articleInfo, String article_id, String title, String content, String describe, String title_img, String column_id, String label) {
        logger.info("更新当前文章");
        Date update_time = new Date();
        articleInfo.setArticle_id(Integer.valueOf(article_id));
        articleInfo.setTitle(title);
        articleInfo.setContent(content);
        articleInfo.setDescribe(describe);
        articleInfo.setTitle_img(title_img);
        articleInfo.setColumn_id(Integer.valueOf(column_id));
        articleInfo.setLabel(label);
        articleInfo.setUpdate_time(update_time);
        int num = articleInfoService.update(articleInfo);
        return result(num);
    }

    @RequestMapping(value = "/updateTempArticle")
    @ResponseBody
    public String updateTempArticle(TempArticleInfo tempArticleInfo, String article_id, String title, String content, String describe, String title_img, String column_id, String label) {
        logger.info("保存当前临时文章");
        Date update_time = new Date();
        tempArticleInfo.setArticle_id(Integer.valueOf(article_id));
        tempArticleInfo.setTitle(title);
        tempArticleInfo.setContent(content);
        tempArticleInfo.setDescribe(describe);
        tempArticleInfo.setTitle_img(title_img);
        tempArticleInfo.setColumn_id(Integer.valueOf(column_id));
        tempArticleInfo.setLabel(label);
        tempArticleInfo.setPut_state(0);
        tempArticleInfo.setPut_time(update_time);
        tempArticleInfo.setUpdate_time(update_time);
        int exist = tempArticleInfoService.existData(Integer.valueOf(article_id));
        int num = exist > 0 ? tempArticleInfoService.update(tempArticleInfo) : tempArticleInfoService.save(tempArticleInfo);
        return result(num);
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
