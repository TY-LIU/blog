package com.personal.cv.dao;

import com.personal.cv.entity.TempArticleInfo;

public interface TempArticleInfoDao extends BaseDao<TempArticleInfo> {
    int saveOrUpdate(TempArticleInfo tempArticleInfo);
}
