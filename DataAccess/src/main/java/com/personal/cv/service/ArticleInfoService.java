package com.personal.cv.service;

import com.lang.PageModel;
import com.personal.cv.entity.ArticleInfo;

public interface ArticleInfoService {
    int selectCount(String pattern);

    PageModel<ArticleInfo> selectByPage(String pattern, int pageNo, int pageSize, String Sort);

    ArticleInfo get(int article_id);

    int update(ArticleInfo articleInfo);

    int save(ArticleInfo articleInfo);

    int delete(String ids);
}
