package com.personal.cv.service.impl;

import com.personal.cv.dao.SysInfoDao;
import com.personal.cv.entity.SysInfo;
import com.personal.cv.service.SysInfoService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class SysInfoServiceImpl implements SysInfoService {
    @Resource
    private SysInfoDao sysInfoDao;

    @Override
    public List<SysInfo> selectAll() {
        return sysInfoDao.selectAll();
    }
}
