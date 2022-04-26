package com.personal.cv.service;

import com.personal.cv.entity.EnjoyInfo;

import java.util.List;
import java.util.Map;

public interface EnjoyInfoService {
    List selectAll();

    int save(EnjoyInfo enjoyInfo);

    int delete(EnjoyInfo enjoyInfo);

    int selectKey(EnjoyInfo enjoyInfo);

    int saveMap(Map map);
}
