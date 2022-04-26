package com.personal.cv.service;

import com.lang.PageModel;
import com.personal.cv.entity.User_auths;
import com.personal.cv.entity.Users;

import java.util.List;
import java.util.Map;


public interface UserService {

    Users get(int id);

    List seeUser(int user_id);

    int selectCount(String pattern);

    PageModel selectByPage(String pattern, int pageNo, int pageSize, String Sort);

    int updateEnable(int id);

    int updateDisEnable(int id);

    int updateUser(Users users, User_auths user_auths);

    int delete(String ids);

    int save(Users users);

    int register(Users users);

    int selectByNickName(String nickname);

    Users selectByQQid(String token);

    List<Map<String, Object>> getByUser(int userId);

    int editByUser(Users users);
}
