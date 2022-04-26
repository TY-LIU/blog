package com.personal.cv.service;

import com.personal.cv.entity.ColumnInfo;

import java.util.List;


public interface ColumnInfoService {
    int save(ColumnInfo columnInfo);

    /*逻辑删除*/
    int delete(String ids);

    int update(ColumnInfo columnInfo);

    ColumnInfo get(int id);

    List<ColumnInfo> selectAll();
}
