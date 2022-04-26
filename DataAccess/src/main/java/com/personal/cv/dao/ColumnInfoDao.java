package com.personal.cv.dao;

import com.personal.cv.entity.ColumnInfo;

import java.util.List;


public interface ColumnInfoDao extends BaseDao<ColumnInfo> {

    List<ColumnInfo> selectAll();
}
