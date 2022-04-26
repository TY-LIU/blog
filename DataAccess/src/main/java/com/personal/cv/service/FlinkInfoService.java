package com.personal.cv.service;

import com.lang.PageModel;
import com.personal.cv.entity.FlinkInfo;


public interface FlinkInfoService {

    int save(FlinkInfo flinkInfo);

    //逻辑删除
    int delete(String ids);

    int update(FlinkInfo flinkInfo);

    int selectCount(String pattern);

    PageModel<FlinkInfo> selectByPage(String pattern, int pageNo, int pageSize, String Sort);

    FlinkInfo get(int flink_id);
}
