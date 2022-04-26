package com.personal.cv.service.impl;

import com.personal.cv.dao.ColumnInfoDao;
import com.personal.cv.entity.ColumnInfo;
import com.personal.cv.service.ColumnInfoService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ColumnInfoServiceImpl implements ColumnInfoService {
    @Resource
    private ColumnInfoDao columnInfoDao;

    @Override
    public int save(ColumnInfo columnInfo) {

        return columnInfoDao.save(columnInfo);
    }

    @Override
    public int delete(String ids) {
        return columnInfoDao.delete(ids.split(","));
    }

    @Override
    public ColumnInfo get(int id) {
        return columnInfoDao.get(id);
    }

    @Override
    public int update(ColumnInfo columnInfo) {
        return columnInfoDao.update(columnInfo);
    }

    @Override
    public List<ColumnInfo> selectAll() {
        return columnInfoDao.selectAll();
    }
}
