package com.personal.cv.service.impl;

import com.lang.PageModel;
import com.personal.cv.dao.M_replyInfoDao;
import com.personal.cv.entity.M_replyInfo;
import com.personal.cv.entity.Users;
import com.personal.cv.service.M_replyInfoService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;

@Service
public class M_replyInfoServiceImpl implements M_replyInfoService {
    @Resource
    private M_replyInfoDao m_replyInfoDao;

    @Override
    public int save(M_replyInfo m_replyInfo) {
        return m_replyInfoDao.save(m_replyInfo);
    }

    @Override
    public M_replyInfo getReply(int reply_id) {
        return m_replyInfoDao.get(reply_id);
    }

    @Override
    public int delete(String ids) {
        return m_replyInfoDao.delete(ids.split(","));
    }

    @Override
    public List detailReply(int reply_id) {
        return m_replyInfoDao.detailReply(reply_id);
    }

    @Override
    public List selectByMessageId(String ids) {
        return m_replyInfoDao.selectByMessageId(ids.split(","));
    }

    @Override
    public int countByMessage(int message_id) {
        return m_replyInfoDao.countByMessage(message_id);
    }

    @Override
    public PageModel selectReply(int pageNo, int pageSize,int message_id) {
        PageModel pageModel = new PageModel<>();
        pageSize = pageSize == 0 ? 10 : pageSize;
        pageModel.setPageSize(pageSize);
        int count = countByMessage(message_id);
        pageModel.setTotalRecords(count);
        pageNo = pageModel.getTotalPages() < pageNo ? pageModel.getTotalPages() : pageNo;
        pageNo = pageNo == 0 ? 1 : pageNo;
        pageModel.setPageNo(pageNo);
        if (count == 0)
            return pageModel;
        List list = m_replyInfoDao.selectByPage((pageNo - 1) * pageSize, pageSize,message_id);
        pageModel.setData(list);
        return pageModel;
    }

    @Override
    public int delReply(int userId, int reply_id) {
        return m_replyInfoDao.delReply(userId,reply_id);
    }

    @Override
    public PageModel selectByUser(int pageNo, int pageSize, int userId) {
        PageModel pageModel = new PageModel<>();
        pageSize = pageSize == 0 ? 10 : pageSize;
        pageModel.setPageSize(pageSize);
        int count = selectCountByUser(userId);
        pageModel.setTotalRecords(count);
        pageNo = pageModel.getTotalPages() < pageNo ? pageModel.getTotalPages() : pageNo;
        pageNo = pageNo == 0 ? 1 : pageNo;
        pageModel.setPageNo(pageNo);
        if (count == 0)
            return pageModel;
        List<HashMap<String, Object>> list = m_replyInfoDao.selectByUser((pageNo - 1) * pageSize, pageSize,userId);
        pageModel.setData(list);
        return pageModel;
    }

    @Override
    public int selectCountByUser(int userId) {
        return m_replyInfoDao.selectCountByUser(userId);
    }
}
