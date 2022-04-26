package com.personal.cv.service;

import com.lang.PageModel;
import com.personal.cv.entity.M_replyInfo;

import java.util.List;

public interface M_replyInfoService {

    int countByMessage(int message_id);

    int save(M_replyInfo m_replyInfo);

    M_replyInfo getReply(int reply_id);

    int delete(String ids);

    List detailReply(int reply_id);

    /**
     * 根据留言ID查询下面前四条回复
     * */
    List selectByMessageId(String ids);

    /**
     * 前台回复数据分页查询
     * */
    PageModel selectReply(int pageNo, int pageSize,int message_id);

    /**
     * 前台方法删除留言回复
     * */
    int delReply(int userId, int reply_id);

    PageModel selectByUser(int pageNo, int pageSize, int userId);

    int selectCountByUser(int userId);
}
