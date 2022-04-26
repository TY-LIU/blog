package com.personal.cv.service.impl;

import com.lang.PageModel;
import com.personal.cv.dao.NoticeDao;
import com.personal.cv.entity.Notice;
import com.personal.cv.service.NoticeService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class NoticeServiceImpl implements NoticeService {
    @Resource
    private NoticeDao noticeDao;

    @Override
    public int save(Notice notice) {
        return noticeDao.save(notice);
    }

    @Override
    public int delete(String ids) {
        return noticeDao.delete(ids.split(","));
    }

    @Override
    public int update(Notice notice) {
        return noticeDao.update(notice);
    }

    @Override
    public Notice get(int notice_id) {
        return noticeDao.get(notice_id);
    }

    @Override
    public int selectCount(String pattern) {
        return noticeDao.selectCount(pattern);
    }

    @Override
    public PageModel<Notice> selectByPage(String pattern, int pageNo, int pageSize, String Sort) {
        PageModel<Notice> pageModel = new PageModel<>();
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
        List<Notice> list = noticeDao.select(pattern, (pageNo - 1) * pageSize, pageSize, Sort);
        pageModel.setData(list);
        return pageModel;
    }
}
