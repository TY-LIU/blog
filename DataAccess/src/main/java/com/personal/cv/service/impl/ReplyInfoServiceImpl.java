package com.personal.cv.service.impl;

import com.personal.cv.dao.ReplyInfoDao;
import com.personal.cv.entity.ReplyInfo;
import com.personal.cv.service.ReplyInfoService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ReplyInfoServiceImpl implements ReplyInfoService {
    @Resource
    private ReplyInfoDao replyInfoDao;

    @Override
    public int save(ReplyInfo replyInfo) {
        return replyInfoDao.save(replyInfo);
    }

    @Override
    public int delete(String ids) {
        return replyInfoDao.delete(ids.split(","));
    }

    @Override
    public List detailReply(int reply_id) {
        return replyInfoDao.detailReply(reply_id);
    }
}
