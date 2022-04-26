package com.personal.cv.service.impl;

import com.lang.PageModel;
import com.personal.cv.dao.CommentInfoDao;
import com.personal.cv.entity.CommentInfo;
import com.personal.cv.service.CommentInfoService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class CommentInfoServiceImpl implements CommentInfoService {

    @Resource
    private CommentInfoDao commentInfoDao;

    @Override
    public int selectCount(String pattern) {
        return commentInfoDao.selectCount(pattern);
    }

    @Override
    public PageModel<CommentInfo> selectByPage(String pattern, int pageNo, int pageSize, String Sort) {
        PageModel<CommentInfo> pageModel = new PageModel<>();
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
        List<CommentInfo> list = commentInfoDao.select(pattern, (pageNo - 1) * pageSize, pageSize,Sort);
        pageModel.setData(list);
        return pageModel;
    }

    @Override
    public CommentInfo get(int comment_id) {
        return commentInfoDao.get(comment_id);
    }

    @Override
    public int delete(String ids) {
        return commentInfoDao.delete(ids.split(","));
    }

    @Override
    public List seeReply(int comment_id) {
        return commentInfoDao.seeReply(comment_id);
    }
}
