package com.personal.cv.service;

import com.lang.PageModel;
import com.personal.cv.entity.MessageInfo;

import java.util.List;

public interface MessageInfoService {

    int addMessage(MessageInfo messageInfo);

    int selectCount(String pattern);

    int selectByAuthorCount();

    int selectCountByUser(int userId);

    MessageInfo getMessage(int messageId);

    PageModel selectByPage(String pattern, int pageNo, int pageSize);

    PageModel selectByIndex(int pageNo, int pageSize, String sort, String author);

    PageModel selectByUser(int pageNo, int pageSize, int userId);

    List seeMessage(int message_id);

    List seeReply(int message_id);

    int delete(String ids);

    int updateEnjoy(MessageInfo messageInfo);

    /*前台方法*/
    int delMessage(int userId, int messageId);
}
