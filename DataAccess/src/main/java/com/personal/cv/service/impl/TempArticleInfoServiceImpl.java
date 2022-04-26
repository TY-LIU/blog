package com.personal.cv.service.impl;

import com.personal.cv.dao.TempArticleInfoDao;
import com.personal.cv.entity.TempArticleInfo;
import com.personal.cv.service.TempArticleInfoService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class TempArticleInfoServiceImpl implements TempArticleInfoService {

    @Resource
    private TempArticleInfoDao tempArticleInfoDao;

    @Override
    public int existData(int article_id) {
        return tempArticleInfoDao.existData(article_id);
    }

    @Override
    public int save(TempArticleInfo tempArticleInfo) {
        return tempArticleInfoDao.save(tempArticleInfo);
    }

    @Override
    public int update(TempArticleInfo tempArticleInfo) {
        return tempArticleInfoDao.update(tempArticleInfo);
    }

    @Override
    public TempArticleInfo get(int article_id) {
        return tempArticleInfoDao.get(article_id);
    }

    @Override
    public int saveOrUpdate(TempArticleInfo tempArticleInfo) {
        return tempArticleInfoDao.saveOrUpdate(tempArticleInfo);
    }
}
