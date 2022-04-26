package com.personal.cv.service;

import com.lang.PageModel;
import com.personal.cv.entity.Notice;


public interface NoticeService {
    int selectCount(String pattern);

    int save(Notice notice);

    //逻辑删除
    int delete(String ids);

    int update(Notice notice);

    Notice get(int notice_id);

    PageModel<Notice> selectByPage(String pattern, int pageNo, int pageSize, String Sort);


}
