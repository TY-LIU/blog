package com.personal.cv.service.impl;

import com.personal.cv.dao.EnjoyInfoDao;
import com.personal.cv.entity.EnjoyInfo;
import com.personal.cv.service.EnjoyInfoService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service
public class EnjoyInfoServiceImpl implements EnjoyInfoService {

    @Resource
    private EnjoyInfoDao enjoyInfoDao;

    @Override
    public List selectAll() {
        return enjoyInfoDao.selectAll();
    }

    @Override
    public int save(EnjoyInfo enjoyInfo) {
        return enjoyInfoDao.save(enjoyInfo);
    }

    @Override
    public int delete(EnjoyInfo enjoyInfo) {
        return enjoyInfoDao.delete(enjoyInfo);
    }

    @Override
    public int selectKey(EnjoyInfo enjoyInfo) {
        return enjoyInfoDao.selectKey(enjoyInfo);
    }

    @Override
    public int saveMap(Map map) {
        return enjoyInfoDao.saveMap(map);
    }
}
