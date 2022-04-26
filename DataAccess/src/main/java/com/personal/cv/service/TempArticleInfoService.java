package com.personal.cv.service;

import com.personal.cv.entity.TempArticleInfo;

public interface TempArticleInfoService {

    int existData(int article_id);

    TempArticleInfo get(int article_id);

    int save(TempArticleInfo tempArticleInfo);

    int update(TempArticleInfo tempArticleInfo);

    int saveOrUpdate(TempArticleInfo tempArticleInfo);
}
