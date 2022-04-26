package com.personal.cv.service;

import com.personal.cv.entity.ReplyInfo;

import java.util.List;

public interface ReplyInfoService {

    int save(ReplyInfo replyInfo);

    int delete(String ids);

    List detailReply(int reply_id);
}
