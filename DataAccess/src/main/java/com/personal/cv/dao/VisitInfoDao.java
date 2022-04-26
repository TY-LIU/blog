package com.personal.cv.dao;


import com.personal.cv.entity.VisitInfo;

import java.util.List;

public interface VisitInfoDao extends BaseDao<VisitInfo> {
    int updateVisitClickDate(VisitInfo visitInfo);

    int updateYetVisitClickDate(VisitInfo visitInfo);

    int insertVisitClickDate();

    List statistics();
}
