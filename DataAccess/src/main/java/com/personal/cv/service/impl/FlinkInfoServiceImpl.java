package com.personal.cv.service.impl;

import com.lang.PageModel;
import com.personal.cv.dao.FlinkInfoDao;
import com.personal.cv.entity.FlinkInfo;
import com.personal.cv.service.FlinkInfoService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class FlinkInfoServiceImpl implements FlinkInfoService {
    @Resource
    private FlinkInfoDao flinkInfoDao;

    @Override
    public int selectCount(String pattern) {
        return flinkInfoDao.selectCount(pattern);
    }

    @Override
    public PageModel<FlinkInfo> selectByPage(String pattern, int pageNo, int pageSize, String Sort) {
        PageModel<FlinkInfo> pageModel = new PageModel<>();
        pageSize = pageSize == 0 ? 10 : pageSize;
        pageModel.setPageSize(pageSize);
        pattern = "%" + (pattern == null ? "" : pattern) + "%";
        int count = selectCount(pattern);
        pageModel.setTotalRecords(count);
        pageNo = pageModel.getTotalPages() < pageNo ? pageModel.getTotalPages() : pageNo;
        pageNo = pageNo == 0 ? 1 : pageNo;
        pageModel.setPageNo(pageNo);
        if (count == 0)
            return pageModel;
        List<FlinkInfo> list = flinkInfoDao.select(pattern, (pageNo - 1) * pageSize, pageSize, Sort);
        pageModel.setData(list);
        return pageModel;
    }

    @Override
    public int save(FlinkInfo flinkInfo) {
        return flinkInfoDao.save(flinkInfo);
    }

    @Override
    public int delete(String ids) {
        return flinkInfoDao.delete(ids.split(","));
    }

    @Override
    public int update(FlinkInfo flinkInfo) {
        return flinkInfoDao.update(flinkInfo);
    }

    @Override
    public FlinkInfo get(int flink_id) {
        return flinkInfoDao.get(flink_id);
    }
}
