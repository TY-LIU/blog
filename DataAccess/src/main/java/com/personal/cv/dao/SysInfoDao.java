package com.personal.cv.dao;

import com.personal.cv.entity.SysInfo;

import java.util.List;


public interface SysInfoDao extends BaseDao<SysInfoDao> {

    List<SysInfo> selectAll();

}
