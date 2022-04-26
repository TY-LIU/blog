package com.personal.cv.service;

import com.lang.PageModel;
import com.personal.cv.entity.LoginInfo;

import java.util.List;


public interface LoginInfoService {

    int save(LoginInfo loginInfo);

    List loginState();

    int selectCount(String pattern);

    PageModel selectByPage(String pattern, int pageNo, int pageSize, String Sort);

    int delete(String ids);

    int deleteByCurrent(int user_id);

    int deleteAll();
}
