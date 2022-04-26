package com.personal.cv.dao;


import com.personal.cv.entity.EnjoyInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface EnjoyInfoDao extends BaseDao<EnjoyInfo> {
    List selectAll();

    int delete(EnjoyInfo enjoyInfo);

    int selectKey(EnjoyInfo enjoyInfo);

    int saveMap(@Param("params")Map map);
}
