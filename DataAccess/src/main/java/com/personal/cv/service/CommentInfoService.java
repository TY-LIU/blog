package com.personal.cv.service;

import com.lang.PageModel;
import com.personal.cv.entity.CommentInfo;

import java.util.List;

public interface CommentInfoService {
    int selectCount(String pattern);

    PageModel<CommentInfo> selectByPage(String pattern, int pageNo, int pageSize, String Sort);

    CommentInfo get(int article_id);

    int delete(String ids);

    List seeReply(int comment_id);
}
