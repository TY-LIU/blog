package com.personal.cv.service.impl;

import com.lang.PageModel;
import com.personal.cv.entity.ArticleInfo;
import com.personal.cv.service.ArticleInfoService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ArticleInfoServiceImpl implements ArticleInfoService {

    @Resource
    private com.personal.cv.dao.ArticleInfoDao ArticleInfoDao;

    @Override
    public int selectCount(String pattern) {
        return ArticleInfoDao.selectCount(pattern);
    }

    @Override
    public PageModel<ArticleInfo> selectByPage(String pattern, int pageNo, int pageSize, String Sort) {
        PageModel<ArticleInfo> pageModel = new PageModel<>();
        pageSize = pageSize == 0 ? 10 : pageSize;
        pageModel.setPageSize(pageSize);
        pattern = "%" + (pattern == null ? "" : pattern) + "%";
        int count = selectCount(pattern);
        pageModel.setTotalRecords(count);
        pageNo = pageModel.getTotalPages() < pageNo ? pageModel.getTotalPages() : pageNo;
        pageNo = pageNo == 0 ? 1 : pageNo;
        pageModel.setPageNo(pageNo);
        if (count == 0)
            return pageModel;
        List<ArticleInfo> list = ArticleInfoDao.select(pattern, (pageNo - 1) * pageSize, pageSize,Sort);
        pageModel.setData(list);
        return pageModel;
    }

    @Override
    public ArticleInfo get(int article_id) {
        return ArticleInfoDao.get(article_id);
    }

    @Override
    public int update(ArticleInfo articleInfo) {
        return ArticleInfoDao.update(articleInfo);
    }

    @Override
    public int save(ArticleInfo articleInfo) {
        return ArticleInfoDao.save(articleInfo);
    }

    @Override
    public int delete(String ids) {
        return ArticleInfoDao.delete(ids.split(","));
    }
}
