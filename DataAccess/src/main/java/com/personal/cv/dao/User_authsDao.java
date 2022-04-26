package com.personal.cv.dao;

import com.personal.cv.entity.User_auths;

public interface User_authsDao extends BaseDao<User_auths> {

    User_auths selectByIdentifier(User_auths user_auths);

    int existIdentifier(String identifier);

    int existQQid(String openID);
}
