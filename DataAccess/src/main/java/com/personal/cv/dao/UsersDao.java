package com.personal.cv.dao;

import com.personal.cv.entity.User_auths;
import com.personal.cv.entity.Users;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface UsersDao extends BaseDao<Users> {

    int register(Users users);

    int enable(int id);

    int disEnable(int id);

    int updateUser(@Param("users") Users users, @Param("user_auths") User_auths user_auths);

    List seeUser(@Param("id") int user_id);

    int selectByNickName(String nickname);

    Users selectByQQid(String qq_id);

    List<Map<String, Object>> getByUser(int userId);

    int editByUser(Users users);
}
